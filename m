Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUAJXeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUAJXeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:34:05 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15297 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S265510AbUAJXd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:33:58 -0500
Date: Sun, 11 Jan 2004 00:33:23 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, alsa-devel@alsa-project.org
Subject: [2.6.1-mm2] ALSA sound/core/pcm_lib.c:224: Unexpected hw_pointer value
Message-ID: <20040110233323.GA16512@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org, perex@suse.cz,
	alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a (problem) report about warnings I get from my alsa kernel driver.
I have no problem with the sound itself. It is working 100%. The only
problem is kind of that the messages fill up my logs.
I am using linux kernel 2.6.1-mm2.

My sound device is an PCI sound card.

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
	Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
		PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


What I am constantly seeing is the following:

...
Jan 11 00:24:09 neon kernel: ALSA sound/core/pcm_lib.c:224: Unexpected 
	hw_pointer value [2] (stream = 0, delta: -7, max jitter = 8192): wrong 
	interrupt acknowledge?
Jan 11 00:24:10 neon kernel: ALSA sound/core/pcm_lib.c:224: Unexpected 
	hw_pointer value [2] (stream = 0, delta: -1, max jitter = 8192): wrong 
	interrupt acknowledge?
Jan 11 00:24:10 neon kernel: ALSA sound/core/pcm_lib.c:224: Unexpected
	hw_pointer value [2] (stream = 0, delta: -1, max jitter = 8192): wrong
	interrupt acknowledge?
Jan 11 00:24:10 neon kernel: ALSA sound/core/pcm_lib.c:224: Unexpected
	hw_pointer value [2] (stream = 0, delta: -3, max jitter = 8192): wrong
	interrupt acknowledge?
Jan 11 00:24:11 neon last message repeated 2 times
...

The messages appear about once every 1.5 seconds I'd say.

The relevant? part of my .config:

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y

#
# PCI devices
#
CONFIG_SND_CMIPCI=y

...

#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y


neon:/usr/local/src/system/kernel/linux-2.6.1> sh scripts/ver_linux
Linux neon 2.6.1-mm2 #2 Sat Jan 10 23:55:00 CET 2004 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.18
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ide_cd cdrom nvidia


Maybe this you can help me about this or even it might be of use to the
developers?!

Regards,
Axel Siebenwirth



____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

America is the country where you buy a lifetime
supply of aspirin for one dollar, and use it up in two weeks.
____________________________________________________________________________
