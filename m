Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264534AbUD1A4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUD1A4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUD1A4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:56:23 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:6805 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264534AbUD1A4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:56:19 -0400
Date: Wed, 28 Apr 2004 02:56:16 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Tim Hockin <thockin@hockin.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <20040428003034.GA20811@hockin.org>
Message-ID: <Pine.LNX.4.44.0404280234520.16809-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Tim Hockin wrote:

> On Wed, Apr 28, 2004 at 02:18:59AM +0200, Robert M. Stockmann wrote:
> > > This is possible with any structure, named or unnamed.  It's called an
> > > ABI, and it's one of the reasons that binary modules suck.  It doesn't
> > > have *anything* to do with unnamed structures.  At all.  And if you think
> > > so, show me code.
> > 
> > here's a example :
> > 
> > http://www.promise.com/support/file/driver/1_fasttrak_tx4000_partial_source_1.00.0.19.zip
> 
> Care to show me where they use unnamed structures, and how it has anything
> to do with binary modules?

fasttrak.h :

/********************************************************************* 
  
   fasttrak.h -- PROMISE FastTrak Controllers device driver for Linux.

   Copyright (C) 2002-2005 PROMISE Technology, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   Bugs/Comments/Suggestions should be mailed to:                            
   support@promise.com.tw

   For more information, goto:
   http://www.promise.com

*********************************************************************/

#ifndef _ft3xx_h
#define _ft3xx_h

#include <linux/version.h>

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
#define ft3xx {							\
	next: NULL,						\
	proc_dir: NULL, 					\
	proc_info: NULL,    				        \
	name: "ft3xx",						\
	detect: ft3xx_detect,					\
	release: ft3xx_release,					\
	ioctl: ft3xx_ioctl,					\
	info: NULL,					        \
	command: NULL,						\
	queuecommand: ft3xx_queuecommand,			\
	eh_abort_handler : ft3xx_abort_eh,			\
	eh_device_reset_handler : ft3xx_reset_eh,		\
	abort: ft3xx_abort,					\
	reset: ft3xx_reset,					\
	slave_attach: NULL,					\
	bios_param: ft3xx_bios_param,				\
	can_queue: Can_Queue,	/* max simultaneous cmds      */\
	this_id: 7,		/* scsi id of host adapter    */\
	sg_tablesize: Max_SG_Table - 2,/* max scatter-gather cmds    */\
	cmd_per_lun: 1,		/* cmds per lun (linked cmds) */\
	present: 0,						\
	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
	use_clustering: 0,					\
        use_new_eh_code: 0, 	/* enable this field next time*/\
        emulated: 0, 						\
        proc_name: "ft3xx" 					\
} 
#else
#define ft3xx {							\
	next: NULL,						\
	proc_dir: NULL, 					\
	proc_info: NULL,    				        \
	name: "ft3xx",						\
	detect: ft3xx_detect,					\
	release: ft3xx_release,					\
	ioctl: ft3xx_ioctl,					\
	info: NULL,					        \
	command: NULL,						\
	queuecommand: ft3xx_queuecommand,			\
	eh_abort_handler : ft3xx_abort_eh,			\
	eh_device_reset_handler : ft3xx_reset_eh,		\
	abort: ft3xx_abort,					\
	reset: ft3xx_reset,					\
	slave_attach: NULL,					\
	bios_param: ft3xx_bios_param,				\
	can_queue: Can_Queue,	/* max simultaneous cmds      */\
	this_id: 7,		/* scsi id of host adapter    */\
	sg_tablesize: Max_SG_Table - 2,	/* max scatter-gather cmds    */\
	cmd_per_lun: 1,		/* cmds per lun (linked cmds) */\
	present: 0,						\
	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
	use_clustering: 0,					\
        use_new_eh_code: 0, 	/* enable this field next time*/\
        emulated: 0, 						\
} 
#endif


#endif /* _ft3xx_h */ 


This header file is needed to be able to link ft3xx.o . In which way binary 
incompatibility is introduced, inside this case is hard to tell. We
will never know i guess , since the type and size of the above components
is hidden inside the binary only part :

-rw-r--r--    1 stock    stock      227757 Oct 13  2003 ftlib.o

Well it works, with gcc-3.x, but not with gcc-2.95.3

> 
> > Opaque types should be no problem. However the complete definition must reside
> > somewhere _inside_ the complete source. Opaque types is even a bless, i agree.
> 
> If you're open, then yes.  If you're not open, you could have the
> definition of the opaque type inside your own closed code, and things will
> still work.  In fact, that's the sane way to do closed structures.
> 

Hardware which uses these things inside its linux drivers, is hardware
i would never run Linux on.

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

