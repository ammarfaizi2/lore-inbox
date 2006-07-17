Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWGQQrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWGQQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWGQQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:35514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750944AbWGQQcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:03 -0400
Date: Mon, 17 Jul 2006 09:29:01 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 38/45] ALSA: Fix mute switch on VAIO laptops with STAC7661
Message-ID: <20060717162901.GM4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-mute-switch-on-vaio-laptops-with-stac7661.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix mute switch on VAIO laptops with STAC7661

Fixed the master mute switch on VAIO laptops with STAC7661
codec chip.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_sigmatel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_sigmatel.c
+++ linux-2.6.17.6/sound/pci/hda/patch_sigmatel.c
@@ -1262,13 +1262,13 @@ static int vaio_master_sw_put(struct snd
 	int change;
 
 	change = snd_hda_codec_amp_update(codec, 0x02, 0, HDA_OUTPUT, 0,
-					  0x80, valp[0] & 0x80);
+					  0x80, (valp[0] ? 0 : 0x80));
 	change |= snd_hda_codec_amp_update(codec, 0x02, 1, HDA_OUTPUT, 0,
-					   0x80, valp[1] & 0x80);
+					   0x80, (valp[1] ? 0 : 0x80));
 	snd_hda_codec_amp_update(codec, 0x05, 0, HDA_OUTPUT, 0,
-				 0x80, valp[0] & 0x80);
+				 0x80, (valp[0] ? 0 : 0x80));
 	snd_hda_codec_amp_update(codec, 0x05, 1, HDA_OUTPUT, 0,
-				 0x80, valp[1] & 0x80);
+				 0x80, (valp[1] ? 0 : 0x80));
 	return change;
 }
 

--
