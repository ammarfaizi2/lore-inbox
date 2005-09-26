Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbVIZM2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbVIZM2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbVIZM2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:28:53 -0400
Received: from mx1.netapp.com ([216.240.18.38]:53421 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1751616AbVIZM2w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:28:52 -0400
X-IronPort-AV: i="3.97,146,1125903600"; 
   d="scan'208"; a="258865462:sNHT23502360"
Subject: Re: Problem with nfs4, kernel 2.6.13.2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509251516.23862.MalteSch@gmx.de>
References: <200509251516.23862.MalteSch@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Organization: Network Appliance, Inc
Date: Mon, 26 Sep 2005 08:28:50 -0400
Message-Id: <1127737730.8453.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-OriginalArrivalTime: 26 Sep 2005 12:28:51.0792 (UTC) FILETIME=[DA46DD00:01C5C295]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 25.09.2005 Klokka 15:16 (+0200) skreiv Malte Schröder:
> Hello list.
> When doing lots of reads over nfs4 (i.e. a few gigabytes), I can reproduce the 
> following error (using tar -c <my-nfs-path> | dd of=/dev/null):

Hi,

Could you give us some details about your setup (client _and_ server)
please?

Also, is this something that is NFSv4 only, or can you reproduce it on
NFSv2/v3 too?

Cheers,
  Trond

> #########################
> Unable to handle kernel paging request at 0000000000100108 RIP:
> <ffffffff80198248>{generic_drop_inode+56}
> PGD 141bd067 PUD 141c2067 PMD 0
> Oops: 0002 [1] PREEMPT
> CPU 0
> Modules linked in: nfs lockd nfs_acl sunrpc thermal fan button ac battery 
> autofs4 af_packet joydev parport_pc parport floppy tuner tvaudio bttv 
> video_buf fir
> mware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev skge usbhid 
> ehci_hcd uhci_hcd usbcore snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
> snd_s
> eq_midi_emul snd_emu10k1 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm 
> snd_page_alloc snd_util_mem snd_hwdep eth1394 via82cxxx sata_via ohci1394 
> ieee1394
> nls_utf8 ntfs nls_base ext3 jbd mbcache snd_seq_dummy snd_seq_oss snd_seq_midi 
> snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore
> ipv6 w83627hf_wdt w83781d i2c_isa i2c_viapro i2c_dev i2c_sensor powernow_k8 
> freq_table processor cpufreq_ondemand ide_floppy ide_cd cdrom ide_core unix 
> reise
> rfs sd_mod sata_promise libata scsi_mod evdev psmouse
> Pid: 129, comm: kswapd0 Not tainted 2.6.13.2
> RIP: 0010:[<ffffffff80198248>] <ffffffff80198248>{generic_drop_inode+56}
> RSP: 0018:ffff81003f463bd8  EFLAGS: 00010246
> RAX: 0000000000200200 RBX: ffff81001c3ae5c0 RCX: 0000000000100100
> RDX: ffff81001c3ae5d0 RSI: ffff810021a7e400 RDI: ffff81001c3ae5c0
> RBP: ffff81001c3ae5c0 R08: 00000000fffffffa R09: 0000000000000000
> R10: 0000000000000001 R11: ffffffff80198210 R12: ffff81000a48d400
> R13: ffff81001c3ae430 R14: ffff81000a48d800 R15: ffff81003f463cc8
> FS:  00002aaaab01f6d0(0000) GS:ffffffff803ee800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000100108 CR3: 0000000011ff1000 CR4: 00000000000006e0
> Process kswapd0 (pid: 129, threadinfo ffff81003f462000, task ffff81003f45ee50)
> Stack: 0000000000000000 ffffffff8840f256 000000000000065d ffff81001c3ae4c0
>        ffff81001c3ae6d8 ffffffff8015940f ffff81003f463c38 ffff81001c3ae5c0
>        ffff81001c3ae5a8 ffffffff8016334a
> Call Trace:<ffffffff8840f256>{:nfs:__nfs_revalidate_inode+278}
>        <ffffffff8015940f>{find_get_pages_tag+47} 
> <ffffffff8016334a>{pagevec_lookup_tag+26}
>        <ffffffff80159a28>{wait_on_page_writeback_range+200}
>        <ffffffff88415ec7>{:nfs:nfs_wait_on_requests+247} 
> <ffffffff8842acea>{:nfs:nfs_do_return_delegation+42}
>        <ffffffff8840ef00>{:nfs:nfs4_clear_inode+32} 
> <ffffffff80197aa3>{clear_inode+147}
>        <ffffffff80197b48>{dispose_list+104} 
> <ffffffff80197e69>{shrink_icache_memory+553}
>        <ffffffff80195694>{shrink_dcache_memory+4} 
> <ffffffff8016467c>{shrink_slab+220}
>        <ffffffff80165b99>{balance_pgdat+617} <ffffffff80165e07>{kswapd+279}
>        <ffffffff8014b880>{autoremove_wake_function+0} 
> <ffffffff8010f692>{child_rip+8}
>        <ffffffff80165cf0>{kswapd+0} <ffffffff8010f68a>{child_rip+0}
> 
> 
> Code: 48 89 41 08 48 89 08 48 8b 05 ba f2 17 00 48 89 50 08 48 89
> RIP <ffffffff80198248>{generic_drop_inode+56} RSP <ffff81003f463bd8>
> CR2: 0000000000100108
>  <6>note: kswapd0[129] exited with preempt_count 1
> #########################
> 
> This also happens on two other machines running i386-kernels.
> I hope the above data helps, if you need other information, I will provide it.
> 
> Greets
