Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVI1VzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVI1VzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVI1Vyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:46 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:39941 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751043AbVI1VyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:09 -0400
Date: Wed, 28 Sep 2005 17:50:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
Subject: [patch 2.6.14-rc2 1/3] alsa: fix HD audio ALC260 mono (un)mute
Message-ID: <09282005175052.10938@bilbo.tuxdriver.com>
In-Reply-To: <09282005175052.10882@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ALC260 "Mono Playback Switch" is marked as an output in
patch_realtek.c. It actually does not work unless it is marked as an
input. Go figure... This was tested and confirmed on an HP xw4300.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2243,7 +2243,7 @@ static snd_kcontrol_new_t alc260_base_mi
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x09, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Headphone Playback Switch", 0x09, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
-	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x04, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x04, 0x0, HDA_INPUT),
 	{
@@ -2270,7 +2270,7 @@ static snd_kcontrol_new_t alc260_hp_mixe
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x09, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Headphone Playback Switch", 0x09, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
-	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x05, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x05, 0x0, HDA_INPUT),
 	{
