Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTBFAJy>; Wed, 5 Feb 2003 19:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTBFAJy>; Wed, 5 Feb 2003 19:09:54 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:25282
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S265205AbTBFAJw>; Wed, 5 Feb 2003 19:09:52 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Andrew Morton <akpm@digeo.com>
Subject: soundcard bug in 2.5.59-mm8
Date: Wed, 5 Feb 2003 18:19:27 -0600
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302051819.27136.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an error in the link process when trying to use the 
ES1968 driver. I haven't ever tried it on previous kernels, but 
when this one blew, I checked it against vanilla 2.5.59, and it 
finished fine there. Output and config options below. Let me 
know if you need more.
---scott

make -f scripts/Makefile.build obj=arch/i386/lib
echo '  Generating build number'
  Generating build number
. ./scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=version 
-DKBUILD_MODNAME=version -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o 
init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   
init/built-in.o --start-group  usr/built-in.o  
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-default/built-in.o  kernel/built-in.o  
mm/built-in.o  fs/built-in.o  ipc/built-in.o  
security/built-in.o  crypto/built-in.o  lib/lib.a  
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
sound/built-in.o(.text+0x3750b): In function 
`snd_opl3_synth_event_input':
: undefined reference to `snd_seq_instr_event'
sound/built-in.o(.text+0x37524): In function 
`snd_opl3_synth_event_input':
: undefined reference to `snd_midi_process_event'
sound/built-in.o(.text+0x3755f): In function 
`snd_opl3_synth_create_port':
: undefined reference to `snd_midi_channel_alloc_set'
sound/built-in.o(.text+0x37632): In function 
`snd_opl3_synth_create_port':
: undefined reference to `snd_midi_channel_free_set'
sound/built-in.o(.text+0x3772e): In function 
`snd_opl3_seq_new_device':
: undefined reference to `snd_seq_instr_list_new'
sound/built-in.o(.text+0x37771): In function 
`snd_opl3_seq_new_device':
: undefined reference to `snd_seq_fm_init'
sound/built-in.o(.text+0x37820): In function 
`snd_opl3_seq_delete_device':
: undefined reference to `snd_seq_instr_list_free'
sound/built-in.o(.text+0x3753c): In function 
`snd_opl3_synth_free_port':
: undefined reference to `snd_midi_channel_free_set'
sound/built-in.o(.text+0x37d8d): In function `snd_opl3_note_on':
: undefined reference to `snd_seq_instr_find'
sound/built-in.o(.text+0x381ab): In function `snd_opl3_note_on':
: undefined reference to `snd_seq_instr_free_use'
sound/built-in.o(.text+0x3843b): In function `snd_opl3_note_on':
: undefined reference to `snd_seq_instr_free_use'
sound/built-in.o(.text+0x38d63): In function 
`snd_opl3_oss_event_input':
: undefined reference to `snd_midi_process_event'
sound/built-in.o(.text+0x38daa): In function 
`snd_opl3_oss_create_port':
: undefined reference to `snd_midi_channel_alloc_set'
sound/built-in.o(.text+0x38e6d): In function 
`snd_opl3_oss_create_port':
: undefined reference to `snd_midi_channel_free_set'
sound/built-in.o(.text+0x39274): In function 
`snd_opl3_load_patch_seq_oss':
: undefined reference to `snd_seq_instr_event'
sound/built-in.o(.text+0x39300): In function 
`snd_opl3_load_patch_seq_oss':
: undefined reference to `snd_seq_instr_event'
sound/built-in.o(.text+0x38d7c): In function 
`snd_opl3_oss_free_port':
: undefined reference to `snd_midi_channel_free_set'
make: *** [vmlinux] Error 1

=== Relevant (I hope!) config file settings ===
#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_CMIPCI=y
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=y
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

