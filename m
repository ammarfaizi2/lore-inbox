Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVKGDRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVKGDRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVKGDRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:17:18 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:21129 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932434AbVKGDRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:14 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [Patch 15/20] V4L(916) Fixes set scart parameter definitions and
	audout ioctl
Date: Mon, 07 Nov 2005 00:58:10 -0200
Message-Id: <1131333341.25215.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- Fixes set_scart parameter definitions and AUDOUT ioctl

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

diff -upNr oldtree/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- oldtree/drivers/media/video/msp3400.c	2005-11-06 16:13:22.000000000 -0200
+++ linux/drivers/media/video/msp3400.c	2005-11-06 16:13:23.000000000 -0200
@@ -417,7 +417,7 @@ static void msp3400c_set_scart(struct i2
 
 	msp->in_scart=in;
 
-	if (in<=2) {
+	if (in >= 1 && in <= 8 && out >= 0 && out <= 2) {
 		if (-1 == scarts[out][in])
 			return;
 
@@ -2128,10 +2128,11 @@ static int msp_command(struct i2c_client
 	case VIDIOC_G_AUDOUT:
 	{
 		struct v4l2_audioout *a=(struct v4l2_audioout *)arg;
+		int idx=a->index;
 
 		memset(a,0,sizeof(*a));
 
-		switch (a->index) {
+		switch (idx) {
 		case 0:
 			strcpy(a->name,"Scart1 Out");
 			break;
@@ -2160,8 +2161,8 @@ static int msp_command(struct i2c_client
 			else
 				msp->i2s_mode=0;
 		}
-printk("Setting audio out on msp34xx to input %i, mode %i\n",a->index,msp->i2s_mode);
-		msp3400c_set_scart(client,msp->in_scart,a->index);
+		dprintk("Setting audio out on msp34xx to input %i, mode %i\n",a->index,msp->i2s_mode);
+		msp3400c_set_scart(client,msp->in_scart,a->index+1);
 
 		break;
 	}


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

