Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVIWE33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVIWE33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 00:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVIWE32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 00:29:28 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:30593
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S1751287AbVIWE32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 00:29:28 -0400
Date: Fri, 23 Sep 2005 00:32:01 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: GPF Using Quickcam
Message-ID: <20050923043201.GA14899@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evenin' all,

I was testing out my spiffy new (to me) QuickCam Express webcam, pressed
^C to terminate the test, and got the GPF shown below. Kernel version
is 2.6.12.3 running on SLAMD64:

The driver specifics are:

quickcam: QuickCam USB camera found (driver version QuickCam USB 0.6.3
$Date: 2005/04/15 19:32:49 $)
quickcam: Kernel:2.6.13.1 bus:3 class:FF subclass:FF vendor:046D
product:0870
quickcam: Sensor HDCS-1020 detected
quickcam: Registered device: /dev/video1
usbcore: registered new driver quickcam
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)

The message on the console after I pressed ^C:

general protection fault: 0000 [1] PREEMPT

The relevant extract from dmesg:

quickcam: Control URB error -2
general protection fault: 0000 [1] PREEMPT
CPU 0
Modules linked in: quickcam snd_pcm_oss snd_mixer_oss nfsd exportfs
lockd sunrpc md5 ipv6 eth1394 ohci1394 ieee1394 tulip bt878 tuner
tvaudio bttv video_buf firmware_class v4l2_common btcx_risc tveeprom
videodev snd_atiixp snd_ac97_codec audio snd_usb_audio snd_pcm snd_timer
snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd
ehci_hcd usb_storage
Pid: 9603, comm: testquickcam Not tainted 2.6.13.1
RIP: 0010:[<ffffffff802fe1a7>] <ffffffff802fe1a7>{usb_kill_urb+39}
RSP: 0000:ffff810006977c58  EFLAGS: 00010202
RAX: 0001002b00152dea RBX: ffff81001360a200 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff81001360a200
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffff81001f8bbe08 R11: 0000000000000002 R12: ffff81000a8a82f0
R13: ffff81000a847938 R14: ffff81000b285cf8 R15: ffff810006dc9e58
FS:  00002aaaaadfbb00(0000) GS:ffffffff80540800(0000)
knlGS:00000000560f2180
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab0f008 CR3: 000000001b024000 CR4: 00000000000006e0
Process testquickcam (pid: 9603, threadinfo ffff810006976000, task
ffff810006dc9880)
Stack: ffff81001ef27800 ffffffff802ff5f4 ffff81001ef27800 ffff81001ef27800
       0000000000000000 ffffffff802ff937 0000000000000000
	   ffff810000000000 ffffffff00001388 ffff81000a8a8000
Call Trace:<ffffffff802ff5f4>{usb_disable_interface+52} <ffffffff802ff937>{usb_set_interface+327}
<ffffffff88202b70>{:quickcam:qc_isoc_stop+224} <ffffffff882048c4>{:quickcam:qc_v4l_close+68}
       <ffffffff80177002>{__fput+178} <ffffffff801756ee>{filp_close+110}
       <ffffffff80134813>{put_files_struct+115} <ffffffff801351d5>{do_exit+533}
       <ffffffff8013d825>{__dequeue_signal+501} <ffffffff80135df8>{do_group_exit+280}
       <ffffffff8013fa57>{get_signal_to_deliver+1575} <ffffffff8010de8f>{do_signal+159}
       <ffffffff801495b0>{autoremove_wake_function+0} <ffffffff80175f24>{vfs_read+308}
       <ffffffff8010eb3f>{sysret_signal+28} <ffffffff8010ee27>{ptregscall_common+103}


Code: 48 8b 40 58 48 85 c0 0f 84 3c 01 00 00 48 83 78 30 00 0f 84
RIP <ffffffff802fe1a7>{usb_kill_urb+39} RSP <ffff810006977c58>
<1>Fixing recursive fault but reboot is needed!

Is this a buggy driver? I can provide more information if need be.

Thanks,

Kurt
-- 
"I used to think that the brain was the most wonderful organ in my
body.  Then I realized who was telling me this."
		-- Emo Phillips
