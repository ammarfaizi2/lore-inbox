Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSKCUJH>; Sun, 3 Nov 2002 15:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbSKCUHY>; Sun, 3 Nov 2002 15:07:24 -0500
Received: from [195.39.17.254] ([195.39.17.254]:17668 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262464AbSKCUHI>;
	Sun, 3 Nov 2002 15:07:08 -0500
Date: Sun, 3 Nov 2002 21:12:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021103201251.GE27271@elf.ucw.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hrm... I don't think so Alan. The PM ordering is bus driven,
> > so actual bus binding of the disk is it's controller, not
> > the request queue which is the functional binding. It's up to
> > the disk driver to shut down processing of the request queue.
> 
> That requires code in every driver. Duplicated, hard to write, likely to
> be racey code. Thats bad.
> 
> The bigger picture really should be
> 
> ACPI etc	"I want to suspend to disk"
> 
> PM layer
> 		Suspend the non I/O tasks (btw reminds me - eh tasks and
> 			all workqueues may be I/O tasks at times)
> 		Complete all the block I/O queues
> 		Throw out the pages we can evict

...DMA from disk may be still running here...

> 		Write suspend image
> 		
> 		Jump to PM layer "power off" logic
> 
> If you do it that way up then no drivers need to be hacked about.

...and at resume you find out that your memory is not consistent
because DMA was still running when you were doing copy.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
