Return-Path: <linux-kernel-owner+w=401wt.eu-S1425515AbWLHM7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425515AbWLHM7Z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 07:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425520AbWLHM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:59:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2713 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1425519AbWLHM7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:59:25 -0500
Date: Fri, 8 Dec 2006 13:59:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: UML and fastcall/FASTCALL
Message-ID: <20061208125928.GA25427@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML on i386 is now the only case where fastcall/FASTCALL is not a noop.

There are two use cases for fastcall/FASTCALL in UML on i386:


1. optimization for C code
A faster calling convention is used for the functions annotated this way.


2. interfacing with assembler code
But include/asm-um/linkage.h contains the following:

<--  snip  -->

#ifndef __ASM_UM_LINKAGE_H
#define __ASM_UM_LINKAGE_H

#include "asm/arch/linkage.h"


/* <linux/linkage.h> will pick sane defaults */
#ifdef CONFIG_GPROF
#undef FASTCALL
#undef fastcall
#endif

#endif

<--  snip  -->

E.g. if CONFIG_SMP was still available on UML, CONFIG_SMP=y, 
CONFIG_GPROF=y would have some horrible effects when calling the 
functions in arch/i386/lib/semaphore.S.


Are there any benchmark numbers that the existing fastcall/FASTCALL 
annotations in the kernel really make a measurable difference for
C code?

Otherwise, we could use it only for assembler code using this calling 
convention (if there is any used by UML) - and CONFIG_GPROF mustn't 
change this.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

