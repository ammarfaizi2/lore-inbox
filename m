Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVK3CtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVK3CtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVK3CtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:49:12 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:52890 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1750818AbVK3CtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:49:12 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
Date: Wed, 30 Nov 2005 02:53:52 +0000
User-Agent: KMail/1.9
References: <200511281218.17141.luke-jr@utopios.org> <438B70AA.7090805@tmr.com> <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com>
In-Reply-To: <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511300253.53260.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 14:58, you wrote:
> Known problem with ide-scsi, reference counting for "virtual" SCSI host
> is missing (it was always buggy but was exposed in 2.6.x something by
> sr.c changes).

In case it's helpful, here's the error:

Unable to handle kernel NULL pointer dereference at 0000000000000410 RIP:
<ffffffff881d42d2>{:ide_scsi:idescsi_queue+322}
PGD 31418067 PUD 31eb6067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: sr_mod cdrom ide_scsi ipv6 ohci_hcd analog 8250_pnp 8250 
serial_core parport_pc parport floppy radeonfb snd_via82xx gameport 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device snd i2c_viapro ehci_hcd cdc_ether usbnet usbhid 
usblp uhci_hcd sata_via libata scsi_mod skge ohci1394 ieee1394 usbcore 
supermount sk98lin
Pid: 13304, comm: rmmod Tainted: G   M  2.6.14-gentoo-r2-ljr #3
RIP: 0010:[<ffffffff881d42d2>] <ffffffff881d42d2>{:ide_scsi:idescsi_queue+322}
RSP: 0018:ffff810031897908  EFLAGS: 00010016
RAX: 0000000000000000 RBX: ffff81003721f2c0 RCX: 0000000000000000
RDX: 00000000ffffda7e RSI: ffff81003c9038fa RDI: ffff81003721f2ca
RBP: ffff81003c903880 R08: 00000000000004e1 R09: ffff81003c903988
R10: ffff81003e1d2c80 R11: ffffffff80280700 R12: ffff810031fab800
R13: ffffffff80408910 R14: ffff81003c903880 R15: ffff81003721f2c0
FS:  00002aaaaadfeb00(0000) GS:ffffffff80420800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000410 CR3: 0000000032def000 CR4: 00000000000006e0
Process rmmod (pid: 13304, threadinfo ffff810031896000, task ffff810032c78180)
Stack: ffff81003c9038f0 0000000000000282 000000003f8ccb88 00000000000003e0
       ffffffff8807d740 ffff81003bfecee0 ffff81003c903880 ffff81003b315800
       0000000000000000 ffff81003ddd97f8
Call Trace:<ffffffff8807d740>{:scsi_mod:scsi_done+0} 
<ffffffff8807d959>{:scsi_mod:scsi_dispatch_cmd+505}
       <ffffffff88083500>{:scsi_mod:scsi_request_fn+768} 
<ffffffff80277169>{generic_unplug_device+25}
       <ffffffff80277e71>{blk_execute_rq+193} 
<ffffffff80277a53>{blk_rq_bio_prep+51}
       <ffffffff88081ef5>{:scsi_mod:scsi_execute+229} 
<ffffffff881e418f>{:sr_mod:sr_do_ioctl+175}
       <ffffffff881e3f9e>{:sr_mod:sr_packet+30} 
<ffffffff881d8326>{:cdrom:cdrom_get_disc_info+86}
       <ffffffff881d83a7>{:cdrom:cdrom_mrw_exit+39} 
<ffffffff80190d53>{dput+35}
       <ffffffff8019d37e>{simple_unlink+94} 
<ffffffff881d8115>{:cdrom:unregister_cdrom+213}
       <ffffffff881e400d>{:sr_mod:sr_kref_release+93} 
<ffffffff881e3fb0>{:sr_mod:sr_kref_release+0}
       <ffffffff801f68c0>{kref_put+96} 
<ffffffff881e4076>{:sr_mod:sr_remove+70}
       <ffffffff8027074b>{__device_release_driver+107} 
<ffffffff802707c1>{device_release_driver+49}
       <ffffffff8026ff1c>{bus_remove_device+172} 
<ffffffff8026eea8>{device_del+56}
       <ffffffff880865ba>{:scsi_mod:__scsi_remove_device+58}
       <ffffffff88085808>{:scsi_mod:scsi_forget_host+120} 
<ffffffff8807e504>{:scsi_mod:scsi_remove_host+212}
       <ffffffff881d3ffa>{:ide_scsi:ide_scsi_remove+106} 
<ffffffff8027074b>{__device_release_driver+107}
       <ffffffff802708b3>{driver_detach+195} 
<ffffffff80270154>{bus_remove_driver+148}
       <ffffffff80270b8d>{driver_unregister+13} 
<ffffffff8014dd14>{sys_delete_module+500}
       <ffffffff8016ae25>{sys_munmap+85} <ffffffff8010ea86>{system_call+126}


Code: 8b 80 10 04 00 00 a8 01 74 0a 41 0f ba 6f 50 02 4c 8b 73 40
RIP <ffffffff881d42d2>{:ide_scsi:idescsi_queue+322} RSP <ffff810031897908>
CR2: 0000000000000410
 <6>note: rmmod[13304] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000410 RIP:
<ffffffff881d42d2>{:ide_scsi:idescsi_queue+322}
PGD 32e09067 PUD 31d03067 PMD 0
Oops: 0000 [2] PREEMPT
CPU 0
Modules linked in: sr_mod cdrom ide_scsi ipv6 ohci_hcd analog 8250_pnp 8250 
serial_core parport_pc parport floppy radeonfb snd_via82xx gameport 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device snd i2c_viapro ehci_hcd cdc_ether usbnet usbhid 
usblp uhci_hcd sata_via libata scsi_mod skge ohci1394 ieee1394 usbcore 
supermount sk98lin
Pid: 13174, comm: scsi_eh_3 Tainted: G   M  2.6.14-gentoo-r2-ljr #3
RIP: 0010:[<ffffffff881d42d2>] <ffffffff881d42d2>{:ide_scsi:idescsi_queue+322}
RSP: 0018:ffff8100319d9da8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: ffff810036caabc0 RCX: 0000000000000000
RDX: 00000000ffffdf60 RSI: ffff81003c9038f6 RDI: ffff810036caabc6
RBP: ffff81003c903880 R08: 00000000000009c3 R09: ffff81003c903988
R10: 00000000ffffffff R11: 0000000000000101 R12: ffff81003589fe00
R13: ffffffff80408910 R14: ffff81003c903880 R15: ffff810036caabc0
FS:  00002aaaaadfeb00(0000) GS:ffffffff80420800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000410 CR3: 00000000318f4000 CR4: 00000000000006e0
Process scsi_eh_3 (pid: 13174, threadinfo ffff8100319d8000, task 
ffff810031900240)
Stack: ffff81003c9038f0 0000000000000282 0000000000000296 00000000000003e0
       ffffffff880805a0 ffff81003c903880 ffff81003b315800 ffff8100319d9e18
       0000000000000001 ffff81003c903988
Call Trace:<ffffffff880805a0>{:scsi_mod:scsi_eh_done+0} 
<ffffffff88080c6e>{:scsi_mod:scsi_send_eh_cmnd+158}
       <ffffffff8029e5dd>{ide_wait_not_busy+45} 
<ffffffff88080e1f>{:scsi_mod:scsi_eh_tur+175}
       <ffffffff880813e3>{:scsi_mod:scsi_error_handler+851}
       <ffffffff88081090>{:scsi_mod:scsi_error_handler+0} 
<ffffffff80148a70>{keventd_create_kthread+0}
       <ffffffff80148a2d>{kthread+205} <ffffffff8010f52e>{child_rip+8}
       <ffffffff80148a70>{keventd_create_kthread+0} 
<ffffffff80148960>{kthread+0}
       <ffffffff8010f526>{child_rip+0}

Code: 8b 80 10 04 00 00 a8 01 74 0a 41 0f ba 6f 50 02 4c 8b 73 40
RIP <ffffffff881d42d2>{:ide_scsi:idescsi_queue+322} RSP <ffff8100319d9da8>
CR2: 0000000000000410
 <6>note: scsi_eh_3[13174] exited with preempt_count 1

-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
