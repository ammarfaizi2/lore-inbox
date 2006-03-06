Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752436AbWCFVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbWCFVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbWCFVT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:19:58 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31919 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751630AbWCFVT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:19:57 -0500
Date: Mon, 6 Mar 2006 22:17:45 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306211745.GD15728@electric-eye.fr.zoreil.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306191706.GA6947@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> There's another interrupt related bug in the driver, though.  I
> sometimes get a kernel panic when rsycing several 100 megs of data
> across the LAN.  A picture showing the call trace can be found at
> http://www.cyrius.com/tmp/de2104x_panic.jpg

Not sure about this one, but...

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index d7fb3ff..49235e2 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1455,6 +1455,8 @@ static void de_tx_timeout (struct net_de
 	synchronize_irq(dev->irq);
 	de_clean_rings(de);
 
+	de_init_rings(de);
+
 	de_init_hw(de);
 	
 	netif_wake_queue(dev);

