Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUE3LJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUE3LJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUE3LJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:09:54 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48347 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262574AbUE3LJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:09:41 -0400
Date: Sun, 30 May 2004 13:09:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org, jeffml@pobox.com, mbouget@club-internet.fr,
       jgarzik@pobox.com
Subject: Re: Linux 2.6.7-rc2
Message-ID: <20040530130902.A2756@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <c9c42l$228$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <c9c42l$228$1@news.cistron.nl>; from dth@ncc1701.cistron.net on Sun, May 30, 2004 at 07:56:05AM +0000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar <dth@ncc1701.cistron.net> :
[...
> Ethernet stopped working (for me) going from 2.6.7-rc1-bk3 to 2.6.7-rc2.
> AMD64/asusK8V with onboard ethernet.
[...]
> 2.6.7-rc1-bk3 worked like intended.

The patch below was applied between 2.6.7-rc1-bk3 and 2.6.7-rc1-bk4.

How does your kernel perform if you patch -R ?


diff -Nru a/drivers/net/sk98lin/skvpd.c b/drivers/net/sk98lin/skvpd.c
--- a/drivers/net/sk98lin/skvpd.c	2004-05-28 01:13:08 -07:00
+++ b/drivers/net/sk98lin/skvpd.c	2004-05-28 01:13:08 -07:00
@@ -468,6 +468,17 @@
 	
 	pAC->vpd.vpd_size = vpd_size;
 
+	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
+	/* MBo April 2004 */
+	if (((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45)) {
+		printk("sk98lin: Asus mainboard with buggy VPD? "
+				"Correcting data.\n");
+		pAC->vpd.vpd_buf[0x40] = 0x38;
+	}
+
+
 	/* find the end tag of the RO area */
 	if (!(r = vpd_find_para(pAC, VPD_RV, &rp))) {
 		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,

