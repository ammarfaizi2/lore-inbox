Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVCWXtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVCWXtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:49:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53007 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262087AbVCWXox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:44:53 -0500
Date: Thu, 24 Mar 2005 00:44:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sscape.c: remove dead code
Message-ID: <20050323234451.GG1948@stusta.de>
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

