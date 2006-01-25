Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWAYSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWAYSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWAYSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:49:29 -0500
Received: from mondriaan.macroscoop.nl ([82.94.9.2]:34990 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id S932082AbWAYSt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:49:28 -0500
X-DomainKeys: Sendmail DomainKeys Filter v0.3.0 mondriaan.macroscoop.nl k0PInMC5017952
DomainKey-Signature: a=rsa-sha1; s=mondriaan; d=macroscoop.nl; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=U02CFSCkq+yuJ/25VN/FyJS0OsrQnajV8BW3DG/HdO2VLM1Mdvbnt96+jToZhYj7i
	wOuzzmrY5uKldchta8IAw==
Message-ID: <43D7C831.4050907@macroscoop.nl>
Date: Wed, 25 Jan 2006 19:49:21 +0100
From: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: oops reading from Nakamichi SCSI CD changer
References: <43A8247C.7000903@macroscoop.nl>
In-Reply-To: <43A8247C.7000903@macroscoop.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oops that I previously posted occured when I tried to read a data CD
or rip an audio CD. But I also got random lockups, only when logged into
the console. These stopped now I disconnected the SCSI CD changers.

Maybe this was Gnome trying to figure whether a CD has been inserted.

Here's an oops I grabbed from the serial console after a random lockup:

general protection fault: 0000 [1] SMP
CPU 1
Modules linked in: esp4 ah4 parport_pc lp parport rfcomm l2cap sunrpc 
deflate zlib_deflate twofish serpent aes blowfish des sha256 crypto_null 
af_key ip_nat_ftp ip_conntrack_ftp iptable_mangle ipt_state 
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink 
ip_tables ip6table_mangle ip6table_filter ip6_tables ipv6 yealink 
hci_usb bluetooth usblp reiserfs vfat fat dm_mod video button battery ac 
ohci1394 ieee1394 ohci_hcd ehci_hcd dvb_ttpci l64781 saa7146_vv 
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299 
dvb_core tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom i2c_nforce2 
i2c_core shpchp snd_ca0106 snd_rawmidi snd_ac97_codec snd_seq_dummy 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus 
snd_page_alloc prism54 sk98lin forcedeth floppy sr_mod ext3 jbd 
usb_storage sata_sil24 sata_nv libata aic7xxx scsi_transport_spi sd_mod 
scsi_mod
Pid: 4542, comm: hald-addon-stor Not tainted 2.6.15.1 #1
RIP: 0010:[<ffffffff8036d739>] <ffffffff8036d739>{schedule+2729}
RSP: 0018:ffff81010862b898  EFLAGS: 00010087
RAX: 0000000000014b00 RBX: ffff81010bca0ab0 RCX: ffff81010bca0ab0
RDX: cccccccc4d1e79cc RSI: 000002849effe740 RDI: ffff81010bca0ab0
RBP: ffff81010862b968 R08: 0000000000000000 R09: ffff8100c908f340
R10: 0000000000000002 R11: ffffffff8020d9d0 R12: 0000000000000000
R13: 0000000000000001 R14: ffff81000c00b8e0 R15: 000002849effe740
FS:  00002aaaaaacf900(0000) GS:ffffffff804b3880(0000) knlGS:00000000555776c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaaac000 CR3: 0000000108627000 CR4: 00000000000006e0
Process hald-addon-stor (pid: 4542, threadinfo ffff81010862a000, task 
ffff81010bca0ab0)
Stack: ffff8101278132d8 ffff8100c3c4eb40 ffff810127813000 0000000000001056
       ffff810127813000 ffffffff880077e0 0000000000000001 ffff8101276fbd48
       0000000000000292 0000000000019b16
Call Trace:<ffffffff880077e0>{:scsi_mod:scsi_request_fn+880} 
<ffffffff88007c23>{:scsi_mod:scsi_queue_insert+195}
       <ffffffff8036dd68>{cond_resched+72} 
<ffffffff8036e187>{wait_for_completion+23}
       <ffffffff8020653c>{blk_execute_rq+204} 
<ffffffff802093b5>{get_request_wait+53}
       <ffffffff88005c70>{:scsi_mod:scsi_execute+224} 
<ffffffff88005d44>{:scsi_mod:scsi_execute_req+164}
       <ffffffff88006729>{:scsi_mod:scsi_test_unit_ready+73}
       <ffffffff880c25fe>{:sr_mod:sr_media_change+78} 
<ffffffff802bffdb>{media_changed+75}
       <ffffffff8018e0c7>{check_disk_change+39} 
<ffffffff802c179e>{cdrom_open+2494}
       <ffffffff801a0bc5>{__d_lookup+165} <ffffffff80195985>{do_lookup+117}
       <ffffffff8019f8ff>{dput+47} <ffffffff8019687e>{__link_path_walk+3454}
       <ffffffff801a3f64>{mntput_no_expire+36} 
<ffffffff80196ade>{link_path_walk+254}
       <ffffffff802144e2>{kobject_get+18} <ffffffff8020b3dc>{get_disk+76}
       <ffffffff802144e2>{kobject_get+18} 
<ffffffff880c3161>{:sr_mod:sr_block_open+193}
       <ffffffff8018ebd3>{do_open+195} <ffffffff8018e464>{bdget+276}
       <ffffffff8018eed0>{blkdev_open+0} <ffffffff8018eeff>{blkdev_open+47}
       <ffffffff8018569a>{__dentry_open+250} 
<ffffffff801858ae>{filp_open+46}
       <ffffffff80184a32>{get_unused_fd+98} 
<ffffffff80185a0f>{do_sys_open+79}
       <ffffffff8010dcae>{system_call+126}

Code: c7 42 08 01 00 00 00 49 8b 46 48 48 8b 53 60 48 39 c2 48 0f
RIP <ffffffff8036d739>{schedule+2729} RSP <ffff81010862b898>
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: esp4 ah4 parport_pc lp parport rfcomm l2cap sunrpc 
deflate zlib_deflate twofish serpent aes blowfish des sha256 crypto_null 
af_key ip_nat_ftp ip_conntrack_ftp iptable_mangle ipt_state 
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink 
ip_tables ip6table_mangle ip6table_filter ip6_tables ipv6 yealink 
hci_usb bluetooth usblp reiserfs vfat fat dm_mod video button battery ac 
ohci1394 ieee1394 ohci_hcd ehci_hcd dvb_ttpci l64781 saa7146_vv 
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299 
dvb_core tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom i2c_nforce2 
i2c_core shpchp snd_ca0106 snd_rawmidi snd_ac97_codec snd_seq_dummy 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus 
snd_page_alloc prism54 sk98lin forcedeth floppy sr_mod ext3 jbd 
usb_storage sata_sil24 sata_nv libata aic7xxx scsi_transport_spi sd_mod 
scsi_mod
Pid: 5666, comm: pan Not tainted 2.6.15.1 #1
RIP: 0010:[<ffffffff8036eebb>] <ffffffff8036eebb>{.text.lock.spinlock+2}
RSP: 0018:ffff81011c0dbba0  EFLAGS: 00000082
RAX: 0000000000000080 RBX: ffffffff80517980 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff81000c00b8e0
RBP: ffff81011c0dbc08 R08: 0000000000000000 R09: ffff8100cfcad780
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8101083e0870 R14: ffff81000c00b8e0 R15: 0000000000000000
FS:  00002aaaaaadb960(0000) GS:ffffffff804b3800(0000) knlGS:00000000555776c0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaaaaaac000 CR3: 0000000116c2d000 CR4: 00000000000006e0
Process pan (pid: 5666, threadinfo ffff81011c0da000, task ffff810037e00e60)
Stack: ffffffff801325be 0000000100000000 000000008016823a 0000000000000001
       0000000127c07180 0000000000000082 0000000000000001 0000000000003340
       0000000000000000 ffff810104e734f8
Call Trace:<ffffffff801325be>{try_to_wake_up+78} 
<ffffffff8012f173>{__wake_up_common+67}
       <ffffffff8012f1f3>{__wake_up+67} 
<ffffffff802fd0e4>{sock_def_readable+52}
       <ffffffff80367bce>{unix_stream_sendmsg+718} 
<ffffffff802faf75>{sock_aio_write+325}
       <ffffffff80185fdd>{do_sync_write+205} 
<ffffffff8036d9c0>{thread_return+0}
       <ffffffff8014d2f0>{autoremove_wake_function+0} 
<ffffffff80186534>{vfs_write+244}
       <ffffffff80186fe3>{sys_write+83} <ffffffff8010dcae>{system_call+126}

Code: 83 3f 00 7e f9 e9 3b fd ff ff e8 0a ad ea ff e9 91 fd ff ff
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU 1
CPU 1
Modules linked in: esp4 ah4 parport_pc lp parport rfcomm l2cap sunrpc 
deflate zlib_deflate twofish serpent aes blowfish des sha256 crypto_null 
af_key ip_nat_ftp ip_conntrack_ftp iptable_mangle ipt_state 
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink 
ip_tables ip6table_mangle ip6table_filter ip6_tables ipv6 yealink 
hci_usb bluetooth usblp reiserfs vfat fat dm_mod video button battery ac 
ohci1394 ieee1394 ohci_hcd ehci_hcd dvb_ttpci l64781 saa7146_vv 
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299 
dvb_core tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom i2c_nforce2 
i2c_core shpchp snd_ca0106 snd_rawmidi snd_ac97_codec snd_seq_dummy 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus 
snd_page_alloc prism54 sk98lin forcedeth floppy sr_mod ext3 jbd 
usb_storage sata_sil24 sata_nv libata aic7xxx scsi_transport_spi sd_mod 
scsi_mod
Pid: 4542, comm: hald-addon-stor Not tainted 2.6.15.1 #1
RIP: 0010:[<ffffffff8036eebb>] <ffffffff8036eebb>{.text.lock.spinlock+2}
RSP: 0018:ffff810127cb7f40  EFLAGS: 00000082
RAX: ffff81000c00b958 RBX: ffff81010bca0ab0 RCX: 00000000366a1e06
RDX: 000002849ef17376 RSI: 0000000000000000 RDI: ffff81000c00b8e0
RBP: ffff810127cb7f78 R08: 0000000000000001 R09: ffff8101275d9880
R10: 0000000000001400 R11: 0000000000000000 R12: ffff81000c00b8e0
R13: 0000000000000001 R14: 0000000000000001 R15: 000002849effe740
FS:  00002aaaaaacf900(0000) GS:ffffffff804b3880(0000) knlGS:00000000555776c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaaac000 CR3: 0000000108627000 CR4: 00000000000006e0
Process hald-addon-stor (pid: 4542, threadinfo ffff81010862a000, task 
ffff81010bca0ab0)
Stack: ffffffff80133067 0000000000000001 ffff81010bca0ab0 0000000000000000
       0000000000000001 000000000000000b 000002849effe740 0000000000000001
       ffffffff801408ef ffff81010b4628c0
Call Trace: <IRQ> <ffffffff80133067>{scheduler_tick+199} 
<ffffffff801408ef>{update_process_times+239}
       <ffffffff8011a1f9>{smp_apic_timer_interrupt+57} 
<ffffffff8010e896>{apic_timer_interrupt+98}
        <EOI> <ffffffff8036e70b>{__down_read+155} 
<ffffffff8036e682>{__down_read+18}
       <ffffffff80133fff>{mm_release+47} <ffffffff801385ce>{exit_mm+62}
       <ffffffff80139354>{do_exit+564} 
<ffffffff80273117>{do_unblank_screen+119}
       <ffffffff8010fa41>{die+81} 
<ffffffff8010fe6e>{do_general_protection+270}
       <ffffffff8010e9e9>{error_exit+0} <ffffffff8020d9d0>{as_queue_empty+0}
       <ffffffff8036d739>{schedule+2729} <ffffffff8036cdf5>{schedule+357}
       <ffffffff880077e0>{:scsi_mod:scsi_request_fn+880} 
<ffffffff88007c23>{:scsi_mod:scsi_queue_insert+195}
       <ffffffff8036dd68>{cond_resched+72} 
<ffffffff8036e187>{wait_for_completion+23}
       <ffffffff8020653c>{blk_execute_rq+204} 
<ffffffff802093b5>{get_request_wait+53}
       <ffffffff88005c70>{:scsi_mod:scsi_execute+224} 
<ffffffff88005d44>{:scsi_mod:scsi_execute_req+164}
       <ffffffff88006729>{:scsi_mod:scsi_test_unit_ready+73}
       <ffffffff880c25fe>{:sr_mod:sr_media_change+78} 
<ffffffff802bffdb>{media_changed+75}
       <ffffffff8018e0c7>{check_disk_change+39} 
<ffffffff802c179e>{cdrom_open+2494}
       <ffffffff801a0bc5>{__d_lookup+165} <ffffffff80195985>{do_lookup+117}
       <ffffffff8019f8ff>{dput+47} <ffffffff8019687e>{__link_path_walk+3454}
       <ffffffff801a3f64>{mntput_no_expire+36} 
<ffffffff80196ade>{link_path_walk+254}
       <ffffffff802144e2>{kobject_get+18} <ffffffff8020b3dc>{get_disk+76}
       <ffffffff802144e2>{kobject_get+18} 
<ffffffff880c3161>{:sr_mod:sr_block_open+193}
       <ffffffff8018ebd3>{do_open+195} <ffffffff8018e464>{bdget+276}
       <ffffffff8018eed0>{blkdev_open+0} <ffffffff8018eeff>{blkdev_open+47}
       <ffffffff8018569a>{__dentry_open+250} 
<ffffffff801858ae>{filp_open+46}
       <ffffffff80184a32>{get_unused_fd+98} 
<ffffffff80185a0f>{do_sys_open+79}
       <ffffffff8010dcae>{system_call+126}

Code: 83 3f 00 7e f9 e9 3b fd ff ff e8 0a ad ea ff e9 91 fd ff ff
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


