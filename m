Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVI1Vyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVI1Vyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVI1Vyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:40 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:42245 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751064AbVI1VyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:22 -0400
Date: Wed, 28 Sep 2005 17:50:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
Subject: [patch 2.6.14-rc2 3/3] alsa: fix HD audio ALC882 lfe (un)mute
Message-ID: <09282005175053.11066@bilbo.tuxdriver.com>
In-Reply-To: <09282005175053.11001@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the ALC880 "LFE Playback Switch" as an input, like the other
playback switch settings.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This is speculative, based on the datasheet and my experience with the
ALC260. I do not have the actual hardware to test this myself. Testing
by others is requested, but I am pretty sure this is correct.

 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2501,7 +2501,7 @@ static snd_kcontrol_new_t alc882_base_mi
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
-	ALC_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
