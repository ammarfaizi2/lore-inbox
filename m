Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265726AbUFOQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUFOQQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUFOQQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:16:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:55694 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265726AbUFOQQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:16:50 -0400
Date: Tue, 15 Jun 2004 20:16:48 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: William Lee Irwin III <wli@holomorphy.com>,
       Patrick Finnegan <pat@computer-refuge.org>,
       linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Message-ID: <20040615201648.A28597@jurassic.park.msu.ru>
References: <200406151100.25284.pat@computer-refuge.org> <20040615160709.GY1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040615160709.GY1444@holomorphy.com>; from wli@holomorphy.com on Tue, Jun 15, 2004 at 09:07:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:07:09AM -0700, William Lee Irwin III wrote:
> Could you try to locate it with scripts/reference_discard.pl, and if that
> fail, post your .config (preferably compressed) so I can try to debug this
> on my alphas?

This is known problem - missing __devexit_p() wrapper in serial PnP
driver.

Ivan.

--- 2.6/drivers/serial/8250_pnp.c	Mon May 10 06:31:59 2004
+++ linux/drivers/serial/8250_pnp.c	Mon May 10 22:47:45 2004
@@ -437,7 +437,7 @@ static struct pnp_driver serial_pnp_driv
 	.name		= "serial",
 	.id_table	= pnp_dev_table,
 	.probe		= serial_pnp_probe,
-	.remove		= serial_pnp_remove,
+	.remove		= __devexit_p(serial_pnp_remove),
 };
 
 static int __init serial8250_pnp_init(void)
