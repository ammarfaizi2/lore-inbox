Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTABQkx>; Thu, 2 Jan 2003 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTABQkx>; Thu, 2 Jan 2003 11:40:53 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:18699 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264836AbTABQkv>;
	Thu, 2 Jan 2003 11:40:51 -0500
Date: Thu, 2 Jan 2003 17:49:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030102164914.GC956@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030102000522.A6137@lst.de> <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com> <20030101235842.A3044@infradead.org> <20030102162956.GB956@mars.ravnborg.org> <20030102173505.B11900@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102173505.B11900@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 05:35:05PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 02, 2003 at 05:29:56PM +0100, Sam Ravnborg wrote:
> > New Makefile:
> > proc-y             := proc_mmu.o
> > proc-$(CONFIG_MMU) := proc_nommu.o
> >
> 
> Wouldn't this add proc_mmu.o even if CONFIG_MMU is not y?

Ups, you are right. I thought about CONFIG_NOMMU..
Should read:
proc-y := proc_nommu.o
proc-$(CONFIG_MMU) := proc_mmu.o

If CONFIG_MMU is 'y', then the first assignment is overwritten.

The same principle (pattern?), but with reversed logic.
But this one is not that nice, because the common case overwrite the
un-common case.

	Sam
