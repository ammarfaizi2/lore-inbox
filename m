Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULDWf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULDWf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbULDWf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:35:28 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:20935 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261181AbULDWfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:35:12 -0500
Message-ID: <32786.192.168.1.5.1102199522.squirrel@192.168.1.5>
In-Reply-To: <20041203205807.GA25578@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
    <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
    <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
    <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
    <20041203205807.GA25578@elte.hu>
Date: Sat, 4 Dec 2004 22:32:02 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 04 Dec 2004 22:35:10.0314 (UTC) FILETIME=[834ACCA0:01C4DA51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.32-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>

I have a bug to report, it shows on both of my machines (SMP and UP) now
running RT-V0.7.32-2. It seems to be present also on previous RT releases,
and don't even know if it's upstream.

When one usb-storage flash stick is first time unplugged:

usb 4-6: USB disconnect, address 4
slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free all
objects
 [<c010361f>] dump_stack+0x23/0x25 (20)
 [<c01467d7>] kmem_cache_destroy+0x103/0x1aa (28)
 [<c026e77a>] scsi_destroy_command_freelist+0x97/0xa8 (28)
 [<c026f5b1>] scsi_host_dev_release+0x37/0xe1 (104)
 [<c023c6a9>] device_release+0x7a/0x7c (32)
 [<c01efd90>] kobject_cleanup+0x87/0x89 (28)
 [<c01f07eb>] kref_put+0x52/0xef (40)
 [<c01efdcc>] kobject_put+0x25/0x27 (16)
 [<f8cf1843>] usb_stor_release_resources+0x66/0xca [usb_storage] (16)
 [<f8cf1d93>] storage_disconnect+0x8e/0x9b [usb_storage] (16)
 [<f89ca117>] usb_unbind_interface+0x84/0x86 [usbcore] (28)
 [<c023d915>] device_release_driver+0x75/0x77 (28)
 [<c023db18>] bus_remove_device+0x53/0x82 (20)
 [<c023cae1>] device_del+0x4b/0x9b (20)
 [<f89d142a>] usb_disable_device+0xf5/0x10a [usbcore] (28)
 [<f89cc61c>] usb_disconnect+0xc8/0x164 [usbcore] (40)
 [<f89cd77e>] hub_port_connect_change+0x2ef/0x426 [usbcore] (56)
 [<f89cda7b>] hub_events+0x1c6/0x39d [usbcore] (56)
 [<f89cdc89>] hub_thread+0x37/0x109 [usbcore] (96)
 [<c01009b1>] kernel_thread_helper+0x5/0xb (142893076)


Then, just when the same is plugged in again:

usb 4-6: new high speed USB device using ehci_hcd and address 5
kmem_cache_create: duplicate cache scsi_cmd_cache
BUG at mm/slab.c:1447!
------------[ cut here ]------------
kernel BUG at mm/slab.c:1447!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: nls_utf8 nls_cp860 vfat fat nls_base usb_storage
ohci1394 ieee1394 ehci_hcd usbhid uhci_hcd intel_mch_agp agpgart evdev
wacom snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq
snd_usb_usx2y snd_usb_lib snd_hwdep snd_cs46xx snd_rawmidi snd_seq_device
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc
realtime commoncap w83781d i2c_sensor i2c_isa i2c_i801 i2c_core sk98lin
subfs dm_mod usbcore
CPU:    1
EIP:    0060:[<c01462e9>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc2-mm3-RT-V0.7.32-2.0smp)
EIP is at kmem_cache_create+0x4df/0x69c
eax: 00000017   ebx: f7cd9710   ecx: c05c5d00   edx: f77b8000
esi: c030973a   edi: c030973a   ebp: f77b9d10   esp: f77b9cd8
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process khubd (pid: 1477, threadinfo=f77b8000 task=f777c2b0)
Stack: c02f2054 c02f63aa 000005a7 00000565 f77b9d00 f7cd10c0 c0000000
ffffff80
       00000001 f7cd1080 00000080 c03418a0 f7000400 f7000428 f77b9d3c
c026e662
       c030972b 00000180 00000080 00002000 00000000 00000000 f7000490
00000000
Call Trace:
 [<c01035f4>] show_stack+0xb4/0xbc (28)
 [<c010378a>] show_registers+0x169/0x1de (56)
 [<c010399c>] die+0x10b/0x191 (68)
 [<c0103e19>] do_invalid_op+0xba/0xc4 (204)
 [<c0103237>] error_code+0x2b/0x30 (116)
 [<c026e662>] scsi_setup_command_freelist+0x94/0x115 (44)
 [<c026f8ca>] scsi_host_alloc+0x26f/0x399 (124)
 [<f8cf173f>] usb_stor_acquire_resources+0x6c/0x10a [usb_storage] (28)
 [<f8cf1c64>] storage_probe+0x1b8/0x259 [usb_storage] (40)
 [<f89ca07a>] usb_probe_interface+0x62/0x7b [usbcore] (28)
 [<c023d723>] driver_probe_device+0x2f/0x70 (24)
 [<c023d7ae>] device_attach+0x4a/0xa5 (40)
 [<c023da89>] bus_add_device+0x4d/0x89 (28)
 [<c023c9a6>] device_add+0xb1/0x137 (40)
 [<f89d1ba6>] usb_set_configuration+0x3ca/0x444 [usbcore] (84)
 [<f89cc822>] usb_new_device+0xa5/0x164 [usbcore] (44)
 [<f89cd6b0>] hub_port_connect_change+0x221/0x426 [usbcore] (56)
 [<f89cda7b>] hub_events+0x1c6/0x39d [usbcore] (56)
 [<f89cdc89>] hub_thread+0x37/0x109 [usbcore] (96)
 [<c01009b1>] kernel_thread_helper+0x5/0xb (142893076)
Code: e8 57 5e fd ff b8 08 4f be c0 e8 c0 d1 fe ff c7 44 24 08 a7 05 00 00
c7 44 24 04 aa 63 2f c0 c7 04 24 54 20 2f c0 e8 31 5e fd ff <0f> 0b a7 05
aa 63 2f c0 eb b9 a1 44 1a 33 c0 c7 44 24 04 d0 00


After this, any USB related operation is doomed, if not the entire system.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

