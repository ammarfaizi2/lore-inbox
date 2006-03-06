Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWCFI4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWCFI4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbWCFI4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:56:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7655 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751967AbWCFI4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:56:13 -0500
Date: Mon, 6 Mar 2006 03:56:00 -0500
From: Dave Jones <davej@redhat.com>
To: tiwai@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: sound/isa/sb/sb_mixer.c double kfree
Message-ID: <20060306085600.GA27555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_add() already does the free on error.

Coverity bug #957
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/isa/sb/sb_mixer.c~	2006-03-06 03:54:48.000000000 -0500
+++ linux-2.6/sound/isa/sb/sb_mixer.c	2006-03-06 03:55:06.000000000 -0500
@@ -453,10 +453,8 @@ int snd_sbmixer_add_ctl(struct snd_sb *c
 	strlcpy(ctl->id.name, name, sizeof(ctl->id.name));
 	ctl->id.index = index;
 	ctl->private_value = value;
-	if ((err = snd_ctl_add(chip->card, ctl)) < 0) {
-		snd_ctl_free_one(ctl);
+	if ((err = snd_ctl_add(chip->card, ctl)) < 0)
 		return err;
-	}
 	return 0;
 }
 
-- 
http://www.codemonkey.org.uk
