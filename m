Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUAXAAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUAXAAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:00:11 -0500
Received: from smtp.mailix.net ([216.148.213.132]:64140 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S266796AbUAXAAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:00:04 -0500
Date: Sat, 24 Jan 2004 00:59:58 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: akpm@digeo.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc1-mm2: alsa-101.patch
Message-ID: <20040123235958.GA1172@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>, akpm@digeo.com,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

