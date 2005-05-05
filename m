Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVEEWr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVEEWr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 18:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVEEWrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 18:47:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:40334 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262091AbVEEWrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 18:47:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Date: Fri, 6 May 2005 00:47:37 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
References: <20050504221057.1e02a402.akpm@osdl.org> <200505051458.08659.rjw@sisk.pl>
In-Reply-To: <200505051458.08659.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505060047.38250.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 5 of May 2005 14:58, Rafael J. Wysocki wrote:
> On Thursday, 5 of May 2005 07:10, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > 
> > - device mapper updates
> > 
> > - more UML updates
> > 
> > - -mm seems unusually stable at present.
> 
> Well, it does not boot on my box (Athlon64 + NForce3, 64-bit).  Apparently, it
> loops forever in the early stage (ie before displaying the pengiun).  I'll try
> to get more information when I find something to attach to the serial port ...

It took some time, but finally I've got the following:

]--snip--[
Using local APIC timer interrupts.
Detected 12.467 MHz APIC timer.
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
kmem_cache_create: Early error in slab <NULL>
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/slab.c":1219
invalid operand: 0000 [1]
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
RIP: 0010:[<ffffffff80179eeb>] <ffffffff80179eeb>{kmem_cache_create+139}
RSP: 0000:ffff810001ca1eb8  EFLAGS: 00010292
RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000dd3 RDI: ffffffff804167e0
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000008 R12: 0000000000042000
R13: 0000000000000000 R14: 0000ffffffff8010 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8055a840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000004000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810001ca0000, task ffff810001c5a7a0)
Stack: fffffffffffffff8 0000000000000000 0000000000000000 0000000000000000
       0000000000000010 0000000000000000 0000000000000005 0000000000000006
       00000000ffffffff 0000ffffffff8010
Call Trace:<ffffffff8057a11d>{init_bio+93} <ffffffff8010c0f2>{init+178}
       <ffffffff8010fc37>{child_rip+8} <ffffffff8010c040>{init+0}
       <ffffffff8010fc2f>{child_rip+0}

Code: 0f 0b e2 5c 3c 80 ff ff ff ff c3 04 48 8b 7c 24 18 be 20 00
RIP <ffffffff80179eeb>{kmem_cache_create+139} RSP <ffff810001ca1eb8>
 <0>Kernel panic - not syncing: Attempted to kill init!
 <3>BUG: soft lockup detected on CPU#0!

Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
RIP: 0010:[<ffffffff80278fd4>] <ffffffff80278fd4>{__delay+4}
RSP: 0000:ffff810001ca1bc0  EFLAGS: 00000287
RAX: 00000000000bd1ed RBX: 00000000000013b5 RCX: 000000002b039efb
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 00000000001b67a0
RBP: 00000000000013b5 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8055a840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000004000 CR3: 0000000000101000 CR4: 00000000000006e0

Call Trace:<ffffffff80137d69>{panic+377} <ffffffff80139e61>{profile_task_exit+49}
       <ffffffff8013c983>{do_exit+147} <ffffffff80110b16>{show_registers+230}
       <ffffffff802c93f5>{do_unblank_screen+21} <ffffffff80110e35>{die+69}
       <ffffffff801117d1>{do_invalid_op+145} <ffffffff80179eeb>{kmem_cache_create+139}
       <ffffffff801767c0>{check_poison_obj+48} <ffffffff8013803d>{printk+141}
       <ffffffff8010fa81>{error_exit+0} <ffffffff80179eeb>{kmem_cache_create+139}
       <ffffffff80179eeb>{kmem_cache_create+139} <ffffffff8057a11d>{init_bio+93}
       <ffffffff8010c0f2>{init+178} <ffffffff8010fc37>{child_rip+8}
       <ffffffff8010c040>{init+0} <ffffffff8010fc2f>{child_rip+0}


Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
