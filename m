Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTL2OOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTL2OOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:14:10 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:52689 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S263448AbTL2OOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:14:06 -0500
Date: Mon, 29 Dec 2003 09:14:14 -0500
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Power PC mac floppy build problem
From: Jay Hlavaty <joe.hlavaty@verizon.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <48120635-3A09-11D8-9D3A-00039398B344@verizon.net>
X-Mailer: Apple Mail (2.553)
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.156.93.242] at Mon, 29 Dec 2003 08:14:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: 2.6-test11 kernel gives ppc build error

fgrep -r "umoddi3" * at the top level of my 2.5 source directory gives 
me:

arch/arm/lib/udivdi3.c
arch/arm26/lib/udivdi3.c
arch/sh/lib/udivdi3.c

start_request is used in:

drivers/block/swim3.c // Super Woz Integrated Machine 3 floppy 
controller found on power macs
drivers/block/swim3_iop.c // SWIM IOP floppy controller on
drivers/cdrom/cdu31a.c // sony CDU-31a interface
drivers/ide/ide-io.c	// IDE I/O functions

start_request is defined in:

drivers/block/swim3.c
drivers/block/swim3_iop.c
drivers/cdrom/cdu31a.c
drivers/ide/ide-io.c	-- comments have FIXME: this function needs a 
rename

I turned off the support for Power Mac floppy in Macintosh devices

Now the kernel builds OK.  Seems to run OK, too, I'll work on the sound 
issues that I seem to be having with modules...

Thanks!

I.

> Right now I am getting an ld error
> LD .tmp_vmlinux1
> drivers/built-in.o(.text+0x2ff6c): In function 'start_request':
> undefined refrence to '__udivdi3'
> drivers/built-in.o(.text+0x2ff6c): relocation truncated to fit:
> R_PPC_REL24 __udivdi3
> drivers/built-in.o(.text+0x2ff84): In function 'start_request':
> undefined refrence to '__umoddi3'
> drivers/built-in.o(.text+0x2ff84): relocation truncated to fit:
> R_PPC_REL24 __umoddi3
>
> make: *** [.tmp_vmlinux1] Error 1

