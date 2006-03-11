Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWCKDn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWCKDn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWCKDn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:43:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932379AbWCKDnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:43:21 -0500
Date: Sat, 11 Mar 2006 04:43:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/pci/rme9652/hdspm.c: fix off-by-one errors
Message-ID: <20060311034321.GL21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes off-by-one errors found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/sound/pci/rme9652/hdspm.c.old	2006-03-11 03:11:15.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/pci/rme9652/hdspm.c	2006-03-11 03:12:10.000000000 +0100
@@ -474,7 +474,7 @@
 static inline int hdspm_read_in_gain(struct hdspm * hdspm, unsigned int chan,
 				     unsigned int in)
 {
-	if (chan > HDSPM_MIXER_CHANNELS || in > HDSPM_MIXER_CHANNELS)
+	if (chan >= HDSPM_MIXER_CHANNELS || in >= HDSPM_MIXER_CHANNELS)
 		return 0;
 
 	return hdspm->mixer->ch[chan].in[in];
@@ -483,7 +483,7 @@
 static inline int hdspm_read_pb_gain(struct hdspm * hdspm, unsigned int chan,
 				     unsigned int pb)
 {
-	if (chan > HDSPM_MIXER_CHANNELS || pb > HDSPM_MIXER_CHANNELS)
+	if (chan >= HDSPM_MIXER_CHANNELS || pb >= HDSPM_MIXER_CHANNELS)
 		return 0;
 	return hdspm->mixer->ch[chan].pb[pb];
 }

