Return-Path: <linux-kernel-owner+w=401wt.eu-S932160AbXAPAqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXAPAqX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXAPAqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:46:23 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:60022 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbXAPAqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:46:22 -0500
X-From-Line: nobody Sat Jan 13 23:57:30 2007
From: syrius.ml@no-log.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc5 nfs+krb => oops
Message-ID: <871wlyo8fi.87zm8mmtv2@87y7o6mtv2.message.id>
Date: Sat, 13 Jan 2007 23:57:29 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I've been curious enough to try 2.6.20-rc5 with nfs4/kerberos.
It was working fine before. I was using 2.6.18.1 on the client and
2.6.20-rc3-git4 on server and today i tried 2.6.20-rc5 on both client
and server. (both running up to date debian/sid)
Trying to mount a nfs4 or nfs3 share with krb5 (did try with krb5 and
krb5p) produces this oops on the client side:
(each time I tried i got the same oops)

------------[ cut here ]------------
kernel BUG at net/sunrpc/sched.c:902!
invalid opcode: 0000 [#1]
PREEMPT 
Modules linked in: rpcsec_gss_spkm3 rfcomm l2cap bluetooth nfsd exportfs nsc_irc
c tun ipv6 dm_snapshot dm_mirror dm_mod eeprom i2c_isa eth1394 usbhid snd_intel8
x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_oss snd_seq
_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device ohci1394 i
eee1394 ipw2200 snd ieee80211 ieee80211_crypt i2c_i801 psmouse ide_cd r8169 rtc 
irda ehci_hcd uhci_hcd serio_raw i2c_core cdrom snd_page_alloc usbcore evdev crc
_ccitt
CPU:    0
EIP:    0060:[<c03fcb1f>]    Not tainted VLI
EFLAGS: 00210297   (2.6.20-rc5 #3)
EIP is at rpc_release_task+0x8f/0xc0
eax: f7e40c80   ebx: f7e40c80   ecx: f51eaac0   edx: c03fcc80
esi: fffffff3   edi: f6f21c40   ebp: f6f21bf0   esp: f6f21be4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 4286, ti=f6f20000 task=f6c52030 task.ti=f6f20000)
Stack: f6f21bf0 c03f7a77 f7e40c80 f6f21c10 c03f7c0d 00000000 fffffeff ffffffff 
       f6f21c7c f76f1180 00000000 f6f21c30 c01fe0d6 f6f21c40 7ffbfaef fffffffe 
       f6f21c7c f6de1a40 f76f1b80 f6f21c58 c01fe436 00000fff 00000000 c050a180 
Call Trace:
 [<c010411a>] show_trace_log_lvl+0x1a/0x30
 [<c01041d9>] show_stack_log_lvl+0xa9/0xd0
 [<c01043ef>] show_registers+0x1ef/0x360
 [<c010466b>] die+0x10b/0x210
 [<c01047f2>] do_trap+0x82/0xb0
 [<c0105157>] do_invalid_op+0x97/0xb0
 [<c0411864>] error_code+0x74/0x7c
 [<c03f7c0d>] rpc_call_sync+0x8d/0xb0
 [<c01fe0d6>] nfs3_rpc_wrapper+0x46/0x70
 [<c01fe436>] nfs3_proc_getattr+0x46/0x80
 [<c01ed7ff>] nfs_create_server+0x2cf/0x520
 [<c01f584d>] nfs_get_sb+0xbd/0x580
 [<c016b530>] vfs_kern_mount+0x40/0x90
 [<c016b5d6>] do_kern_mount+0x36/0x50
 [<c018142e>] do_mount+0x24e/0x690
 [<c01818df>] sys_mount+0x6f/0xb0
 [<c010314e>] sysenter_past_esp+0x5f/0x85
 =======================
Code: d8 e8 86 fc ff ff c7 03 00 00 00 00 8d 43 68 0f ba 73 68 04 ba 04 00 00 00
 e8 5e 1d d3 ff 89 d8 e8 f7 fe ff ff 83 c4 08 5b 5d c3 <0f> 0b eb fe 0f 0b eb fe
 e8 84 2a 01 00 eb be 0f b7 80 94 00 00 
EIP: [<c03fcb1f>] rpc_release_task+0x8f/0xc0 SS:ESP 0068:f6f21be4


( was a proto=udp mount )
I can provide more informations if needed, but i'm pretty it would be
reproducible easily.

-- 
