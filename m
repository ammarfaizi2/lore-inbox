Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFJKGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFJKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:04:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7657 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261798AbTFJKED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:04:03 -0400
Date: Tue, 10 Jun 2003 15:50:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Misc 2.5 Fixes: cp-user-vicam
Message-ID: <20030610102024.GK2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610101801.GJ2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix handling of user bufs (arg), use copy_from_user.


 drivers/usb/media/vicam.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff -puN drivers/usb/media/vicam.c~cp-user-vicam drivers/usb/media/vicam.c
--- linux-2.5.70-ds/drivers/usb/media/vicam.c~cp-user-vicam	2003-06-08 03:55:24.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/usb/media/vicam.c	2003-06-08 04:03:39.000000000 +0530
@@ -611,7 +611,12 @@ vicam_ioctl(struct inode *inode, struct 
 
 	case VIDIOCSPICT:
 		{
-			struct video_picture *vp = (struct video_picture *) arg;
+			struct video_picture vp;
+
+			if (copy_from_user(&vp, arg, sizeof (vp))) {
+				retval = -EFAULT;
+				break;
+			}
 
 			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp->depth,
 			    vp->palette);
@@ -652,7 +657,12 @@ vicam_ioctl(struct inode *inode, struct 
 	case VIDIOCSWIN:
 		{
 
-			struct video_window *vw = (struct video_window *) arg;
+			struct video_window vw;
+
+			if (copy_from_user(&vw, arg, sizeof (vw))) {
+				retval = -EFAULT;
+				break;
+			}
 			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
 
 			if ( vw->width != 320 || vw->height != 240 )

_
