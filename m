Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbUKQVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUKQVDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUKQVBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:01:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34177 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262528AbUKQU4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:56:31 -0500
Date: Wed, 17 Nov 2004 21:56:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Message-ID: <20041117205602.GO26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain> <20041117153706.GH26240@suse.de> <1100708728.420.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100708728.420.68.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17 2004, Alan Cox wrote:
> On Mer, 2004-11-17 at 15:37, Jens Axboe wrote:
> > > -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> > > +		spin_lock_irqsave(&ide_lock, flags);
> > > +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> > > +		ndelay(400);
> > > +		spin_unlock_irqsave(&ide_lock, flags);
> > >  		return (*handler) (drive);
> > >  	}
> > >  }
> > 
> > What good does the lock do?
> 
> The same as in ide_execute_command - make sure we don't take an IDE
> interrupt that tries to read the state during the delay. That is the old
> 2.4 "may drives shared IRQ random fails" fix and why the lock is taken
> in ide_execute_command.

Ah I see, makes sense. I didn't think about the shared irq case.

-- 
Jens Axboe

