Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270947AbUJVKKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270947AbUJVKKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270952AbUJVKKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:10:35 -0400
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:45761
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S270947AbUJVKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:10:24 -0400
Date: Fri, 22 Oct 2004 11:10:18 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] platform_get_irq() return for no IRQ
Message-ID: <20041022101018.GA17957@home.fluff.org>
References: <20041020174015.GA13087@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020174015.GA13087@fluff.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 06:40:15PM +0100, Ben Dooks wrote:
> in drivers/base/platform.c, platform_get_irq() returns 0 if
> there is no IRQ found in the resources, however 0 is a valid
> IRQ on at least some of the ARM architectures.
> 
> This patch changes the return code to be -ENOENT instead.
> 
> Signed-of-by: Ben Dooks <ben-linux@fluff.org>
> 

I should have also pointed out that as few things are
actually using this at the moment, it would be a good
idea to get this changed as soon as possible.

> --- linux-2.6.9-bk4-orig/drivers/base/platform.c	2004-10-20 15:50:29.000000000 +0100
> +++ linux-2.6.9-bk4/drivers/base/platform.c	2004-10-20 18:37:12.000000000 +0100
> @@ -54,7 +54,7 @@
>  {
>  	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>  
> -	return r ? r->start : 0;
> +	return r ? r->start : -ENOENT;
>  }
>  
>  /**


-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
