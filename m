Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWEBIzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWEBIzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEBIzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:55:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932516AbWEBIzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:55:33 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Arjan van de Ven <arjan@infradead.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20060502085325.GA9190@mail.ustc.edu.cn>
References: <20060502075049.GA5000@mail.ustc.edu.cn>
	 <1146556724.32045.19.camel@laptopd505.fenrus.org>
	 <20060502080619.GA5406@mail.ustc.edu.cn>
	 <1146558617.32045.23.camel@laptopd505.fenrus.org>
	 <20060502085325.GA9190@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Tue, 02 May 2006 10:55:29 +0200
Message-Id: <1146560129.32045.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 16:53 +0800, Wu Fengguang wrote:
> On Tue, May 02, 2006 at 10:30:17AM +0200, Arjan van de Ven wrote:
> > one interesting thing that came out of the fedora readahead work is that
> > most of the bootup isn't actually IO bound. My test machine for example
> > can load all the data into ram in about 10 seconds, so that the rest of
> > the boot is basically IO-less. But that still takes 2 minutes....
> > So I'm not entirely sure how much you can win by just attacking this.
> 
> Yes, I find it hard to improve the boot time of the init.d stage.
> However, it is perfectly ok to preload all GUI staffs during that
> timespan, by overlapping CPU/IO activities.

fwiw fedora even loads a bunch of GUI apps into memory already

> 
> > Another interesting approach would be to actually put all the data you
> > want to use in a non-fragmented, sequential area on disk somehow (there
> > is an OLS paper submitted about that by Ben) so that at least the disk
> > side is seekless... 
> 
> You are right, reducing seeking distances helps not much. My fluxbox
> desktop requires near 3k seeks, which can be loaded in the 20s init.d
> booting time.  But for KDE/GNOME desktops, some defragging would be
> necessary to fit them into the 20s time span.

or just move the blocks (or copy them) to a reserved area...


