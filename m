Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWAMEuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWAMEuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWAMEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:49:59 -0500
Received: from tornado.reub.net ([202.89.145.182]:3013 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751398AbWAMEt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:49:59 -0500
Message-ID: <43C73170.6030504@reub.net>
Date: Fri, 13 Jan 2006 17:49:52 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, htejun@gmail.com, ric@emc.com,
       axboe@suse.de, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <43C55B31.5000201@reub.net>	<20060111194517.GE5373@suse.de>	<20060111195349.GF5373@suse.de>	<43C5D1CA.7000400@reub.net>	<20060112080051.GA22783@htj.dyndns.org>	<43C61598.7050004@reub.net>	<20060112111846.GA19976@htj.dyndns.org>	<43C645ED.40905@reub.net>	<43C64C3B.5070704@emc.com>	<43C64DF6.7060604@reub.net>	<20060112135533.GA29675@htj.dyndns.org>	<43C6AD72.2010101@reub.net> <20060112123253.26ec3e5f.akpm@osdl.org> <43C6C16C.8010506@pobox.com>
In-Reply-To: <43C6C16C.8010506@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2006 9:51 a.m., Jeff Garzik wrote:
> Andrew Morton wrote:
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>
>>> Indeed that seems to fix it.  I've just booted -mm3 and it came up 
>>> with no problems at all.
>>
>>
>> whew.

Still up and running with 9 1/2 hrs uptime on the clock.

>> What about all the other problems?  The oops under ata_device_add()?
>>
>> And is it still saying this?
> 
> ACK the questions...  I confess I dove into this earlier today, and 
> quickly got lost in the multiple bug reports :(  Nothing against Reuben 
> -- we need more motivated bug reporters like him!

See http://www.reub.net/files/kernel/outstanding-kernel-bugs.txt for a list and 
status of things which are affecting me.  I'm trying to keep it up to date so 
that it's useful - at the moment I need to keep a list else things get muddled.

Basically in a nutshell:

1. SATA crashing out when controller not configured:

ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0

Call Trace:
  [<c0103c5d>] show_stack+0x9b/0xc0
  [<c0103de4>] show_registers+0x162/0x1e7
  [<c0103f8f>] die+0x126/0x231
  [<c01140db>] do_page_fault+0x271/0x5b9
  [<c01037df>] error_code+0x4f/0x54
  [<c023cabd>] class_device_del+0xa3/0x156

This is the next serious problem after the barrier/elevator bug which is now 
succesfully resolved.  Maybe half the time I boot up I need to reset hardware as 
this one triggers.
It's a good genuine Intel board with the latest bios, and only started happening 
recently, so I'm not yet convinced it's hardware..


2. SATA 'slow to respond'

Occasionally:

ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 50
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 50
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 50
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 50
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)


3. Various other smaller problems, sky2 "Cannot find PowerManagement capability" 
sometimes, cannot boot with acpi=off and also cannot boot with nosmp on an SMP 
compiled kernel as SATA times out.  Also "uhci_hcd 0000:00:1d.3: Unlink after 
no-IRQ?  Controller is probably using the wrong IRQ."
These are lower priority problems though.

The first ATA bug is a bit of a killer, so I'd appreciate if it could be looked 
at out first. When testing out the barrier problem I had to do quite a good 
number of extra reboots because the box kept oopsing on bootup :(

reuben


