Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKIFZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKIFZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKIFZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:25:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:47006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261367AbUKIFYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:52 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <1099977857196@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <10999778574012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.20, 2004/11/08 16:45:03-08:00, jthiessen@penguincomputing.com

[PATCH] I2C: fix lm85.c build warnings

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm85.c |   32 --------------------------------
 1 files changed, 32 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-11-08 18:54:44 -08:00
+++ b/drivers/i2c/chips/lm85.c	2004-11-08 18:54:44 -08:00
@@ -210,38 +210,6 @@
  *       MSB (bit 3, value 8).  If the enable bit is 0, the encoded value
  *       is ignored, or set to 0.
  */
-static int lm85_smooth_map[] = {  /* .1 sec */
-		350, 176, 118,  70,  44,   30,   16,    8
-/*    35.4 *    1/1, 1/2, 1/3, 1/5, 1/8, 1/12, 1/24, 1/48  */
-	};
-static int SMOOTH_TO_REG( int smooth )
-{
-	int i;
-
-	if( smooth <= 0 ) { return 0 ; }  /* Disabled */
-	for( i = 0 ; i < 7 ; ++i )
-		if( smooth >= lm85_smooth_map[i] )
-			break ;
-	return( (i & 0x07) | 0x08 );
-}
-#define SMOOTH_FROM_REG(val) ((val)&0x08?lm85_smooth_map[(val)&0x07]:0)
-
-/* These are the fan spinup delay time encodings */
-static int lm85_spinup_map[] = {  /* .1 sec */
-		0, 1, 2, 4, 7, 10, 20, 40
-	};
-static int SPINUP_TO_REG( int spinup )
-{
-	int i;
-
-	if( spinup >= lm85_spinup_map[7] ) { return 7 ; }
-	for( i = 0 ; i < 7 ; ++i )
-		if( spinup <= lm85_spinup_map[i] )
-			break ;
-	return( i & 0x07 );
-}
-#define SPINUP_FROM_REG(val) (lm85_spinup_map[(val)&0x07])
-
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
 		100, 150, 230, 300, 380, 470, 620, 940

