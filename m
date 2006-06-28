Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423299AbWF1MDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423299AbWF1MDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423300AbWF1MDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:03:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43987 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423299AbWF1MDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:03:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm3 - mutex warning in usbhid, battery problem, and slab corruption
Date: Wed, 28 Jun 2006 14:03:33 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060627015211.ce480da6.akpm@osdl.org>
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281403.33190.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 10:52, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/

I have three problems with this kernel.

First, there's a mutex lock warning as in the appended trace and my USB
mouse doesn't work.

Second, kpowersave is apparently unable to get the battery status,
although the data in /proc/acpi/battery/BAT0/ seem to be correct
(this also happened with 2.6.17-mm2, but it did not happen with
2.6.17-rc6-mm2).

Finally, I'm still seeing slab corruptions in dmesg (eg. at the end of the
appended trace).

Greetings,
Rafael


  usbdev2.4_ep81: ep_device_release called for usbdev2.4_ep81
 BUG: warning at kernel/mutex.c:132/__mutex_lock_common()
 
 Call Trace:
  [<ffffffff8020ab6f>] show_trace+0x9f/0x240
  [<ffffffff8020af45>] dump_stack+0x15/0x20
  [<ffffffff8047296b>] __mutex_lock_slowpath+0xab/0x280
  [<ffffffff80472b49>] mutex_lock+0x9/0x10
  [<ffffffff803ed909>] input_unregister_device+0x109/0x160
  [<ffffffff88157ab2>] :usbhid:hidinput_disconnect+0x72/0xa0
  [<ffffffff88153d3d>] :usbhid:hid_disconnect+0x9d/0x110
  [<ffffffff803dd85b>] usb_unbind_interface+0x5b/0xb0
  [<ffffffff803bb03d>] __device_release_driver+0x8d/0xb0
  [<ffffffff803bb324>] device_release_driver+0x34/0x50
  [<ffffffff803ba6af>] bus_remove_device+0xaf/0xe0
  [<ffffffff803b9067>] device_del+0x157/0x1a0
  [<ffffffff803dc548>] usb_disable_device+0x108/0x1a0
  [<ffffffff803d44e2>] usb_disconnect+0xd2/0x150
  [<ffffffff803d7c0f>] hub_thread+0x63f/0xff0
  [<ffffffff802435c9>] kthread+0xd9/0x110
  [<ffffffff8020a34a>] child_rip+0x8/0x12
 general protection fault: 0000 [1] PREEMPT 
 last sysfs file: /power/state
 CPU 0 
 Modules linked in: usbserial asus_acpi thermal processor fan button battery ac af_packet snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device bcm43xx ieee80211softmac ieee80211 ieee80211_crypt pcmcia firmware_class ohci1394 ieee1394 sk98lin yenta_socket rsrc_nonstatic pcmcia_core ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter usbhid ip6table_mangle ip_conntrack snd_intel8x0 ip_tables snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ip6table_filter ip6_tables x_tables ehci_hcd i2c_nforce2 i2c_core ohci_hcd parport_pc lp parport ipv6 dm_mod
 Pid: 110, comm: khubd Not tainted 2.6.17-mm3 #1
 RIP: 0010:[<ffffffff804729b8>]  [<ffffffff804729b8>] __mutex_lock_slowpath+0xf8/0x280
 RSP: 0000:ffff810037e83b58  EFLAGS: 00010046
 RAX: 6b6b6b6b6b6b6b6b RBX: ffff810057d417e0 RCX: 0000000000000000
 RDX: ffff810037e82000 RSI: ffff810037e83b58 RDI: ffff810057d417e0
 RBP: ffff810037e83bb8 R08: 0000000000000002 R09: 0000000000000001
 R10: 0000000000000000 R11: ffffffff80527530 R12: 0000000000000246
 R13: ffff810037f7d040 R14: ffff810057d418a0 R15: ffff810037e83b58
 FS:  00002ba97bcadb00(0000) GS:ffffffff808e6000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 CR2: 000000000051b2d4 CR3: 0000000059515000 CR4: 00000000000006e0
 Process khubd (pid: 110, threadinfo ffff810037e82000, task ffff810037f7d040)
 Stack:  ffff810057d418a0 ffff810037e83b58 1111111111111111 ffff810057d417e0
  ffff810037e83b58 ffff810057d41000 ffff810037e83b98 ffff810057d417e0
  ffff810057d41000 ffff810057d41ae0 ffff81005f26d088 ffff81005f26d088
 Call Trace:
  [<ffffffff80472b49>] mutex_lock+0x9/0x10
  [<ffffffff803ed909>] input_unregister_device+0x109/0x160
  [<ffffffff88157ab2>] :usbhid:hidinput_disconnect+0x72/0xa0
  [<ffffffff88153d3d>] :usbhid:hid_disconnect+0x9d/0x110
  [<ffffffff803dd85b>] usb_unbind_interface+0x5b/0xb0
  [<ffffffff803bb03d>] __device_release_driver+0x8d/0xb0
  [<ffffffff803bb324>] device_release_driver+0x34/0x50
  [<ffffffff803ba6af>] bus_remove_device+0xaf/0xe0
  [<ffffffff803b9067>] device_del+0x157/0x1a0
  [<ffffffff803dc548>] usb_disable_device+0x108/0x1a0
  [<ffffffff803d44e2>] usb_disconnect+0xd2/0x150
  [<ffffffff803d7c0f>] hub_thread+0x63f/0xff0
  [<ffffffff802435c9>] kthread+0xd9/0x110
  [<ffffffff8020a34a>] child_rip+0x8/0x12
 
 Code: 4c 89 38 48 89 45 a8 4c 89 6d b0 48 c7 c0 ff ff ff ff 87 03 
 RIP  [<ffffffff804729b8>] __mutex_lock_slowpath+0xf8/0x280
  RSP <ffff810037e83b58>

  <3>Slab corruption: start=ffff810057d41000, len=4096
 7e0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b
 8a0: 6b 6b 6b 6b 6b 6b 6b 6b 58 3b e8 37 00 81 ff ff
