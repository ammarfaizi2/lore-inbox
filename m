Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWCCMzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCCMzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWCCMzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 07:55:46 -0500
Received: from styx.suse.cz ([82.119.242.94]:16271 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751253AbWCCMzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 07:55:45 -0500
Date: Fri, 3 Mar 2006 13:55:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/9] ns558: adjust pnp_register_driver signature
Message-ID: <20060303125543.GC11899@suse.cz>
References: <200603021601.27467.bjorn.helgaas@hp.com> <200603021609.37525.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021609.37525.bjorn.helgaas@hp.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 04:09:37PM -0700, Bjorn Helgaas wrote:
> Remove the assumption that pnp_register_driver() returns the number of
> devices claimed.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Wouldn't a diff like

--- a/drivers/input/gameport/ns558.c	2006-03-02 12:40:45.000000000 -0700
+++ b/drivers/input/gameport/ns558.c	2006-03-02 12:43:58.000000000 -0700
@@ -258,7 +256,7 @@
 {
 	int i = 0;
 
-	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
+	if (!pnp_register_driver(&ns558_pnp_driver))
 		pnp_registered = 1;
  
  /*

be enough? The err variable isn't used anywhere else.

> Index: work-mm4/drivers/input/gameport/ns558.c
> ===================================================================
> --- work-mm4.orig/drivers/input/gameport/ns558.c	2006-03-02 12:40:45.000000000 -0700
> +++ work-mm4/drivers/input/gameport/ns558.c	2006-03-02 12:43:58.000000000 -0700
> @@ -256,9 +256,10 @@
>  
>  static int __init ns558_init(void)
>  {
> -	int i = 0;
> +	int i = 0, err;
>  
> -	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
> +	err = pnp_register_driver(&ns558_pnp_driver);
> +	if (!err)
>  		pnp_registered = 1;
>  
>  /*
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs
