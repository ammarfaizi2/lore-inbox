Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUILKcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUILKcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUILKcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:32:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9619 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268592AbUILKcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:32:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: swsusp (2.6.9-rc1-mm4 + bigdiff): Unable to handle kernel paging request
Date: Sun, 12 Sep 2004 12:32:48 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409112122.24194.rjw@sisk.pl> <200409112359.43265.rjw@sisk.pl>
In-Reply-To: <200409112359.43265.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121232.48759.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of September 2004 23:59, Rafael J. Wysocki wrote:
> On Saturday 11 of September 2004 21:22, Rafael J. Wysocki wrote:
> > On Saturday 11 of September 2004 11:50, Rafael J. Wysocki wrote:
[- snip -]
> After issuing "echo 4 > /proc/acpi/sleep" I get things similar to this:

Here goes a similar trace of that sort:

Stopping tasks: 
====================================================================|
Freeing memory... done (97366 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
[nosave pfn 0x5ef]swsusp: Need to copy 26830 pages
suspend: (pages needed: 26830 + 512 free: 104049)
[nosave pfn 0x5ef]swsusp: critical section/: done (27086 pages copied)
Unable to handle kernel paging request at ffffffff93d9fdff RIP:
<ffffffff805cd401>{syscall_init+1}
PML4 103027 PGD 105027 PMD 0
Oops: 0002 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg sd_mod sr_mod 
scsi_mod ohci1394 yenta_socket ieee1394 pcmcia_core cpufreq_ud
Pid: 17970, comm: bash Not tainted 2.6.9-rc1-mm4
RIP: 0010:[<ffffffff805cd401>] <ffffffff805cd401>{syscall_init+1}
RSP: 0000:000001000a089e40  EFLAGS: 00010402
RAX: 0000000000000089 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000001000a089e68 RDI: ffffffff804741d0
RBP: ffffffff80487140 R08: 0000000000000000 R09: 0000000000000004
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000003
R13: 0000000000000002 R14: 0000002a955a5000 R15: 0000000000000000
FS:  0000002a95d330a0(0000) GS:ffffffff805c16c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff93d9fdff CR3: 0000000000101000 CR4: 00000000000006e0
Process bash (pid: 17970, threadinfo 000001000a088000, task 0000010016f7aa10)
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

Code: d9 93 ff fd d9 93 ff fe da 93 ff fd da 91 ff fc d9 90 ff fd
RIP <ffffffff805cd401>{syscall_init+1} RSP <000001000a089e40>
CR2: ffffffff93d9fdff

It is easily reproducible.  It suffices to run X with KDE and some apps with 
it and try "echo 4 > /proc/acpi/sleep" to get one of those (100% of the time 
or so).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
