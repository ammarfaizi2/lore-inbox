Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDOQeH (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDOQeH 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:34:07 -0400
Received: from a4.veijo.ton.tut.fi ([193.166.236.20]:41360 "EHLO
	butthead.ton.tut.fi") by vger.kernel.org with ESMTP id S261789AbTDOQdg 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:33:36 -0400
From: Sami Nieminen <sami.nieminen@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Date: Tue, 15 Apr 2003 19:45:24 +0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lcDn+rSXh7d1t4j"
Message-Id: <200304151945.25193.sami.nieminen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lcDn+rSXh7d1t4j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you get this freeze when using a graphical login manager (xdm, gdm, kdm), 
attached patch from xfree86 bugzilla [1] fixed this problem for me (Radeon 
Mobility 9000).

[1] http://bugs.xfree86.org/cgi-bin/bugzilla/show_bug.cgi?id=94

BR, Sami
-- 
Linux 2.5.67-bk4

--Boundary-00=_lcDn+rSXh7d1t4j
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xfree-radeon-lockup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xfree-radeon-lockup.diff"

Index: programs/Xserver/hw/xfree86/drivers/ati/radeon_dri.c
===================================================================
RCS file: /cvs/xc/programs/Xserver/hw/xfree86/drivers/ati/radeon_dri.c,v
retrieving revision 1.32
diff -p -u -r1.32 radeon_dri.c
--- programs/Xserver/hw/xfree86/drivers/ati/radeon_dri.c	2003/02/19 09:17:30	1.32
+++ programs/Xserver/hw/xfree86/drivers/ati/radeon_dri.c	2003/03/17 01:43:24
@@ -1585,6 +1585,7 @@ void RADEONDRICloseScreen(ScreenPtr pScr
     if (info->irq) {
 	drmCtlUninstHandler(info->drmFD);
 	info->irq = 0;
+	info->ModeReg.gen_int_cntl = 0;
     }
 
 				/* De-allocate vertex buffers */

--Boundary-00=_lcDn+rSXh7d1t4j--

