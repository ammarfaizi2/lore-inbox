Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbUKEOWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUKEOWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUKEOWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:22:19 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:21421 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262702AbUKEOSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:18:38 -0500
X-OB-Received: from unknown (205.158.62.37)
  by wfilter.us4.outblaze.com; 5 Nov 2004 14:18:35 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Vladimir Chernyshov" <greengrass@writeme.com>
To: linux-kernel@vger.kernel.org
Cc: greengrass@writeme.com
Date: Fri, 05 Nov 2004 16:18:35 +0200
Subject: [2.6.8 bugreport] using mmap with via82cxxx_audio causes GPF
X-Originating-Ip: 213.243.169.151
X-Originating-Server: ws1-2a.us4.outblaze.com
Message-Id: <20041105141835.538B91C6103@ws1-2a.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Setting up mmap before setting up speed/format/channels causes shortly afterwards a general protection fault in via82cxxx_audio:

===========================================================================
CPU 0
Modules linked in: snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd ehci_hcd uhci_hcd eth1394 via82cxxx_audio uart401 sound soundcore ac97_codec via82cxxx ide_core r8169 crc32 ohci1394 nls_iso8859_1 nls_cp437 capability commoncap sr_mod cdrom sbp2 ieee1394 rtc vfat fat ext2 ext3 jbd mbcache sd_mod sata_via libata scsi_mod unix font vesafb cfbcopyarea cfbimgblt cfbfill
rect
Pid: 2023, comm: quake-x11 Not tainted 2.6.8-9-amd64-k8
RIP: 0010:[<ffffffffa019666e>] <ffffffffa019666e>{:via82cxxx_audio:via_mm_nopage+350}
RSP: 0000:000001001e987d78  EFLAGS: 00010206
RAX: 038000fc81000000 RBX: 000001001e873858 RCX: 0000000000000020
RDX: 006fffff90000000 RSI: 0000000055fbd000 RDI: 000001001e72a290
RBP: 000001001e873800 R08: 000001001f528de8 R09: 000001001e98f578
R10: 0000000000000000 R11: 0000000000000000 R12: 000001001e873858
R13: 0000000000000000 R14: 000001001e987dcc R15: 000001001e4fb480
FS:  0000000000000000(0000) GS:ffffffff80387980(005b) knlGS:00000000557aa080
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000055fbd000 CR3: 0000000000101000 CR4: 00000000000006e0
Process quake-x11 (pid: 2023, threadinfo 000001001e986000, task 000001001ec1d350)
Stack: 0000000000000000 0000000000000001 0000010012e41240 000001001e72a290
       0000000055fbd000 ffffffff80159508 0000000000000246 ffffffff80158eb9
       0000000000000000 000001001e98f578
Call Trace:<ffffffff80159508>{-2146069240} <ffffffff80158eb9>{-2146070855}
       <ffffffff801598e0>{-2146068256} <ffffffff8011f79a>{-2146306150}
       <ffffffffa0198004>{:via82cxxx_audio:via_dsp_ioctl+2340}
       <ffffffff80166dad>{-2146013779} <ffffffff80110a61>{-2146366879}


Code: ff 40 04 4d 85 f6 74 07 41 c7 06 01 00 00 00 48 8b 1c 24 48
============================================================================

Changing the order of setup to opposite fixes the problem.

Tested with 2.6.7 (compiled for K7) and 2.6.8 (compiled for AMD-64). Testing tool - QuakeForge.

regards,
Vladimir

