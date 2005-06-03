Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFCPCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFCPCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFCPCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:02:10 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:58547 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261313AbVFCPBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:01:53 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] More USB bugfixes for 2.6.12-rc5
Date: Fri, 3 Jun 2005 08:01:35 -0700
User-Agent: KMail/1.7.1
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gsker@tcfreenet.org
References: <20050603085830.GA31276@kroah.com>
In-Reply-To: <20050603085830.GA31276@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PDHoCjkuvpzuuZQ"
Message-Id: <200506030801.35685.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PDHoCjkuvpzuuZQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 03 June 2005 1:58 am, Greg KH wrote:
> Here are some more USB patches for the 2.6.12-rc5 tree. 

And attached, one more (non-GIT) patch to resolve a Zaurus problem.
OSDL bugids #4512 and #4545 seem to be duplicates of this report.
Please merge for 2.6.12-final... it's an obvious one-line fix.

- Dave


--Boundary-00=_PDHoCjkuvpzuuZQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usbnet_zaurus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbnet_zaurus.patch"

This "obvious" one-liner is needed to recognize Zaurus SL 6000;
it just checks two GUIDs not just one. 

From: Gerald Skerbitz <gsker@tcfreenet.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- linux-2.6.12-rc5/drivers/usb/net/usbnet.c.orig	2005-06-01 18:06:20.000000000 -0500
+++ linux-2.6.12-rc5/drivers/usb/net/usbnet.c	2005-06-01 18:29:30.000000000 -0500
@@ -2765,7 +2765,7 @@ static int blan_mdlm_bind (struct usbnet
 			}
 			/* expect bcdVersion 1.0, ignore */
 			if (memcmp(&desc->bGUID, blan_guid, 16)
-				    && memcmp(&desc->bGUID, blan_guid, 16) ) {
+				    && memcmp(&desc->bGUID, safe_guid, 16) ) {
 				/* hey, this one might _really_ be MDLM! */
 				dev_dbg (&intf->dev, "MDLM guid\n");
 				goto bad_desc;



--Boundary-00=_PDHoCjkuvpzuuZQ--
