Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCLSwz>; Mon, 12 Mar 2001 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130581AbRCLSwp>; Mon, 12 Mar 2001 13:52:45 -0500
Received: from cliff.i-plus.net ([209.100.20.42]:25863 "HELO cliff.i-plus.net")
	by vger.kernel.org with SMTP id <S130565AbRCLSwe>;
	Mon, 12 Mar 2001 13:52:34 -0500
From: Lee Brown <leejr@linuxsoftwareconsultants.com>
Organization: Linux Software Consultants
To: linux-kernel@vger.kernel.org
Subject: [patch]  Does this correct  a bug in ibmcam.c?
Date: Mon, 12 Mar 2001 03:52:02 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01031203541300.02643@darkstar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had problems with copy_from_user.

Please CC me as I am not on this list.
__________________________________


--- ibmcam.c.orig	Fri Feb  9 14:30:23 2001
+++ ibmcam.c	Mon Mar 12 02:58:57 2001
@@ -2527,16 +2527,17 @@
 		}
 		case VIDIOCSCHAN:
 		{
-			int v;
+			int chan;
 
-			if (copy_from_user(&v, arg, sizeof(v)))
-				return -EFAULT;
-			if ((v < 0) || (v >= 3)) /* 3 grades of lighting conditions */
-				return -EINVAL;
-			if (v != ibmcam->vchan.channel) {
-				ibmcam->vchan.channel = v;
+			chan = (int)arg;
+		
+			if ((chan < 0) || (chan >= 3)) /* 3 grades of lighting conditions */ 
+			 	return -EINVAL;			
+	
+			if (chan != ibmcam->vchan.channel) { 	
+				ibmcam->vchan.channel = chan; 			
 				usb_ibmcam_change_lighting_conditions(ibmcam);
-			}
+ 			}
 			return 0;
 		}
 		case VIDIOCGPICT:



-- 
Lee Brown Jr.
