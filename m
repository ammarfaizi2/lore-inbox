Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUAXAIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUAXAIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:08:46 -0500
Received: from smtp.mailix.net ([216.148.213.132]:65165 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263596AbUAXAIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:08:42 -0500
Date: Sat, 24 Jan 2004 01:08:33 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: akpm@digeo.com, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040124000833.GA1280@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>, akpm@digeo.com,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: 2.6.2-rc1-mm2: alsa-101.patch (+lspci)
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.142.150.79 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.142.150.79 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.142.150.79 listed in dnsbl.sorbs.net]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.142.150.79 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1AkBOS-0003P2-4i)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot lspci, resend)

The patch disables sound for me. The programs play sound normally,
without any errors, there is just nothing out of the boxes.
Everything, I could think of, is unmuted.
Reverting the patch brings sound back.

I applied _not_ all of the -mm patches, so probably there is something
very important but not containing alsa anywhere in patch name.

It is an SMP (ht) machine.

Drivers:
snd_intel8x0           29476  0 
snd_ac97_codec         51204  1 snd_intel8x0
snd_pcm                88608  2 snd_pcm_oss,snd_intel8x0
snd_timer              22916  1 snd_pcm
snd_page_alloc          9220  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6656  1 snd_intel8x0
snd_rawmidi            21024  1 snd_mpu401_uart
snd_seq_device          7048  1 snd_rawmidi
snd                    45028  9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7776  1 snd

gcc (GCC) 3.3.2 20031022 (Gentoo Linux 3.3.2-r2, propolice)

alsa-lib is 1.0.1.

Applied patches (in order):
pci-probing-typo.patch
acpi.patch
acpi-20031203-fix.patch
acpi-frees-irq0.patch
sched-find_busiest_node-resolution-fix.patch
sched-domains.patch
sched-clock-fixes.patch
sched-build-fix.patch
sched-sibling-map-to-cpumask.patch
p4-clockmod-sibling-map-fix.patch
p4-clockmod-more-than-two-siblings.patch
sched-domains-i386-ht.patch
sched-domain-tweak.patch
sched-no-drop-balance.patch
sched-arch_init_sched_domains-fix.patch
sched-find_busiest_group-clarification.patch
sched-remove-noisy-printks.patch
show_task-free-stack-fix.patch
oops-dump-preceding-code.patch
alsa-101.patch

Alsa was applied last, and kernel was tested to work (with sound)
before applying alsa-101.

The only message in log: "kernel: intel8x0: clocking to 48000"
(in both kernels, working and not).

strace didn't any errors on the silent kernel.


The car is an onboard audio controller of Gigabyte GA9IPE1000 Pro:

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Giga-byte Technology: Unknown device a002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc00 [size=64]
	Region 2: Memory at f2201000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f2202000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

