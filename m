Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVDASh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVDASh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVDAShC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:37:02 -0500
Received: from iabervon.org ([66.92.72.58]:48900 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262856AbVDASfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:35:45 -0500
Date: Fri, 1 Apr 2005 13:36:29 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Break the Frobnozzle Gadget
Message-ID: <Pine.LNX.4.21.0504011321490.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An significant typo in the driver for the Frobnozzle got omitted. This
patch causes parts of some writes to be silently lost, and is probably
responsible for http://bugzilla.kernel.org/show_bug.cgi?id=5362.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

--- linux-2.6.11/drivers/usb/gadget/fbnz.c	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.11-brk/drivers/usb/gadget/fbnz.c	2005-04-01 12:38:15.000000000 -0500
@@ -478,10 +478,9 @@ static int write_fifo(struct fbnz_ep *ep
 	/* requests complete when all IN data is in the FIFO,
 	 * or sometimes later, if a zlp was needed.
 	 */
-	if (is_last) {
+	if (is_last)
 		done(ep, req, 0);
 		return 1;
-	}
 
 	return 0;
 }


