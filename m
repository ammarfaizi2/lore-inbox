Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269148AbUIRHvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269148AbUIRHvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIRHvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:51:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26323 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269148AbUIRHvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:51:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc1-mm5: double fault on resume on Athlon64 w/ NForce 3
Date: Sat, 18 Sep 2004 09:53:20 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <200409132357.13582.rjw@sisk.pl> <20040916204908.GA8772@elf.ucw.cz>
In-Reply-To: <20040916204908.GA8772@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409180953.20690.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 of September 2004 22:49, Pavel Machek wrote:
> Hi!
> 
> > JFYI, I get a double fault on resume on an Athlon64-based box:
> 
> Try the patch I sent to lkml few minutes ago.

Unfortunately, on 2.6.9-rc2-mm1 I'm still getting things like this:

Relocating pagedir .....:::::|
Reading image data (10973 pages): 100% 10973 done.
Stopping tasks: ===|
Freeing memory... done (0 pages freed)
PM: Restoring saved image.
<0>double fault: 0000 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg sd_mod sr_mod 
scsi_mod cpufreq_userspace powernow_k8 thermal processor fd
Pid: 12135, comm: bash Not tainted 2.6.9-rc2-mm1
RIP: 0010:[<ffffffff8012501d>] <ffffffff8012501d>{do_page_fault+1453}
RSP: 0000:000001001fe00008  EFLAGS: 00010006
RAX: 000000001fce9748 RBX: 0000000000000001 RCX: 000ffffffffff000
RDX: 000000001fce9000 RSI: 0000010000000000 RDI: 000001001fe000e8
RBP: 000001001fce9748 R08: 0000000000000000 R09: 000001001fe27e54
R10: 000000000000279d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 000001001c0266e0 R15: 000001001fe000e8
FS:  0000000000000000(0000) GS:ffffffff80552b40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
CR2: 000001001fdffff8 CR3: 0000000000101000 CR4: 00000000000006e0
Process bash (pid: 12135, threadinfo 0000010014062000, task 000001001a517250)
Stack: 000001001fe01000 0000000000000060 000001001fe00060 000001001a517250
       fffefffefffefffe fffefffe00030001 fffefffefffefffe fffefffefffefffe
       fffefffefffefffe fffefffefffefffe
Call Trace:<ffffffff8011154d>{error_exit+0} 
<ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} <ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}
       <ffffffff8011154d>{error_exit+0} <ffffffff8012501d>{do_page_fault+1453}
       <ffffffff8027f5d7>{acpi_os_allocate+12} 
<ffffffff8011154d>{error_exit+0}
       <ffffffff8012501d>{do_page_fault+1453} 
<ffffffff8027f5d7>{acpi_os_allocate+12}


Code: f6 04 06 81 0f 84 52 fc ff ff 48 8b 05 52 ab 3a 00 48 89 c2
RIP <ffffffff8012501d>{do_page_fault+1453} RSP <000001001fe00008>

every second suspend on the average.  I don't even start X, I just suspend the 
box from a console.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
