Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752304AbWCFI6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbWCFI6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCFI6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:58:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752302AbWCFI6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:58:43 -0500
Date: Mon, 6 Mar 2006 03:58:18 -0500
From: Dave Jones <davej@redhat.com>
To: tiwai@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ad1848 double free
Message-ID: <20060306085817.GA32625@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same again, snd_ctl_add() already kfree's on error.

Coverity #956
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/isa/ad1848/ad1848_lib.c~	2006-03-06 03:57:22.000000000 -0500
+++ linux-2.6/sound/isa/ad1848/ad1848_lib.c	2006-03-06 03:57:30.000000000 -0500
@@ -1202,10 +1202,8 @@ int snd_ad1848_add_ctl(struct snd_ad1848
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
