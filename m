Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbSISKgR>; Thu, 19 Sep 2002 06:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271034AbSISKgR>; Thu, 19 Sep 2002 06:36:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21516 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271018AbSISKgQ>; Thu, 19 Sep 2002 06:36:16 -0400
Date: Thu, 19 Sep 2002 11:41:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>
Cc: Stuart MacDonald <stuartm@connecttech.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.36 Oops on power-down
Message-ID: <20020919114115.B11763@flint.arm.linux.org.uk>
References: <058401c25f61$25245640$294b82ce@connecttech.com> <Pine.LNX.4.44.0209181558440.968-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209181558440.968-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Wed, Sep 18, 2002 at 04:01:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 04:01:53PM -0700, Patrick Mochel wrote:
> It appears that the 8250_pci serial driver needs a check for NULL when 
> calling the device's re-init function. Could you try the attached patch 
> and let us know if it works for you? 

The patch is correct.  Linus, please apply.

===== drivers/serial/8250_pci.c 1.8 vs edited =====
--- 1.8/drivers/serial/8250_pci.c	Mon Jul 29 07:52:41 2002
+++ edited/drivers/serial/8250_pci.c	Wed Sep 18 15:51:32 2002
@@ -771,7 +771,8 @@
 		for (i = 0; i < priv->nr; i++)
 			unregister_serial(priv->line[i]);
 
-		priv->board->init_fn(dev, priv->board, 0);
+		if (priv->board->init_fn)
+			priv->board->init_fn(dev, priv->board, 0);
 
 		pci_disable_device(dev);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

