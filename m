Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTAVUCr>; Wed, 22 Jan 2003 15:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTAVUCq>; Wed, 22 Jan 2003 15:02:46 -0500
Received: from web80314.mail.yahoo.com ([66.218.79.30]:16045 "HELO
	web80314.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262796AbTAVUCp>; Wed, 22 Jan 2003 15:02:45 -0500
Message-ID: <20030122201149.94950.qmail@web80314.mail.yahoo.com>
Date: Wed, 22 Jan 2003 12:11:49 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030122115641.1be444fa.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Humm, that's a good idea.  I already made the mods
to files to add an #include <asm/if.h>.  That would
be a logical place to stick such macros.  I will
check this out and re-submit the patches if it's
workable.

Maybe this was what Andi meant too.  Originally thought
he meant a script file wrapper for gcc.

Will write back soon,
-Kevin

--- Andrew Morton <akpm@digeo.com> wrote:

> I'm wondering if this can this be done a lot more simply with assembler
> macros.
> 
> The below example generates the right code.  It's then just a matter of
> getting the redefined pushfl and popfl macros into kernel-wide scope. 
> Possibly an explicit `-include' in the makefile system.
> 
> 
> asm("
> 	.macro	popfl
> 	testl	$(1<<9), 0(%esp)
> 	jz	69003f
> 	.byte	0x9d		# popfl
> 	sti
> 	jmp	69004f
> 69003:
> 	.byte	0x9d		# popfl
> 	cli
> 69004:                
> 	.endm
> ");
> 
> foo()
> {
> 	asm("popfl\n");
> }
> 


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
