Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946215AbWKAFgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946215AbWKAFgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946163AbWKAFgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28359 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946123AbWKAFf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:56 -0500
Message-Id: <20061101053602.787664000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:48 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Arnaud Patard <arnaud.patard@rtp-net.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/61] ALSA: emu10k1: Fix outl() in snd_emu10k1_resume_regs()
Content-Disposition: inline; filename=alsa-emu10k1-fix-outl-in-snd_emu10k1_resume_regs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Arnaud Patard <arnaud.patard@rtp-net.org>

[PATCH] ALSA: emu10k1: Fix outl() in snd_emu10k1_resume_regs()

The emu10k1 driver saves the A_IOCFG and HCFG register on suspend and restores
it on resumes. Unfortunately, this doesn't work as the arguments to outl() are
reversed.

From: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/pci/emu10k1/emu10k1_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.1.orig/sound/pci/emu10k1/emu10k1_main.c
+++ linux-2.6.18.1/sound/pci/emu10k1/emu10k1_main.c
@@ -1460,8 +1460,8 @@ void snd_emu10k1_resume_regs(struct snd_
 
 	/* resore for spdif */
 	if (emu->audigy)
-		outl(emu->port + A_IOCFG, emu->saved_a_iocfg);
-	outl(emu->port + HCFG, emu->saved_hcfg);
+		outl(emu->saved_a_iocfg, emu->port + A_IOCFG);
+	outl(emu->saved_hcfg, emu->port + HCFG);
 
 	val = emu->saved_ptr;
 	for (reg = saved_regs; *reg != 0xff; reg++)

--
