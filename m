Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVIVGqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVIVGqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVIVGqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:46:55 -0400
Received: from tornado.reub.net ([202.89.145.182]:52107 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932151AbVIVGqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:46:54 -0400
Message-ID: <4332535D.1010309@reub.net>
Date: Thu, 22 Sep 2005 18:46:53 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050920)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
References: <20050921222839.76c53ba1.akpm@osdl.org>
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/09/2005 5:28 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/
> 
> - Added git tree `git-sas.patch': Luben Tuikov's SAS driver and its support.
> 
> - Various random other things - nothing major.

Overall boots up and looks fine, but still seeing this oops which comes up on 
warm reboot intermittently:

ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci(0000:00:1f.2) flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8802D00 ctl 0x0 bmdma 0x0 irq 193
ata2: SATA max UDMA/133 cmd 0xF8802D80 ctl 0x0 bmdma 0x0 irq 193
ata3: SATA max UDMA/133 cmd 0xF8802E00 ctl 0x0 bmdma 0x0 irq 193
ata4: SATA max UDMA/133 cmd 0xF8802E80 ctl 0x0 bmdma 0x0 irq 193
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
scheduling while atomic: ksoftirqd/0/0x00000100/3
  [<c0103ad0>] dump_stack+0x17/0x19
  [<c031483a>] schedule+0x8ba/0xccb
  [<c0315d17>] __down+0xe5/0x126
  [<c0313f1a>] __down_failed+0xa/0x10
  [<c0233f3d>] .text.lock.main+0x2b/0x3e
  [<c022f90c>] device_del+0x35/0x5d
  [<c025d71e>] scsi_target_reap+0x89/0xa3
  [<c025ed5a>] scsi_device_dev_release+0x114/0x18b
  [<c022f504>] device_release+0x1a/0x5a
  [<c01e15c2>] kobject_cleanup+0x43/0x6b
  [<c01e15f5>] kobject_release+0xb/0xd
  [<c01e1e3c>] kref_put+0x2e/0x92
  [<c01e160b>] kobject_put+0x14/0x16
  [<c022f8d5>] put_device+0x11/0x13
  [<c0256fd8>] scsi_put_command+0x7c/0x9e
  [<c025b918>] scsi_next_command+0xf/0x19
  [<c025b9db>] scsi_end_request+0x93/0xc5
  [<c025bdd4>] scsi_io_completion+0x281/0x46a
  [<c025c1c8>] scsi_generic_done+0x2d/0x3a
  [<c0257746>] scsi_finish_command+0x7f/0x93
  [<c025762b>] scsi_softirq+0xab/0x11c
  [<c0121952>] __do_softirq+0x72/0xdc
  [<c01219f3>] do_softirq+0x37/0x39
  [<c0121eeb>] ksoftirqd+0x9f/0xf4
  [<c012ff37>] kthread+0x99/0x9d
  [<c01010b5>] kernel_thread_helper+0x5/0xb
Unable to handle kernel paging request<5>SCSI device sda: 156301488 512-byte 
hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
  sda: at virtual address 6b6b6b6b
  printing eip:
c025b81f
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c025b81f>]    Not tainted VLI
EFLAGS: 00010292   (2.6.14-rc2-mm1)
EIP is at scsi_run_queue+0x12/0xb8
eax: 6b6b6b6b   ebx: f7c36b70   ecx: 00000000   edx: 00000001
esi: f7c4eb6c   edi: 00000246   ebp: c1911eac   esp: c1911e98
ds: 007b   es: 007b   ss: 0068
Process ksoftirqd/0 (pid: 3, threadinfo=c1910000 task=c1942a90)
Stack: c1baf5f8 f7c36b70 f7c36b70 f7c4eb6c 00000246 c1911eb8 c025b91f f7c386e8
        c1911ed0 c025b9db f7c36b70 f7c4eb6c 00000000 00000000 c1911f28 c025bdd4
        00000001 00004f80 00000100 00000001 c1807ac0 00000000 00000000 00040000
Call Trace:
  [<c0103a83>] show_stack+0x94/0xca
  [<c0103c2c>] show_registers+0x15a/0x1ea
  [<c0103e4a>] die+0x108/0x183
  [<c03166cd>] do_page_fault+0x1ed/0x63d
  [<c0103753>] error_code+0x4f/0x54
  [<c025b91f>] scsi_next_command+0x16/0x19
  [<c025b9db>] scsi_end_request+0x93/0xc5
  [<c025bdd4>] scsi_io_completion+0x281/0x46a
  [<c025c1c8>] scsi_generic_done+0x2d/0x3a
  [<c0257746>] scsi_finish_command+0x7f/0x93
  [<c025762b>] scsi_softirq+0xab/0x11c
  [<c0121952>] __do_softirq+0x72/0xdc
  [<c01219f3>] do_softirq+0x37/0x39
  [<c0121eeb>] ksoftirqd+0x9f/0xf4
  [<c012ff37>] kthread+0x99/0x9d
  [<c01010b5>] kernel_thread_helper+0x5/0xb
Code: fd ff 8b 4d ec 8b 41 44 e8 e4 a6 0b 00 89 45 f0 89 d8 e8 34 c1 ff ff eb 
b2 55 89 e5 57 56 53 83 ec 08 89 45 f0 8b 80 10 01 00 00 <8b> 38 80 b8 85 01 
00 00 00 0f 88 8b 00 00 00 8b 47 44 e8 af a6
  <0>Kernel panic - not syncing: Fatal exception in interrupt
  <0>Rebooting in 60 seconds..


This is not new to this -mm release (I had a screen dump of it 2 weeks ago but 
I suspect it is actually a bit older than that even).

reuben


