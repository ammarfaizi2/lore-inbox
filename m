Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUCTUAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbUCTUAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:00:47 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:65290 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263523AbUCTUAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:00:40 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.5-rc2] CAN-2004-0075 still valid for 2.6?
Date: Sat, 20 Mar 2004 20:59:33 +0100
User-Agent: KMail/1.6.1
Cc: linux-usb-users@lists.sourceforge.net, Greg Kroah-Hartman <greg@kroah.com>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403202059.33039@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lKKXAg2zvU2QKsA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lKKXAg2zvU2QKsA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Greg,

seems $subject is still valid for 2.6, no? - 2.4 got a fix 11 weeks ago.

See this: 
http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/usb/vicam.c@1.15?nav=index.html|
src/|src/drivers|src/drivers/usb|hist/drivers/usb/vicam.c

Please apply.

ciao, Marc

--Boundary-00=_lKKXAg2zvU2QKsA
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="CAN-2004-0075-usb-vicam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="CAN-2004-0075-usb-vicam.patch"

# drivers/usb/media/vicam.c |   13 ++++++++++---
# 1 files changed, 10 insertions(+), 3 deletions(-)

diff -urN linux-old/drivers/usb/media/vicam.c linux-wolk-for-2.6drivers/usb/media/vicam.c
--- linux-old/drivers/usb/media/vicam.c	2003-11-28 10:26:20.000000000 -0800
+++ linux-wolk-for-2.6drivers/usb/media/vicam.c	2004-01-15 12:10:23.000000000 -0800
@@ -653,12 +653,19 @@
 	case VIDIOCSWIN:
 		{
 
-			struct video_window *vw = (struct video_window *) arg;
-			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			struct video_window vw;
 
-			if ( vw->width != 320 || vw->height != 240 )
+			if (copy_from_user(&vw, arg, sizeof(vw)))
+			{
 				retval = -EFAULT;
+				break;
+			}
+
+			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
 			
+			if ( vw.width != 320 || vw.height != 240 )
+				retval = -EFAULT;
+
 			break;
 		}
 

--Boundary-00=_lKKXAg2zvU2QKsA--

