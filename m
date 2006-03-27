Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWC0C2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWC0C2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 21:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWC0C2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 21:28:17 -0500
Received: from asteria.debian.or.at ([86.59.21.34]:53725 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S932097AbWC0C2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 21:28:16 -0500
Date: Mon, 27 Mar 2006 04:28:14 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060327022814.GV25288@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've seen a few of these since upgrading to 2.6.16 on my x86_64 system:


[14513.188982] Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP: 
[14513.188988] <ffffffff8011d900>{page_to_pfn+0}
[14513.188998] PGD 3450d067 PUD 3450e067 PMD 0 
[14513.189002] Oops: 0000 [1] SMP 
[14513.189005] CPU 0 
[14513.189007] Modules linked in: sha256 pktcdvd nfsd lockd sunrpc lp autofs4 thermal fan button processor ac battery ipv6 isofs aes dm_crypt raid5 xor dm_mod fuse usblp usbhid eth1394 snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_mid
i_event snd_seq snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_mpu401_uart evdev snd_rawmidi snd_seq_device ohci1394 tuner tvaudio msp3400 psmouse ieee1394 serio_raw floppy pcspkr parport_pc parport bttv video_buf ehci_hcd uhci_h
cd snd_bt87x firmware_class usbcore snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd compat_ioctl32 i2c_algo_bit soundcore v4l2_common btcx_risc ir_common tveeprom i2c_core snd_page_alloc videodev ide_cd cdrom unix
[14513.189040] Pid: 164, comm: pdflush Not tainted 2.6.16 #1
[14513.189044] RIP: 0010:[<ffffffff8011d900>] <ffffffff8011d900>{page_to_pfn+0}
[14513.189050] RSP: 0018:ffff81003f8b5740  EFLAGS: 00010246
[14513.189054] RAX: 0000000000000000 RBX: ffff81002b486c00 RCX: ffff81002b486c00
[14513.189057] RDX: 0000000000000000 RSI: ffff81003e510ec0 RDI: 0000000000000000
[14513.189060] RBP: 0000000000000000 R08: ffff81003e510b40 R09: 0000000000000040
[14513.189064] R10: 00000000ffffffff R11: 0000000000000002 R12: ffff81003e510ec0
[14513.189067] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[14513.189071] FS:  00002adb727dcae0(0000) GS:ffffffff8062c000(0000) knlGS:0000000000000000
[14513.189075] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[14513.189078] CR2: 0000000000000007 CR3: 000000003450c000 CR4: 00000000000006e0
[14513.189082] Process pdflush (pid: 164, threadinfo ffff81003f8b4000, task ffff81003f87b180)
[14513.189084] Stack: ffffffff80288e8d 0000000100362cdd ffffffff8045ab19 0000000000000000 
[14513.189091]        0000000100200200 0000000000000000 0000000000000000 ffff81003f13f908 
[14513.189096]        ffff81003e510ec0 ffff81003f13f908 
[14513.189101] Call Trace: <ffffffff80288e8d>{blk_recount_segments+125}
[14513.189113]        <ffffffff8045ab19>{schedule_timeout+153} <ffffffff8017df90>{__bio_clone+128}
[14513.189134]        <ffffffff8017dfed>{bio_clone+61} <ffffffff80144a70>{autoremove_wake_function+0}
[14513.189143]        <ffffffff882576c1>{:dm_crypt:crypt_alloc_buffer+65}
[14513.189157]        <ffffffff8825813e>{:dm_crypt:crypt_map+174} <ffffffff8823b463>{:dm_mod:__map_bio+83}
[14513.189190]        <ffffffff8823b6a8>{:dm_mod:__clone_and_map+168} <ffffffff8823b8de>{:dm_mod:__split_bio+174}
[14513.189223]        <ffffffff8823b9dc>{:dm_mod:dm_request+204} <ffffffff8028b532>{generic_make_request+258}
[14513.189243]        <ffffffff8028b628>{submit_bio+216} <ffffffff8017e20f>{__bio_add_page+463}
[14513.189256]        <ffffffff8026bd3e>{xfs_submit_ioend_bio+30} <ffffffff8026bec0>{xfs_submit_ioend+144}
[14513.189269]        <ffffffff8026cd03>{xfs_page_state_convert+1379} <ffffffff8026d2e0>{linvfs_writepage+176}
[14513.189298]        <ffffffff8019edc5>{mpage_writepages+469} <ffffffff8026e3ae>{xfs_buf_rele+62}
[14513.189309]        <ffffffff8026d230>{linvfs_writepage+0} <ffffffff80159c5c>{do_writepages+44}
[14513.189336]        <ffffffff8019d480>{__sync_single_inode+112} <ffffffff8019d7c1>{__writeback_single_inode+417}
[14513.189349]        <ffffffff8823dbf5>{:dm_mod:dm_table_any_congested+21}
[14513.189364]        <ffffffff8823bab8>{:dm_mod:dm_any_congested+72} <ffffffff8823dbf5>{:dm_mod:dm_table_any_congested+21}
[14513.189391]        <ffffffff8019d9b2>{sync_sb_inodes+482} <ffffffff80144440>{keventd_create_kthread+0}
[14513.189403]        <ffffffff8019db15>{writeback_inodes+133} <ffffffff80159a3e>{wb_kupdate+206}
[14513.189423]        <ffffffff8015a4d0>{pdflush+0} <ffffffff8015a424>{__pdflush+292}
[14513.189431]        <ffffffff8015a50a>{pdflush+58} <ffffffff80159970>{wb_kupdate+0}
[14513.189441]        <ffffffff80144402>{kthread+146} <ffffffff8010bba2>{child_rip+8}
[14513.189452]        <ffffffff80144440>{keventd_create_kthread+0} <ffffffff80144370>{kthread+0}
[14513.189467]        <ffffffff8010bb9a>{child_rip+0}
[14513.189474] 
[14513.189475] Code: 48 0f b6 47 07 48 8b 14 c5 80 1c 63 80 48 b8 b7 6d db b6 6d 
[14513.189485] RIP <ffffffff8011d900>{page_to_pfn+0} RSP <ffff81003f8b5740>
[14513.189491] CR2: 0000000000000007
[14513.189493]  

Let me know if you need any additional information.

Cheers,
Peter
-- 
 PGP signed and encrypted  |  .''`.  ** Debian GNU/Linux **
    messages preferred.    | : :' :      The  universal
                           | `. `'      Operating System
 http://www.palfrader.org/ |   `-    http://www.debian.org/
