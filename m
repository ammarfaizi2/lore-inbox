Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUA0RoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUA0RoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:44:21 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:34999 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264874AbUA0RoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:44:17 -0500
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040127155619.7efec284.ak@suse.de>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	 <20040127155619.7efec284.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1075225399.1020.239.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Jan 2004 12:43:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 09:56, Andi Kleen wrote:
> On Mon, 26 Jan 2004 22:05:29 -0500 (EST)
> Jim Houston <jim.houston@comcast.net> wrote:
> > The attached patch updates my kgdb-x86_64-support.patch to work
> > with linux-2.6.2-rc1-mm3.
> 
> I already did this merge yesterday. Didn't you get mail? 

Hi Andi,

No.  I didn't see your mail until this morning.

It looks like we were working in lock step.  I had been meaning to
update the patch so when I saw that Andrew had dropped it from 
2.6.2-rc1-mm3 it seemed like a good time.

I'll leave it to you and Andrew to decide how we should resolve our
conflicting patches.

I'm including my notes on the difference between our patches. 

Jim Houston - Concurrent Computer Corp.

--

arch/x86_64/kernel/kgdb_stub.c
	Lots of white space changes.  I assume these are my fault.

	I use the variable kgdb_enable to decide if the system should
	stop in kgdb on an oops or other failure.  My intention was to
	set this variable when the user connected.  I was doing this
	for serial but not for kgdboe.  

	I removed a \n from print_extra_info.

init/main.c
	This change puts trap_init before parse_args().  I needed this
	for the early entry into kgdb with the gdb command line argument
	to work.

arch/x86_64/boot/compressed/head.S
arch/x86_64/boot/compressed/misc.c
include/linux/config.h
	On the i386 asm/kgdb.h is included from config.h.  These changes
	make the x86_64 do the same.  I'm not a fan of globally
	included header files, but I wanted the x86_64 to work the same
	as the i386.  The asm/kgdb.h provides a stub for
	kgdb_process_breakpoint() avoiding the undefined symbol.

arch/x86_64/kernel/irq.c
	This change is not needed with the change above.


arch/x86_64/Kconfig
arch/x86_64/Kconfig.kgdb
	We used a different approach to selecting DEBUG_INFO.
	I was not really happy with the way select DEBUG_INFO worked.

Makefile
	I added -g to AFLAGS so the .S files get line number info.
	I have a problem where gdb identifies error_exit as being
	in elf_core.h.  I had hoped this would help.  It didn't,
	but I still like this change.

include/linux/bitops.h
	I dropped this one.  I suspect that this fixed a compile 
	warning in a forgotten Concurrent tree.

include/asm-x86_64/kgdb_local.h
	This file seems to be missing from your patch.  Maybe I'm 
	missing something.  In my patch it is a copy of the i386
	version.




