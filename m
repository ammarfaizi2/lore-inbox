Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUICH6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUICH6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbUICH6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:58:43 -0400
Received: from mail1.kontent.de ([81.88.34.36]:14054 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269360AbUICH6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:58:18 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Robert Schwebel <robert@schwebel.de>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Date: Fri, 3 Sep 2004 10:00:04 +0200
User-Agent: KMail/1.6.2
Cc: John Lenz <lenz@cs.wisc.edu>, linux-kernel@vger.kernel.org
References: <1094157190l.4235l.2l@hydra> <20040903131715.GG1369@pengutronix.de> <20040903133152.GH1369@pengutronix.de>
In-Reply-To: <20040903133152.GH1369@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409031000.04374.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. September 2004 15:31 schrieb Robert Schwebel:
> On Fri, Sep 03, 2004 at 03:17:15PM +0200, Robert Schwebel wrote:
> > I'll pull the gpio patch out of my working tree and post it here for
> > discussion. 
> 
> Attached. Parts of it have been taken from your LEDs patch anyway, so it
> should be not too difficult to reunify them. 
> 
> Robert
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+			printk(KERN_ERR "gpio pin %i is already used by %s\n",
+			       pin_nr, gpio_dev->props.owner);
+			return -EBUSY;
+		}
+	}

[..]
+	spin_lock_init(&gpio_dev->lock);
+	gpio_dev->props.pin_nr = pin_nr;

This looks like a race condition. You need to check and reserve under
a lock.

	Regards
		Oliver
