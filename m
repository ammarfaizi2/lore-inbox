Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVCDBNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVCDBNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVCDBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:10:21 -0500
Received: from tantale.fifi.org ([64.81.251.130]:39830 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262824AbVCDBGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:06:21 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux@syskonnect.de
Subject: Re: 2.4.29 sk98lin patch for Asus K8W SE Deluxe
References: <873bvdbtdt.fsf@ceramic.fifi.org>
	<20050303075220.GG30106@alpha.home.local>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 03 Mar 2005 17:06:10 -0800
In-Reply-To: <20050303075220.GG30106@alpha.home.local>
Message-ID: <87zmxkrzi5.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:

> On Wed, Mar 02, 2005 at 02:00:30PM -0800, Philippe Troin wrote:
>   
> > +	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
> > +	/* MBo April 2004 */
> > +	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
> > +	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
> > +	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
> > +		printk("sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
>                       ^^^^^
> Please, could you put some KERN_XXX here to avoid a buggy message level ?

Yes, of course.

Phil.

Signed-Off-By: Philippe Troin <phil@fifi.rog>

diff -ruN linux-2.4.29.orig/drivers/net/sk98lin/skvpd.c linux-2.4.29/drivers/net/sk98lin/skvpd.c
--- linux-2.4.29.orig/drivers/net/sk98lin/skvpd.c	Wed Apr 14 06:05:30 2004
+++ linux-2.4.29/drivers/net/sk98lin/skvpd.c	Mon Feb 21 02:03:00 2005
@@ -466,6 +466,15 @@
 	
 	pAC->vpd.vpd_size = vpd_size;
 
+	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
+	/* MBo April 2004 */
+	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
+		printk(KERN_INFO "sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
+		(unsigned char)pAC->vpd.vpd_buf[0x40] = 0x38;
+	}
+
 	/* find the end tag of the RO area */
 	if (!(r = vpd_find_para(pAC, VPD_RV, &rp))) {
 		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,
