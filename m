Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSHOVrl>; Thu, 15 Aug 2002 17:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSHOVrl>; Thu, 15 Aug 2002 17:47:41 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63430 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317520AbSHOVrk>; Thu, 15 Aug 2002 17:47:40 -0400
Date: Thu, 15 Aug 2002 16:50:33 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Alan Cox <alan@redhat.com>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <200208152054.g7FKsif02357@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0208151649030.849-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Alan Cox wrote:

> > > Linux 2.4.20-pre2-ac2
> > >...
> > > o	Tweak isdn to try and fix gcc 2.95 compile 	(Kai Germaschewski)
> > >...
> > 
> > Compilation of 2.4.20-pre2-ac3 fails:
> 
> Ok fixed the ifdef way to handle the old cpp problems then

Well, so I had to dowload and compile gcc 2.95 and reproduce the
problem... The following patch fixes it:

diff -ur linux-2.4.20-pre2/drivers/isdn/hisax/hisax_debug.h linux-2.4.20-pre2.x/drivers/isdn/hisax/hisax_debug.h
--- linux-2.4.20-pre2/drivers/isdn/hisax/hisax_debug.h	Thu Aug 15 16:48:25 2002
+++ linux-2.4.20-pre2.x/drivers/isdn/hisax/hisax_debug.h	Thu Aug 15 
16:48:04 2002
@@ -28,7 +28,7 @@
 
 #define DBG(level, format, arg...) do { \
 if (level & __debug_variable) \
-printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__, ## arg); \
+printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__ , ## arg); \
 } while (0)
 
 #define DBG_PACKET(level,data,count) \


