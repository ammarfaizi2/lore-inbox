Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbUK0G0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUK0G0f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUK0G0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:26:30 -0500
Received: from mail17.bluewin.ch ([195.186.18.64]:29174 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S262032AbUKZTNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:13:22 -0500
Date: Thu, 25 Nov 2004 17:16:19 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] visor: Make URB limit error more visible
Message-ID: <20041125161619.GD18567@k3.hellgate.ch>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch> <20041124232527.GB4394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124232527.GB4394@kroah.com>
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one call to dev_dbg in all of visor.c, the rest is dbg or
dev_err. It already bit us once when warnings didn't turn up in a debug
log. I would argue that a flood of those warnings will warrant report
and inspection anyway (broken app, broken driver, or lame DoS attempt),
so I replaced the dev_dbg with dev_err.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c.orig	2004-11-25 17:03:18.056410624 +0100
+++ linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c	2004-11-25 17:05:04.113287528 +0100
@@ -494,7 +494,7 @@ static int visor_write (struct usb_seria
 	spin_lock_irqsave(&priv->lock, flags);
 	if (priv->outstanding_urbs > URB_UPPER_LIMIT) {
 		spin_unlock_irqrestore(&priv->lock, flags);
-		dev_dbg(&port->dev, "write limit hit\n");
+		dev_err(&port->dev, "write limit hit\n");
 		return 0;
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
