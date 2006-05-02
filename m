Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWEBIxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWEBIxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWEBIxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:53:14 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31970 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932515AbWEBIxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:53:13 -0400
Message-ID: <346559990.12674@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 16:53:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502085325.GA9190@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <1146556724.32045.19.camel@laptopd505.fenrus.org> <20060502080619.GA5406@mail.ustc.edu.cn> <1146558617.32045.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146558617.32045.23.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:30:17AM +0200, Arjan van de Ven wrote:
> one interesting thing that came out of the fedora readahead work is that
> most of the bootup isn't actually IO bound. My test machine for example
> can load all the data into ram in about 10 seconds, so that the rest of
> the boot is basically IO-less. But that still takes 2 minutes....
> So I'm not entirely sure how much you can win by just attacking this.

Yes, I find it hard to improve the boot time of the init.d stage.
However, it is perfectly ok to preload all GUI staffs during that
timespan, by overlapping CPU/IO activities.

> Another interesting approach would be to actually put all the data you
> want to use in a non-fragmented, sequential area on disk somehow (there
> is an OLS paper submitted about that by Ben) so that at least the disk
> side is seekless... 

You are right, reducing seeking distances helps not much. My fluxbox
desktop requires near 3k seeks, which can be loaded in the 20s init.d
booting time.  But for KDE/GNOME desktops, some defragging would be
necessary to fit them into the 20s time span.

I found ext3 to be rather good filesystem to support poor man's defrag
described by Chris Mason:
        http://www.gelato.unsw.edu.au/archives/git/0504/1690.html
        This certainly can help.  Based on some ideas from andrea I
        made a poor man's defrag script last year that was similar.
        It worked by copying files into a flat dir in the order you
        expected to read them in, deleting the original, then hard
        linking them into their original name.

Make the 'flat dir' as an top level dir would do the trick for ext3.
We have good chance to merge 10k seeks into 3k seeks by this trick :)

Wu
