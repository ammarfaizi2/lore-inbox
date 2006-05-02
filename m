Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWEBLsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWEBLsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWEBLsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:48:42 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:40162 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964786AbWEBLsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:48:41 -0400
Message-ID: <346570518.28689@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 19:48:54 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502114853.GA9983@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <1146556724.32045.19.camel@laptopd505.fenrus.org> <20060502080619.GA5406@mail.ustc.edu.cn> <1146558617.32045.23.camel@laptopd505.fenrus.org> <20060502085325.GA9190@mail.ustc.edu.cn> <1146560129.32045.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146560129.32045.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:55:29AM +0200, Arjan van de Ven wrote:
> > Yes, I find it hard to improve the boot time of the init.d stage.
> > However, it is perfectly ok to preload all GUI staffs during that
> > timespan, by overlapping CPU/IO activities.
> 
> fwiw fedora even loads a bunch of GUI apps into memory already

Hopefully the warm cache time has been improving.
I have very good performance with fluxbox.  Lubos Lunak said
(http://wiki.kde.org/tiki-index.php?page=KDE%20Google%20SoC%202006%20ideas#id106304)
that "KDE startup with cold caches is several times slower than with
warm caches." The latest GNOME release also saw good speedup.

> > > Another interesting approach would be to actually put all the data you
> > > want to use in a non-fragmented, sequential area on disk somehow (there
> > > is an OLS paper submitted about that by Ben) so that at least the disk
> > > side is seekless... 
> > 
> > You are right, reducing seeking distances helps not much. My fluxbox
> > desktop requires near 3k seeks, which can be loaded in the 20s init.d
> > booting time.  But for KDE/GNOME desktops, some defragging would be
> > necessary to fit them into the 20s time span.
> 
> or just move the blocks (or copy them) to a reserved area...

Ah, we can save discontinuous pages into the journal file on umounting
and restore them on mounting. But let's do the simple way first :)

Wu
