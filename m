Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTDQFyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbTDQFxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:00 -0400
Received: from granite.he.net ([216.218.226.66]:54800 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263082AbTDQFvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:51:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595043780@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <1050559504756@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1059, 2003/04/14 10:21:36-07:00, greg@kroah.com

[PATCH] USB: kl5kusb105 fix up errors found by smatch


diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Wed Apr 16 10:49:14 2003
+++ b/drivers/usb/serial/kl5kusb105.c	Wed Apr 16 10:49:14 2003
@@ -964,8 +964,9 @@
 	     if (retval)
 			 return(retval);
 
-	     kernel_termios_to_user_termios((struct termios *)arg,  
-					    &priv->termios);
+	     if (kernel_termios_to_user_termios((struct termios *)arg,  
+						&priv->termios))
+		     return -EFAULT;
 	     return(0);
 	     }
 	case TCSETS: {
@@ -980,8 +981,9 @@
 		if (retval)
 			    return(retval);
 
-		user_termios_to_kernel_termios(&priv->termios,
-					       (struct termios *)arg);
+		if (user_termios_to_kernel_termios(&priv->termios,
+						  (struct termios *)arg))
+			return -EFAULT;
 		klsi_105_set_termios(port, &priv->termios);
 		return(0);
 	     }

