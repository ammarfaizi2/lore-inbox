Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWAQWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWAQWog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWAQWog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:44:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29707 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932454AbWAQWof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:44:35 -0500
Date: Tue, 17 Jan 2006 23:44:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: m.gerth@avm.de
Cc: Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       rtjohnso@eecs.berkeley.edu, akpm@osdl.org, James.Bottomley@SteelEye.com,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Oops in megaraid , kernel 2.6.14, 2.6.15 on x86_64
Message-ID: <20060117224433.GF19398@stusta.de>
References: <OFA777C944.9337E52B-ONC12570C1.0039A0E1-C12570C9.004D661A@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA777C944.9337E52B-ONC12570C1.0039A0E1-C12570C9.004D661A@avm.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

is your problem still present in kernel 2.6.16-rc1?

cu
Adrian


On Wed, Nov 30, 2005 at 03:05:18PM +0100, m.gerth@avm.de wrote:
> Hello
> this is a repost since I have some new information for the Oops described 
> below.
> 
> System:
>         4P Opteron x86_64
>         24GB RAM
>         LSI SCSI-megaraid controller 320-2X
>         Vanilla kernel 2.6.14 oops
> 
> Tested so far: (driver version is same in all kernels)
> 2.6.13 is ok. No Problems.
> 2.6.14 /w boot option mem=4G is also ok!
> 2.6.15-rc2 similiar to 2.6.14?
> 
> -----------------------------------------------------------------------------------------------------------------------------------
> Hello,
> 
> sorry for using this big list of recipients, but I'm not sure, who of you 
> might be the one, who is most interested in the problem.
> 
> I just booted vanilla 2.6.14 on a 4way Opteron (HP DL585) with 24GB RAM. 
> Kernel was compiled with gcc 3.3.5.
> MegaRaid is compiled into kernel.
> While booting and initializing megaraid I get the Oops described in the 
> following picture: 
> 
>         megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
>         megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
>         megaraid: probe new device 0x1000:0x0407:0x1000:0x0532: bus 6:slot 
> 0:func 0
>         GSI 17 sharing vector 0xB1 and IRQ 17
>         ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 32 (level, low) -> IRQ 
> 177
>         megaraid: fw version:[414C] bios version:[H429]
>         scsi0 : LSI Logic MegaRAID driver
>         scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
>         Unable to handle kernel NULL pointer dereference at 
> 00000000000001cd RIP:
>         PGD 0
>         Oops: 0000 [1] SMP
>         CPU 3
>         Modules linked in:
>         Pid: 0, comm: swapper  Not tainted 2.6.14 #13
>         .....
> 
> 
> Tested so far: (driver version is same in all kernels)
> 2.6.13 is ok. No Problems.
> 2.6.14 /w boot option mem=4G is also ok!
> 2.6.15-rc2 similiar to 2.6.14?
> 
> Output 2.6.15-rc2:::
> megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
> megaraid: probe new device 0x1000:0x0407:0x1000:0x0532: bus 6:slot 0:func 
> 0
> GSI 17 sharing vector 0xB1 and IRQ 17
> ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 32 (level, low) -> IRQ 177
> megaraid: fw version:[414C] bios version:[H429]
> scsi0 : LSI Logic MegaRAID driver
> scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
>   Vendor: COMPAQ    Model: PROLIANT 4L2I DT  Rev: 1.86
>   Type:   Processor                          ANSI SCSI revision: 02
> scsi[0]: scanning scsi channel 1 [Phy 1] for non-raid devices
> scheduling while atomic: swapper/0x00000100/0
> 
> Call Trace: <IRQ> <ffffffff8039153a>{schedule+122} 
> <ffffffff80193e0f>{__d_lookup+159}
>        <ffffffff80392e98>{__down+152} 
> <ffffffff8012dee0>{default_wake_function+0}
>        <ffffffff80392c8a>{__down_failed+53} 
> <ffffffff802224d0>{kobject_release+0}
>        <ffffffff802c8260>{.text.lock.main+25} 
> <ffffffff802c2f0d>{device_del+93}
>        <ffffffff802f82ce>{scsi_target_reap+142} 
> <ffffffff802f9aa5>{scsi_device_dev_release+261}
>        <ffffffff802c297c>{device_release+28} 
> <ffffffff80222474>{kobject_cleanup+100}
>        <ffffffff802224d0>{kobject_release+0} 
> <ffffffff80222eb1>{kref_put+129}
>        <ffffffff802f648f>{scsi_end_request+207} 
> <ffffffff802f69ef>{scsi_io_completion+1039}
>        <ffffffff802f1ba6>{scsi_finish_command+150} 
> <ffffffff802f1abd>{scsi_softirq+333}
>        <ffffffff801385eb>{__do_softirq+107} 
> <ffffffff8010ef2b>{call_softirq+31}
>        <ffffffff801107c1>{do_softirq+49} <ffffffff80110784>{do_IRQ+52}
>        <ffffffff8010e14c>{ret_from_intr+0}  <EOI> 
> <ffffffff80391b60>{thread_return+0}
>        <ffffffff8010bb1a>{default_idle+58} <ffffffff8010bd71>{cpu_idle+97}
> 
>   Vendor: COMPAQ    Model: PROLIANT 4L2I DB  Rev: 1.86
>   Type:   Processor                          ANSI SCSI revision: 02
> scsi[0]: scanning scsi channel 2 [virtual] for logical drives
>   Vendor: MegaRAID  Model: LD 0 RAID1  280G  Rev: 414C
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>   Vendor: MegaRAID  Model: LD 1 RAID1  280G  Rev: 414C
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> libata version 1.20 loaded.
> SCSI device sda: 573440000 512-byte hdwr sectors (293601 MB)
> sda: asking for cache data failed
> sda: assuming drive cache: write through
> SCSI device sda: 573440000 512-byte hdwr sectors (293601 MB)
> sda: asking for cache data failed
> sda: assuming drive cache: write through
>  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
> sd 0:2:0:0: Attached scsi disk sda
> SCSI device sdb: 573440000 512-byte hdwr sectors (293601 MB)
> sdb: asking for cache data failed
> sdb: assuming drive cache: write through
> SCSI device sdb: 573440000 512-byte hdwr sectors (293601 MB)
> sdb: asking for cache data failed
> sdb: assuming drive cache: write through
>  sdb: sdb1 sdb2 sdb3
> sd 0:2:1:0: Attached scsi disk sdb
> 
> Thank you for your help in advance,
> Regards,
> Mike Gerth
