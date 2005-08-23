Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVHWHdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVHWHdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVHWHdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:33:14 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7562 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750757AbVHWHdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:33:13 -0400
Message-ID: <430AD136.7070804@pobox.com>
Date: Tue, 23 Aug 2005 03:33:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch] 2.6.x i810_audio unwind-on-err fix
Content-Type: multipart/mixed;
 boundary="------------090202050808080505000301"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202050808080505000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to obtain the fix described in the attached diffstat/changelog/patch.


--------------090202050808080505000301
Content-Type: text/plain;
 name="misc-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.txt"



 sound/oss/i810_audio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


commit 7087e295543d3f6e161530e07982fd979e2d9efc
Author: John W. Linville <linville@tuxdriver.com>
Date:   Thu Aug 4 14:40:25 2005 -0400

    [PATCH] i810_audio: fix release_region misordering in error exit from i810_probe
    
    Re-order release_region calls in i810_probe to properly unwind preceding
    allocations.
    
    Signed-off-by: John W. Linville <linville@tuxdriver.com>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -3430,9 +3430,9 @@ out_iospace:
 		release_mem_region(card->iobase_mmio_phys, 256);
 	}
 out_pio:	
-	release_region(card->iobase, 64);
-out_region2:
 	release_region(card->ac97base, 256);
+out_region2:
+	release_region(card->iobase, 64);
 out_region1:
 	pci_free_consistent(pci_dev, sizeof(struct i810_channel)*NR_HW_CH,
 	    card->channel, card->chandma);

--------------090202050808080505000301--
