Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUG0STv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUG0STv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUG0STu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:19:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266534AbUG0STr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:19:47 -0400
Date: Tue, 27 Jul 2004 11:19:42 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: USB: missing rcomplete=0 in printer.c (David Woodhouse)
Message-Id: <20040727111942.38193702@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys: CUPS refuses to work with HP 1200, kernel produces silly messages.

I do not remember if David Woodhouse actually wrote it, but he certainly
reported the problem.

-- Pete

--- linux-2.4.27-rc3/drivers/usb/printer.c	2004-07-25 23:00:17.000000000 -0700
+++ linux-2.4.27-rc3-usbx/drivers/usb/printer.c	2004-07-27 10:28:53.000000000 -0700
@@ -747,6 +757,7 @@ static ssize_t usblp_read(struct file *f
 			usblp->minor, usblp->readurb->status);
 		usblp->readurb->dev = usblp->dev;
  		usblp->readcount = 0;
+		usblp->rcomplete = 0;
 		if (usb_submit_urb(usblp->readurb) < 0)
 			dbg("error submitting urb");
 		count = -EIO;
