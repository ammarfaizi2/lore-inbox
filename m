Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTHXR5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbTHXR5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 13:57:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7175 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S261276AbTHXR5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 13:57:42 -0400
Date: Sun, 24 Aug 2003 19:53:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [AMD76X]
Message-ID: <20030824175321.GF734@alpha.home.local>
References: <20030823233323.GA7989@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823233323.GA7989@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 09:33:23AM +1000, Herbert Xu wrote:
> Hi:
> 
> amd76x_pm.c will crash if no chipsets are found and CONFIG_HOTPLUG is
> turned on.  This patch makes it return with a failure instead.

Hi !

I'm wondering whether this patch should be needed too.

Cheers,
Willy

--- linux-2.4.22-rc3/drivers/char/amd76x_pm.c.orig	Sun Aug 24 19:52:42 2003
+++ linux-2.4.22-rc3/drivers/char/amd76x_pm.c	Sun Aug 24 19:53:49 2003
@@ -620,6 +620,8 @@
 #ifndef AMD76X_NTH
 	if (!amd76x_pm_cfg.curr_idle) {
 		printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
+		pci_unregister_driver(&amd_nb_driver);
+		pci_unregister_driver(&amd_sb_driver);
 		return 1;
 	}
 
