Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWDERaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWDERaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWDERaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:30:20 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:34717 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbWDERaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:30:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=I9zD+2NEHbI9DgMYgzlz80timRWPMq/4b2sISnaZ2unRqEo1Sc2MVGQ0Ks+ilt2jge6pstaoHIXBYkzlbYjWbmxyiT8Yjy2q+LZw0cZoAJW5vXal+3yPoYMKipCNRMFtp6uHZwAWjyhQighwOMgCw8hrnBQMiwexSu+gsxjIRFs=
Date: Wed, 5 Apr 2006 19:30:02 +0200
From: Luca <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, alsa-devel@alsa-project.org
Subject: [2.6.17-rc1] ALSA oops with multiple OSS clients
Message-ID: <20060405173002.GA5306@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've a reproducible OOPS when starting multiple OSS clients.
To reproduce I do this:
mpg123 song.mp3
mpg123 song.mp3 (another time)

At this point the song restart from the beginning (i.e. I think that 
the second mpg123 takes over the device). When the second instance
terminates the song I get the following OOPS:

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000260
 printing eip:
f18df6e0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: radeon drm lp cls_u32 cls_route sch_sfq sch_cbq nfsd
exportfs lockd sunrpc nls_iso8859_15 nls_cp850 vfat fat
nls_utf8 ntfs xfs reiserfs tcp_westwood w83627hf hwmon_vid i2c_isa ipv6
snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device uhci_hcd rtc
snd usbcore i2c_viapro soundcore via_agp agpgart
CPU:    0
EIP:    0060:[<f18df6e0>]    Not tainted VLI
EFLAGS: 00210286   (2.6.17-rc1 #5)
EIP is at snd_pcm_oss_write2+0x20/0xf0 [snd_pcm_oss]
eax: efe804a0   ebx: 00000000   ecx: 00000000   edx: 0808f158
esi: 00002000   edi: efe804a0   ebp: 0808f158   esp: cc1ebf3c
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 4843, threadinfo=cc1ea000 task=e80e2530)
Stack: <0>00000000 0001e09c 00000000 b03f6a68 ea4e33a0 0808f0d8 b1a97800 00003f80
       f18e0aa7 00000000 0808f158 efe804a0 00000080 ea4e33a0 0808f0d8 cc1ebfa4
       00004000 b015aaa3 cc1ebfa4 f18e0930 ea4e33a0 fffffff7 00000003 cc1ea000
Call Trace:
 <f18e0aa7> snd_pcm_oss_write+0x177/0x1e0 [snd_pcm_oss]   <b015aaa3> vfs_write+0xa3/0x160
 <f18e0930> snd_pcm_oss_write+0x0/0x1e0 [snd_pcm_oss]   <b015b111> sys_write+0x41/0x70
 <b010301f> syscall_call+0x7/0xb
Code: ff ff ff 5b 5e 5f 5d c3 8d 76 00 83 ec 20 89 74 24 14 89 7c 24 18
89 c7 89 6c 24 1c 89 5c 24 10 89 ce 8b 58 5c 89 d5 8b 4c 24 24 <8b> 83
60 02 00 00 85 c0 74 6e 8b 50 20 85 c9 89 54 24 04 8b 40
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual
address 000000a0
 printing eip:
f18e1918
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: radeon drm lp cls_u32 cls_route sch_sfq sch_cbq nfsd
exportfs lockd sunrpc nls_iso8859_15 nls_cp850 vfat fat
nls_utf8 ntfs xfs reiserfs tcp_westwood w83627hf hwmon_vid i2c_isa ipv6
snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device uhci_hcd rtc
snd usbcore i2c_viapro soundcore via_agp agpgart
CPU:    0
EIP:    0060:[<f18e1918>]    Not tainted VLI
EFLAGS: 00210286   (2.6.17-rc1 #5)
EIP is at snd_pcm_oss_sync+0x18/0x240 [snd_pcm_oss]
eax: efe804a0   ebx: 00000008   ecx: f18e26f0   edx: ea4e33a0
esi: 00000000   edi: ef8ab000   ebp: cc1ebdc8   esp: cc1ebda0
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 4843, threadinfo=cc1ea000 task=e80e2530)
Stack: <0>ed85c800 00000000 0000059b de601900 efe804a0 7ffffa65 00000000 00000008
       de601900 ef8ab000 ea4e33a0 f18e271b 00000008 00200246 cc1ea000 ef6011bc
       00000008 ef667fb8 ef60109c ea4e33a0 b015b55a 00000000 ef667f60 effe3e20
Call Trace:
 <f18e271b> snd_pcm_oss_release+0x2b/0x120 [snd_pcm_oss]   <b015b55a> __fput+0xaa/0x1e0
 <b0158687> filp_close+0x47/0x80   <b011c997> put_files_struct+0x97/0xc0
 <b011ddb5> do_exit+0x145/0x970   <b0103a62> common_interrupt+0x1a/0x20
 <b0104586> die+0x266/0x270   <b011524e> do_page_fault+0x29e/0x6ae
 <b0114fb0> do_page_fault+0x0/0x6ae   <b0103b2b> error_code+0x4f/0x54
 <f18df6e0> snd_pcm_oss_write2+0x20/0xf0 [snd_pcm_oss]   <f18e0aa7> snd_pcm_oss_write+0x177/0x1e0 [snd_pcm_oss]
 <b015aaa3> vfs_write+0xa3/0x160   <f18e0930> snd_pcm_oss_write+0x0/0x1e0 [snd_pcm_oss]
 <b015b111> sys_write+0x41/0x70   <b010301f> syscall_call+0x7/0xb
Code: c7 42 14 f4 ff ff ff 8b 44 24 04 e8 23 05 a2 be eb 9a 90 55 89 e5
57 56 53 83 ec 1c 89 45 e4 8b 00 85 c0 89 45 e8 74 4d 8b 70 5c <8b> 86
a0 00 00 00 85 c0 0f 84 8a 00 00 00 8b 45 e8 31 c9 8b 90
 <1>Fixing recursive fault but reboot is needed!

The first instance of mpg123 remains in D state:

mpg123        D B036A4B8  5560  4843   4833                     (L-TLB)
       cc1ebca4 c7b31920 00000002 b036a4b8 b03f81c0 cc1ea000 a2bac600 003d0c01
       00000009 e80e2638 e80e2530 a2bac600 003d0c01 00000000 00000000 00000000
       cc1ea000 06acfc00 00000000 cc1ea000 e80e2530 ffffffff 0000000b b011e53d
Call Trace:
 <b011e53d> do_exit+0x8cd/0x970   <b0300480> preempt_schedule+0x50/0x70
 <b0104586> die+0x266/0x270   <b011524e> do_page_fault+0x29e/0x6ae
 <b0114fb0> do_page_fault+0x0/0x6ae   <b0103b2b> error_code+0x4f/0x54
 <f18e26f0> snd_pcm_oss_release+0x0/0x120 [snd_pcm_oss]   <f18e1918> snd_pcm_oss_sync+0x18/0x240 [snd_pcm_oss]
 <f18e271b> snd_pcm_oss_release+0x2b/0x120 [snd_pcm_oss]   <b015b55a> __fput+0xaa/0x1e0
 <b0158687> filp_close+0x47/0x80   <b011c997> put_files_struct+0x97/0xc0
 <b011ddb5> do_exit+0x145/0x970   <b0103a62> common_interrupt+0x1a/0x20
 <b0104586> die+0x266/0x270   <b011524e> do_page_fault+0x29e/0x6ae
 <b0114fb0> do_page_fault+0x0/0x6ae   <b0103b2b> error_code+0x4f/0x54
 <f18df6e0> snd_pcm_oss_write2+0x20/0xf0 [snd_pcm_oss]   <f18e0aa7> snd_pcm_oss_write+0x177/0x1e0 [snd_pcm_oss]
 <b015aaa3> vfs_write+0xa3/0x160   <f18e0930> snd_pcm_oss_write+0x0/0x1e0 [snd_pcm_oss]
 <b015b111> sys_write+0x41/0x70   <b010301f> syscall_call+0x7/0xb


The default ALSA device (in case it matters) is dmix. mpg123 is the old
mpg123 (not mpg321) and it's using the OSS interface (emulated by ALSA).

The relevant portion of my .config:

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y <-- It may be related to this one?
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y
#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
#
# PCI devices
#
CONFIG_SND_VIA82XX=m


Luca
-- 
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
seinza sentir squillare il telefono
