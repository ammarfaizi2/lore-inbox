Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUI0XK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUI0XK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUI0XK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:10:58 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:15689 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267438AbUI0XJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:09:06 -0400
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Paul Fulghum <paulkf@microgate.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1096326028l.5222l.0l@werewolf.able.es>
References: <1096313095.2601.20.camel@deimos.microgate.com>
	 <1096326028l.5222l.0l@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1096326541.5963.2.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Sep 2004 18:09:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 18:00, J.A. Magallon wrote:
> Just a 'me-too', with a slightly different oops:

Can you try the following patch please?

-- 
Paul Fulghum
paulkf@microgate.com


--- a/drivers/net/e100.c        2004-09-27 09:57:35.000000000 -0500
+++ b/drivers/net/e100.c        2004-09-27 16:00:12.115482112 -0500
@@ -1675,9 +1675,6 @@
 
        if((err = e100_rx_alloc_list(nic)))
                return err;
-
-       disable_irq(nic->pdev->irq);
-
        if((err = e100_alloc_cbs(nic)))
                goto err_rx_clean_list;
        if((err = e100_hw_init(nic)))
@@ -1689,7 +1686,6 @@
                nic->netdev->name, nic->netdev)))
                goto err_no_irq;
        e100_enable_irq(nic);
-       enable_irq(nic->pdev->irq);
        netif_wake_queue(nic->netdev);
        return 0;
 
@@ -1700,7 +1696,6 @@
 err_rx_clean_list:
        e100_rx_clean_list(nic);
 
-       enable_irq(nic->pdev->irq);
        return err;
 }
 

