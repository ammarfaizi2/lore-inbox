Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVIREV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVIREV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 00:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVIREV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 00:21:59 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:58743 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbVIREV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 00:21:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aE90mThVCslrUASEKU2sU0Vu6X3HyCzoDG+LuuTLNW9671/0ak5SbS7KkR0rgc+57pD0NsKm6kukQCl2OHPzkHAA/8Qkb1isRrlyoTgAufZtm4mumKzzF/+NzaQJcfticnxyjrLY8Lf5Dqnpp6Id0BzFpjryiJ5ax7uVbhaK0j8=
Message-ID: <2ac89c70050917212145d9ba60@mail.gmail.com>
Date: Sun, 18 Sep 2005 08:21:56 +0400
From: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Reply-To: dmitrij.bogush@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at src/net/core/skbuff.c:96 on 2.6.13-mm3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when calling to ISP and fail authorization.. 

Sep 18 06:46:37 linux pppd[15760]: Plugin passwordfd.so loaded.
Sep 18 06:46:37 linux pppd[15760]: pppd 2.4.3 started by root, uid 0
Sep 18 06:46:38 linux wvdial[15764]: WvDial: Internet dialer version 1.54.0
Sep 18 06:46:38 linux wvdial[15764]: Initializing modem.
Sep 18 06:46:38 linux wvdial[15764]: Sending: ATZ
Sep 18 06:46:38 linux wvdial[15764]: ATZ
Sep 18 06:46:38 linux wvdial[15764]: OK
Sep 18 06:46:38 linux wvdial[15764]: Sending: AT&A1
Sep 18 06:46:38 linux wvdial[15764]: AT&A1
Sep 18 06:46:38 linux wvdial[15764]: OK
Sep 18 06:46:38 linux wvdial[15764]: Modem initialized.
Sep 18 06:46:38 linux wvdial[15764]: Sending: ATDT8w600100
Sep 18 06:46:38 linux wvdial[15764]: Waiting for carrier.
Sep 18 06:46:38 linux wvdial[15764]: ATDT8w600100
Sep 18 06:46:49 linux su: (to root) loge on /dev/pts/5
Sep 18 06:47:10 linux wvdial[15764]: Modulation: V92
Sep 18 06:47:10 linux wvdial[15764]: CONNECT 46667
Sep 18 06:47:10 linux wvdial[15764]: Carrier detected.  Waiting for prompt.
Sep 18 06:47:11 linux wvdial[15764]: % Authorization failed.
Sep 18 06:47:13 linux wvdial[15764]: NO CARRIER
Sep 18 06:47:23 linux wvdial[15764]: Don't know what to do!  Starting
pppd and hoping for the best.
Sep 18 06:47:23 linux pppd[15760]: Serial connection established.
Sep 18 06:47:23 linux pppd[15760]: Renamed interface ppp0 to modem0
Sep 18 06:47:23 linux pppd[15760]: Using interface modem0
Sep 18 06:47:23 linux pppd[15760]: Connect: modem0 <--> /dev/ttySL0
Sep 18 06:47:26 linux kernel: skb_over_panic: text:ffffffff885c14c9
len:1 put:1 head:ffff81000e326000 data:ffff81010e326000
tail:ffff81010e326001000e326600 dev:<NULL>
Sep 18 06:47:26 linux kernel: ----------- [cut here ] ---------
[please bite here ] ---------
Sep 18 06:47:26 linux kernel: Kernel BUG at
/home/build/KERNEL/14-src/net/core/skbuff.c:96
Sep 18 06:47:26 linux kernel: invalid operand: 0000 [1] PREEMPT
Sep 18 06:47:26 linux kernel: CPU 0
Sep 18 06:47:26 linux kernel: Modules linked in: snd_via82xx_modem
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc pppd_comp ppp_async crc_ccitt ppp_generic slhc nvidia
battery thermal button ac raw usbmouse uhci_hcd usbcore
cpufreq_ondemand powernow_k8 freq_tabl evdev sg sd_mod sr_mod scsi_mod
r8169 ide_cd cdrom ide_disk via82cxxx ide_core
Sep 18 06:47:26 linux kernel: Pid: 16873, comm: slmodemd Tainted: P   
  2.6.13-mm3-b1 #1
Sep 18 06:47:26 linux kernel: RIP: 0010:[<ffffffff802fa81c>]
<ffffffff802fa81c>{skb_over_panic+92}
Sep 18 06:47:26 linux kernel: RSP: 0000:ffff8100005cbd68  EFLAGS: 00010096
Sep 18 06:47:26 linux kernel: RAX: 000000000000009a RBX:
ffff81001318fc00 RCX: ffffffff80432f30
Sep 18 06:47:26 linux kernel: RDX: ffffffff80432f30 RSI:
0000000000000001 RDI: 0000000000000001
Sep 18 06:47:26 linux kernel: RBP: 0000000000000001 R08:
000000003b9aca00 R09: ffff810010cd96c0
Sep 18 06:47:26 linux kernel: R10: 00000000ffffffff R11:
0000000000000000 R12: 0000000000000000
Sep 18 06:47:26 linux kernel: R13: 0000000000000001 R14:
ffff81001318f400 R15: ffff81010e326000
Sep 18 06:47:26 linux kernel: FS:  00002aaaab3576e0(0000)
GS:ffffffff8050f800(0063) knlGS:00000000557bb020
Sep 18 06:47:26 linux kernel: CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
Sep 18 06:47:26 linux kernel: CR2: 00000000008b3fb8 CR3:
000000000d785000 CR4: 00000000000006e0
Sep 18 06:47:26 linux kernel: Process slmodemd (pid: 16873, threadinfo
ffff8100005ca000, task ffff81000efd7040)
Sep 18 06:47:26 linux kernel: Stack: ffff81010e326001 ffff81000e326600
ffffffff803972b9 ffffffff885c14d3
Sep 18 06:47:26 linux kernel:        ffff8100005cbdc8 ffff81001318fc88
ffff81001318f400 ffff8100193ec000
Sep 18 06:47:26 linux kernel:        0000000000000286 0000000000000001
Sep 18 06:47:26 linux kernel: Call
Trace:<ffffffff885c14d3>{:ppp_async:ppp_asynctty_receive+579}
Sep 18 06:47:26 linux kernel:        <ffffffff802b9f28>{pty_write+56}
<ffffffff802b8bc7>{write_chan+807}
Sep 18 06:47:26 linux kernel:       
<ffffffff8012eaf0>{default_wake_function+0}
<ffffffff8012eaf0>{default_wake_function+0}
Sep 18 06:47:26 linux kernel:        <ffffffff802b4448>{tty_write+424}
<ffffffff802b88a0>{write_chan+0}
Sep 18 06:47:26 linux kernel:        <ffffffff8017e338>{vfs_write+200}
<ffffffff8017e4e3>{sys_write+83}
Sep 18 06:47:26 linux kernel:        <ffffffff80121651>{ia32_sysret+0}
Sep 18 06:47:26 linux kernel:
Sep 18 06:47:26 linux kernel: Code: 0f 0b 68 b0 4c 3a 80 c2 60 00 48
83 c4 18 c3 66 66 90 66 90
Sep 18 06:47:26 linux kernel: RIP
<ffffffff802fa81c>{skb_over_panic+92} RSP <ffff8100005cbd68>
Sep 18 06:47:26 linux kernel:  <6>note: slmodemd[16873] exited with
preempt_count 1
Sep 18 06:47:26 linux kernel: scheduling while atomic: slmodemd/0x00000001/16873
Sep 18 06:47:26 linux kernel:
Sep 18 06:47:26 linux kernel: Call
Trace:<ffffffff8035ee0a>{schedule+122}
<ffffffff8026af14>{vsnprintf+1396}
Sep 18 06:47:26 linux kernel:        <ffffffff80360bb8>{__down+184}
<ffffffff8012eaf0>{default_wake_function+0}
Sep 18 06:47:27 linux kernel:       
<ffffffff803607e3>{__down_failed+53}
<ffffffff885c2411>{:ppp_async:.text.lock.ppp_async+15}
Sep 18 06:47:27 linux kernel:       
<ffffffff885c2019>{:ppp_async:ppp_asynctty_hangup+9}
Sep 18 06:47:27 linux kernel:       
<ffffffff802b4042>{do_tty_hangup+386}
<ffffffff802b5435>{release_dev+565}
Sep 18 06:47:27 linux kernel:       
<ffffffff80160b6f>{free_hot_cold_page+255}
<ffffffff8016c106>{free_pgd_range+1078}
Sep 18 06:47:27 linux kernel:       
<ffffffff8026642e>{_atomic_dec_and_lock+14}
<ffffffff80196e31>{dput_recursive+801}
Sep 18 06:47:27 linux kernel:       
<ffffffff802b5dd1>{tty_release+17} <ffffffff8017ef02>{__fput+178}
Sep 18 06:47:27 linux kernel:       
<ffffffff8017bb0e>{filp_close+110}
<ffffffff801348e3>{put_files_struct+115}
Sep 18 06:47:27 linux kernel:        <ffffffff8013625b>{do_exit+539}
<ffffffff802c2927>{do_unblank_screen+119}
Sep 18 06:47:27 linux kernel:        <ffffffff801105a1>{die+81}
<ffffffff802fa81c>{skb_over_panic+92}
Sep 18 06:47:27 linux kernel:        <ffffffff803610f2>{do_trap+322}
<ffffffff80110cf1>{do_invalid_op+145}
Sep 18 06:47:27 linux kernel:       
<ffffffff802fa81c>{skb_over_panic+92} <ffffffff801337fd>{printk+141}
Sep 18 06:47:27 linux kernel:        <ffffffff8010f4a9>{error_exit+0}
<ffffffff802fa81c>{skb_over_panic+92}
Sep 18 06:47:27 linux kernel:       
<ffffffff802fa81c>{skb_over_panic+92}
<ffffffff885c14d3>{:ppp_async:ppp_asynctty_receive+579}
Sep 18 06:47:27 linux kernel:        <ffffffff802b9f28>{pty_write+56}
<ffffffff802b8bc7>{write_chan+807}
Sep 18 06:47:27 linux kernel:       
<ffffffff8012eaf0>{default_wake_function+0}
<ffffffff8012eaf0>{default_wake_function+0}
Sep 18 06:47:27 linux kernel:        <ffffffff802b4448>{tty_write+424}
<ffffffff802b88a0>{write_chan+0}
Sep 18 06:47:27 linux kernel:        <ffffffff8017e338>{vfs_write+200}
<ffffffff8017e4e3>{sys_write+83}
Sep 18 06:47:27 linux kernel:        <ffffffff80121651>{ia32_sysret+0}

-- 
Best Regards,
Dmitrij A Bogush.
