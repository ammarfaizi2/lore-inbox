Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVIMOxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVIMOxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVIMOxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:53:05 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:13979 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932652AbVIMOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:53:04 -0400
Date: Tue, 13 Sep 2005 15:52:47 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: [PATCH] - allow multiple ac97 quirks for one piece of hardware
Message-ID: <20050913145247.GA8422@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@vavatch.codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ac97_tune_hardware currently exits after applying a single ac97 
quirk. There are bits of hardware (current HPs, for instance) that 
probably want two - MUTE_LED and HP_ONLY. The following trivial patch 
only exits if a quirk fails to apply. I'll send patches adding the 
quirks when I've made sure they work as expected on these machines.

--- sound/pci/ac97/ac97_codec.c.orig	2005-09-13 15:45:35.000000000 +0100
+++ linux/sound/pci/ac97/ac97_codec.c	2005-09-13 15:46:05.000000000 +0100
@@ -2551,9 +2551,10 @@ int snd_ac97_tune_hardware(ac97_t *ac97,
 				continue;
 			snd_printdd("ac97 quirk for %s (%04x:%04x)\n", quirk->name, ac97->subsystem_vendor, ac97->subsystem_device);
 			result = apply_quirk(ac97, quirk->type);
-			if (result < 0)
+			if (result < 0) {
 				snd_printk(KERN_ERR "applying quirk type %d for %s failed (%d)\n", quirk->type, quirk->name, result);
-			return result;
+				return result;
+			}
 		}
 	}
 	return 0;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
