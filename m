Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275357AbTHMVua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275363AbTHMVua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:50:30 -0400
Received: from panda.sul.com.br ([200.219.150.4]:35857 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id S275357AbTHMVuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:50:18 -0400
Date: Wed, 13 Aug 2003 18:37:39 -0300
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uinput oops and panic
Message-ID: <20030813213739.GB1020@cathedrallabs.org>
References: <18DFD6B776308241A200853F3F83D507169C68@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D507169C68@pl6w2kex.lan.powerlandcomputers.com>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	this patch solves the problem, thanks for reporting
	(i already sent it to Vojtech Pavlik that will submit it to linus)

-- 
aris

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uinput-setbit.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1149  -> 1.1150 
#	drivers/input/misc/uinput.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/13	aris@cathedrallabs.org	1.1150
# verify maximum number of bits before using set_bit
# --------------------------------------------
#
diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Wed Aug 13 17:50:03 2003
+++ b/drivers/input/misc/uinput.c	Wed Aug 13 17:50:03 2003
@@ -323,36 +323,67 @@
 			retval = uinput_destroy_device(udev);
 			break;
 
-
 		case UI_SET_EVBIT:
+			if (arg > EV_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->evbit);
 			break;
 			
 		case UI_SET_KEYBIT:
+			if (arg > KEY_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->keybit);
 			break;
 			
 		case UI_SET_RELBIT:
+			if (arg > REL_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->relbit);
 			break;
 			
 		case UI_SET_ABSBIT:
+			if (arg > ABS_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->absbit);
 			break;
 			
 		case UI_SET_MSCBIT:
+			if (arg > MSC_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->mscbit);
 			break;
 			
 		case UI_SET_LEDBIT:
+			if (arg > LED_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->ledbit);
 			break;
 			
 		case UI_SET_SNDBIT:
+			if (arg > SND_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->sndbit);
 			break;
 			
 		case UI_SET_FFBIT:
+			if (arg > FF_MAX) {
+				retval = -EINVAL;
+				break;
+			}
 			set_bit(arg, udev->dev->ffbit);
 			break;
 			

--NzB8fVQJ5HfG6fxh--
