Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVHKGnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHKGnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVHKGnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:43:06 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:52179
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S932276AbVHKGnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:43:05 -0400
Date: Thu, 11 Aug 2005 08:42:17 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-dvb-maintainer@linuxtv.org
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Message-ID: <20050811064217.GB21395@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-dvb-maintainer@linuxtv.org
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Aug 07, 2005 at 11:47:53AM -0700, Linus Torvalds wrote:
> Apart from some reverts and the aic7xxx performance regression fix,
> there's arm and ppc updates, and some PCI resource allocation updates that
> hopefully will reduce the number of machines (especially laptopns) that
> have strange undocumented MB devices that clash in PCI IO space.. And 
> various small one-liners.

I got the following OOPS from running "alevtd -F -d -v /dev/vbi0" with
my Siemens-DVB-C on a Dual-i686-600. I'm able to reproduce this even
running a 2.6.12-rc6 without the nvidia module tainting the kernel.

Linux version 2.6.11.11 (root@titan) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #1 SMP Mon May 30 21:55:01 CEST 2005
...
saa7146: register extension 'dvb'.
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
saa7146: found saa7146 @ mem e0968000 (revision 1, irq 16) (0x110a,0x0000).
DVB: registering new adapter (Fujitsu Siemens DVB-C).
adapter has MAC addr = 00:d0:5c:01:83:6c
dvb-ttpci: gpioirq unknown type=0 len=0
dvb-ttpci: info @ card 0: firm f0240009, rtsl b0250018, vid 71010068, app 8000261d
dvb-ttpci: firmware @ card 0 supports CI link layer interface
dvb-ttpci: DVB-C analog module @ card 0 detected, initializing MSP3400
saa7146_vv: saa7146 (0): registered device video0 [v4l2]
saa7146_vv: saa7146 (0): registered device vbi0 [v4l2]
DVB: registering frontend 0 (VLSI VES1820 DVB-C)...
dvb-ttpci: found av7110-0.
...
kernel BUG at drivers/media/common/saa7146_video.c:741!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in: rfcomm l2cap bluetooth autofs4 thermal fan button processor ipv6 xfrm_user ipcomp ah4 ipt_state ip_conntrack iptable_filter ip_tables esp4 deflate zlib_deflate zlib_inflate twofish serpent aes_i586 blowfish des sha256 sha1 crypto_null af_key sg joydev analog ns558 gameport parport_pc parport floppy pcspkr 3c59x mii evdev dvb_ttpci dvb_core saa7146_vv video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299 tda8083 stv0297 sp8870 firmware_class ves1x93 ttpci_eeprom usbhid usb_storage i2c_piix4 uhci_hcd usbcore intel_agp nfsd exportfs lockd sunrpc binfmt_misc dm_mod snd_emu8000_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_util_mem snd_sbawe snd_opl3_lib snd_sb16_dsp snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_sb16_csp snd_sb_common snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore eeprom w83781d i2c_dev i2c_sensor i2c_core nvidia agpgart
CPU:    0
EIP:    0060:[<e0ae7e41>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.11.11)
EIP is at video_begin+0x1f1/0x270 [saa7146_vv]
eax: 00000000   ebx: dfc22060   ecx: 00000000   edx: 0000000a
esi: df30dce0   edi: dedfe800   ebp: de65be34   esp: de65be1c
ds: 007b   es: 007b   ss: 0068
Process alevtd (pid: 26938, threadinfo=de65a000 task=c417d540)
Stack: df30dce0 00000000 cfeeecb4 e0b077a0 40045612 dedfe800 de65be84 e0ae862c 
       dedfe800 dde21af8 00000001 de65be88 de65be60 dedfe800 d8ab7c40 c1582380 
       00000000 dedfea68 dfc22060 df30dce0 de65bea0 dfacf9c0 dde21af8 40045612 
Call Trace:
 [<c010407f>] show_stack+0x7f/0xa0
 [<c0104233>] show_registers+0x163/0x1d0
 [<c0104461>] die+0x101/0x190
 [<c010491c>] do_invalid_op+0xbc/0xd0
 [<c0103ce3>] error_code+0x2b/0x30
 [<e0ae862c>] saa7146_video_do_ioctl+0x59c/0xf60 [saa7146_vv]
 [<e0a3d4de>] video_usercopy+0x8e/0x160 [videodev]
 [<e0ae5d6f>] fops_ioctl+0x2f/0x40 [saa7146_vv]
 [<c016f3d3>] do_ioctl+0x63/0xa0
 [<c016f612>] vfs_ioctl+0x62/0x1d0
 [<c016f7e1>] sys_ioctl+0x61/0x90
 [<c010320d>] sysenter_past_esp+0x52/0x75
Code: ae e0 b8 2a c8 ae e0 be 17 ce ae e0 89 44 24 08 89 74 24 04 e8 e1 5e 63 df 89 7c 24 04 c7 04 24 40 da ae e0 e8 d1 5e 63 df eb ad <0f> 0b e5 02 60 da ae e0 e9 3f ff ff ff 89 f6 c7 04 24 0c ce ae

BYtE
Philipp

PS: MAINTAINTER lists http://linuxtv.org/developer/dvb.xml which is
dead.
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
