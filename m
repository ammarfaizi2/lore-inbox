Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVDOAtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVDOAtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDOAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:48:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261688AbVDOAsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:48:35 -0400
Date: Fri, 15 Apr 2005 02:48:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sscape.c: remove dead code
Message-ID: <20050415004834.GG20400@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found that sscape_sb_enable never get's assigned 
any value different from 0, and therefore some code paths are 
impossible.

This patch removes this variable and the dead code paths.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Mar 2005

 sound/oss/sscape.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.12-rc1-mm1-full/sound/oss/sscape.c.old	2005-03-23 01:10:35.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/oss/sscape.c	2005-03-23 01:11:38.000000000 +0100
@@ -991,7 +991,6 @@ static void __init sscape_pnp_init_hw(ss
 	unsigned i;
 	static	char code_file_name[23] = "/sndscape/sndscape.cox";
 	
-	int sscape_sb_enable		= 0;
 	int sscape_joystic_enable	= 0x7f;
 	int sscape_mic_enable		= 0;
 	int sscape_ext_midi		= 0;		
@@ -1015,14 +1014,9 @@ static void __init sscape_pnp_init_hw(ss
 	sscape_write( devc, 2, devc->ic_type == IC_ODIE ? 0x70 : 0x40);
 	sscape_write( devc, 3, ( devc -> dma << 4) | 0x80);
 
-	if ( sscape_sb_enable )
-		sscape_write (devc, 4, 0xF0 | (sb_irq << 2) | midi_irq);
-	else	
-		sscape_write (devc, 4, 0xF0 | (midi_irq<<2) | midi_irq);
+	sscape_write (devc, 4, 0xF0 | (midi_irq<<2) | midi_irq);
 
 	i = 0x10; //sscape_read(devc, 9) & (devc->ic_type == IC_ODIE ? 0xf0 : 0xc0);
-	if ( sscape_sb_enable )
-		i |= devc->ic_type == IC_ODIE ? 0x05 : 0x07;	    
 	if (sscape_joystic_enable) i |= 8;
 	
 	sscape_write (devc, 9, i);

