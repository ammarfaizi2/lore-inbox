Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTBUPj4>; Fri, 21 Feb 2003 10:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbTBUPj4>; Fri, 21 Feb 2003 10:39:56 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:23771 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267510AbTBUPjz>; Fri, 21 Feb 2003 10:39:55 -0500
Date: Fri, 21 Feb 2003 16:49:53 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.21-pre4-bk] make mousedev accept the jogdial
Message-ID: <20030221164953.K12004@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch is required in order to make the input subsystem
accept the Sony Vaio jogdial as a valid input device.

A similar fix want into the 2.5 tree.

Marcelo, Alan, please apply.

Thanks.

Stelian.


===== drivers/input/mousedev.c 1.5 vs edited =====
--- 1.5/drivers/input/mousedev.c	Tue Feb  5 08:49:25 2002
+++ edited/drivers/input/mousedev.c	Fri Feb  7 11:20:54 2003
@@ -409,10 +409,13 @@
 	int minor = 0;
 
 	if (!test_bit(EV_KEY, dev->evbit) ||
-	   (!test_bit(BTN_LEFT, dev->keybit) && !test_bit(BTN_TOUCH, dev->keybit)))
+	    (!test_bit(BTN_LEFT, dev->keybit) && 
+	     !test_bit(BTN_MIDDLE, dev->keybit) && 
+	     !test_bit(BTN_TOUCH, dev->keybit)))
 		return NULL;
 
 	if ((!test_bit(EV_REL, dev->evbit) || !test_bit(REL_X, dev->relbit)) &&
+	    (!test_bit(EV_REL, dev->evbit) || !test_bit(REL_WHEEL, dev->relbit)) &&
 	    (!test_bit(EV_ABS, dev->evbit) || !test_bit(ABS_X, dev->absbit)))
 		return NULL;
 


-- 
Stelian Pop <stelian@popies.net>
