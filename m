Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbTABQVl>; Thu, 2 Jan 2003 11:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTABQVl>; Thu, 2 Jan 2003 11:21:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60420 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262415AbTABQVk>;
	Thu, 2 Jan 2003 11:21:40 -0500
Date: Thu, 2 Jan 2003 17:29:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030102162956.GB956@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030102000522.A6137@lst.de> <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com> <20030101235842.A3044@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101235842.A3044@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 11:58:42PM +0000, Christoph Hellwig wrote:
> > Isn't it much nicer to just write this something like
> > 
> > 	proc-mmu-y = proc_mmu.o
> > 	proc-mmu-n = proc_nommu.o
> > 
> > 	obj-y += $(proc-mmu-$(CONFIG_MMU))
> > 
> > instead, and avoid conditionals?
> 
> Could be done.  Maybe Kai even has an even nicer generic version? :)
Here's my try:
Old makefile:
proc-objs    := inode.o root.o base.o generic.o array.o \
                kmsg.o proc_tty.o proc_misc.o kcore.o

ifeq ($(CONFIG_PROC_DEVICETREE),y)
proc-objs    += proc_devtree.o
endif

New Makefile:
proc-y             := proc_mmu.o
proc-$(CONFIG_MMU) := proc_nommu.o

proc-y += inode.o root.o base.o generic.o array.o \
          kmsg.o proc_tty.o proc_misc.o kcore.o

proc-$(CONFIG_PROC_DEVICETREE) += proc_devtree.o

Untested...

	Sam
