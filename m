Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUFXS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUFXS6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUFXS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:58:48 -0400
Received: from mail.icsmail.net ([69.5.139.6]:29657 "EHLO mail.icsmail.net")
	by vger.kernel.org with ESMTP id S264726AbUFXS4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:56:54 -0400
Subject: Re: x86-64 general protection fault in ioremap_nocache() possibly
	related to memory beyond 4GB
From: Steve Holland <sdh4_no_spammers_throwaway_acct@cornell.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1087952903.4010.132.camel@gavroche>
References: <1087952903.4010.132.camel@gavroche>
Content-Type: text/plain
Message-Id: <1088103297.10237.9.camel@gavroche>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Jun 2004 13:54:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same problem
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0406.2/1919.html)
exists with a 2.6.7 kernel.org kernel. 

The full oops message for ohci_hcd on the vanilla 2.6.7:
Jun 24 13:21:00 eponine kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun 24 13:21:00 eponine kernel: ohci_hcd: block sizes: ed 80 td 96
Jun 24 13:21:00 eponine kernel: Unable to handle kernel paging request at 00000000000018f0 RIP: 
Jun 24 13:21:00 eponine kernel: <ffffffff80125335>{ioremap_nocache+197}
Jun 24 13:21:00 eponine kernel: PML4 7eb3b067 PGD 2fa6067 PMD 0 
Jun 24 13:21:00 eponine kernel: Oops: 0000 [1] SMP 
Jun 24 13:21:00 eponine kernel: CPU 0 
Jun 24 13:21:00 eponine kernel: Modules linked in: ohci_hcd ext3 jbd
Jun 24 13:21:00 eponine kernel: Pid: 635, comm: modprobe Not tainted 2.6.7
Jun 24 13:21:00 eponine kernel: RIP: 0010:[<ffffffff80125335>] <ffffffff80125335>{ioremap_nocache+197}
Jun 24 13:21:00 eponine kernel: RSP: 0018:000001017ed2fde8  EFLAGS: 00010213
Jun 24 13:21:00 eponine kernel: RAX: 00000100ff3f6000 RBX: 00000000ff3f6000 RCX: 0000000000000019
Jun 24 13:21:00 eponine kernel: RDX: ffffffff7fffffff RSI: 0000010180000000 RDI: 0000000000000000
Jun 24 13:21:00 eponine kernel: RBP: 0000000000001000 R08: 00000000ff3f7000 R09: 000001017ed2fd3c
Jun 24 13:21:00 eponine kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffff000000d000
Jun 24 13:21:00 eponine kernel: R13: 00000000ff3f6000 R14: 0000000000000000 R15: 0000000000000000
Jun 24 13:21:00 eponine kernel: FS:  0000002a9557a4c0(0000) GS:ffffffff804abe80(0000) knlGS:0000000000000000
Jun 24 13:21:00 eponine kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 24 13:21:00 eponine kernel: CR2: 00000000000018f0 CR3: 0000000000101000 CR4: 00000000000006e0
Jun 24 13:21:00 eponine kernel: Process modprobe (pid: 635, threadinfo 000001017ed2e000, task 000001017ed5a9d0)
Jun 24 13:21:00 eponine kernel: Stack: ffffffffa00343c0 ffffffffa0034340 0000010101c8c000 ffffffff80289178 
Jun 24 13:21:00 eponine kernel:        0000010101c54990 0000000000001000 ffffffff00000008 ffffffffa00362c0 
Jun 24 13:21:00 eponine kernel:        0000010101c8c000 00000000ffffffed 
Jun 24 13:21:00 eponine kernel: Call Trace:<ffffffff80289178>{usb_hcd_pci_probe+280} <ffffffff801eda5d>{pci_device_probe_static+61} 
Jun 24 13:21:00 eponine kernel:        <ffffffff801edab9>{__pci_device_probe+41} <ffffffff801edb10>{pci_device_probe+48} 
Jun 24 13:21:00 eponine kernel:        <ffffffff80235257>{bus_match+71} <ffffffff80235376>{driver_attach+70} 
Jun 24 13:21:00 eponine kernel:        <ffffffff80235620>{bus_add_driver+128} <ffffffff801eddd9>{pci_register_driver+121} 
Jun 24 13:21:00 eponine kernel:        <ffffffffa0038051>{:ohci_hcd:ohci_hcd_pci_init+81} 
Jun 24 13:21:00 eponine kernel:        <ffffffff80151a7e>{sys_init_module+270} <ffffffff8011189a>{system_call+126} 
Jun 24 13:21:00 eponine kernel:        
Jun 24 13:21:00 eponine kernel: 
Jun 24 13:21:00 eponine kernel: Code: 48 8b 8f f0 18 00 00 76 2a 48 b8 00 00 00 80 00 01 00 00 48 
Jun 24 13:21:00 eponine kernel: RIP <ffffffff80125335>{ioremap_nocache+197} RSP <000001017ed2fde8>
Jun 24 13:21:00 eponine kernel: CR2: 00000000000018f0

Once again, removing memory beyond 4GB with a 'mem=' parameter eliminates the problem. 

With the 2.6.7 kernel X no longer causes an oops but instead locks itself up. 
My own driver still has the same problem as ohci_hcd in ioremap_nocache().

I tried disabling the hardware iommu with 'iommu=soft', and that did not have any effect. 
	Steve


Andi Kleen wrote: 
>Steve Holland <sdh4_no_spammers_throwaway_acct@xxxxxxxxxxx> writes:
>> I'm having a memory/io mapping related problem with the 2.6 kernel
>> (as shipped with Fedora Core 2, tested with kernel-2.6.5-1.358
>> and kernel-2.6.6-1.435).
>
>Please try a 2.6.7 kernel.org kernel.
>
>Also your oops messages don't contain registers for some reasons.
>Please post full oops messages next time.

