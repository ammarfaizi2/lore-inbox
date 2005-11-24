Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbVKXMYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVKXMYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVKXMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:24:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56989 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030392AbVKXMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:24:23 -0500
Subject: stable review patch - ALSA ALC800 codec
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: stable@kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 07:23:13 -0500
Message-Id: <1132834994.20390.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an apparent copy and paste bug that has really been causing
problems for a lot of users.  It closes ~10 different ALSA bug reports,
see #1563 for example.  Please apply ASAP for -stable.

Lee

This patch is to fix the problem of calculating the nid incorrectly when
auto-probe for ALC880. The problem to be fixed often behaves with such
words when using dmesg, 'num_steps = 0 for NID=0x8' when auto-probe for
ALC880.

The patch contains:
- alsa-kernel/pci/hda/patch_realtek.c: replace 'alc880_dac_to_idx' with
'alc880_idx_to_dac' in function 'alc880_auto_fill_dac_nids()'

Signed-off-by: Libin Yang <libin.yang@intel.com>


--- alsa-driver-1.0.10/alsa-kernel/pci/hda/patch_realtek.c	2005-11-02 10:26:49.000000000 -0800
+++ my_alsa-driver-1.0.10/alsa-kernel/pci/hda/patch_realtek.c	2005-11-23 05:52:36.000000000 -0800
@@ -1809,7 +1809,7 @@
 		nid = cfg->line_out_pins[i];
 		if (alc880_is_fixed_pin(nid)) {
 			int idx = alc880_fixed_pin_idx(nid);
-			spec->multiout.dac_nids[i] = alc880_dac_to_idx(idx);
+			spec->multiout.dac_nids[i] = alc880_idx_to_dac(idx);
 			assigned[idx] = 1;
 		}
 	}


