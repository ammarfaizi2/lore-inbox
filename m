Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUIKWIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUIKWIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIKWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:08:18 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:34700 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268330AbUIKWIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:08:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Sat, 11 Sep 2004 23:59:43 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409111150.28457.rjw@sisk.pl> <200409112122.24194.rjw@sisk.pl>
In-Reply-To: <200409112122.24194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409112359.43265.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of September 2004 21:22, Rafael J. Wysocki wrote:
> On Saturday 11 of September 2004 11:50, Rafael J. Wysocki wrote:
> > On Saturday 11 of September 2004 00:29, Pavel Machek wrote:
> [- snip -]
> > 
> > However, I think the problem is with the hardware, not with the driver: if 
> the 
> > sound driver is unloaded before suspend and loaded again after resume, the 
> > box behaves as though it were loaded all the time (ie IRQ #5 goes mad).  
Are 
> > there any boot options that may help get around this?
> 
> Some good news here. :-)
> 

I said this too early. :-(

After issuing "echo 4 > /proc/acpi/sleep" I get things similar to this:

Stopping tasks: 
===========================================================================|
Freeing memory... done (82503 pages freed)
Losing some ticks... checking if CPU frequency changed.
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
[nosave pfn 0x5ef]swsusp: Need to copy 45470 pages
suspend: (pages needed: 45470 + 512 free: 85409)
[nosave pfn 0x5ef]swsusp: critical section/: done (45982 pages copied)
invalid operand: 0000 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg sd_mod sr_mod 
scsi_mod yenta_socket pcmcia_core ohci1394 ieee1394 cpufreq_used
Pid: 17809, comm: bash Not tainted 2.6.9-rc1-mm4
RIP: 0010:[<ffffffff805cd476>] <ffffffff805cd476>{cpu_init+54}
RSP: 0018:0000010000eb3e40  EFLAGS: 00010002
RAX: 0000000000000089 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000010000eb3e68 RDI: ffffffff804741d4
RBP: ffffffff80487140 R08: 0000000000000000 R09: 0000000000000004
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000003
R13: 0000000000000002 R14: 0000002a955a5000 R15: 0000000000000000
FS:  0000002a95d330a0(0000) GS:ffffffff805c16c0(0000) knlGS:0000000055a62e80
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a95653000 CR3: 0000000000101000 CR4: 00000000000006e0
Process bash (pid: 17809, threadinfo 0000010000eb2000, task 000001001c3620f0)
Stack: ffffffff801211d9 0000000000000002 ffffffff80487140 8000895b7e402080
       00000000ffffffff ffffffff8053de00 ffffffff80121448 0000000000000000
       ffffffff80161033 0000000000000002
Call Trace:<ffffffff801211d9>{fix_processor_context+137} 
<ffffffff80121448>{__restore_processor_state+120}
       <ffffffff80161033>{swsusp_suspend+19} 
<ffffffff80161ee4>{pm_suspend_disk+100}
       <ffffffff8015fa26>{enter_state+70} 
<ffffffff803032c4>{acpi_system_write_sleep+107}
       <ffffffff8018ff14>{vfs_write+228} <ffffffff80190053>{sys_write+83}
       <ffffffff80110be2>{system_call+126}

Code: 61 67 6e 69 74 75 64 65 73 00 6e 70 31 2e 30 00 5a 45 52 4f
RIP <ffffffff805cd476>{cpu_init+54} RSP <0000010000eb3e40>

It happens if memory is almost entirely used by applications.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
