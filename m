Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbVLOFTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbVLOFTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbVLOFTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:19:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:30891 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161100AbVLOFTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:19:38 -0500
Subject: Re: [BUG] Xserver startup locks system... git bisect results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1134623242.16880.30.camel@gaston>
References: <20051215043212.GA4479@jupiter.solarsys.private>
	 <1134622384.16880.26.camel@gaston>  <1134623242.16880.30.camel@gaston>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 16:15:47 +1100
Message-Id: <1134623748.16880.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 16:07 +1100, Benjamin Herrenschmidt wrote:
> Ah, also, something else you can try, is replace
> 
> 	dev_priv->gart_vm_start = dev_priv->fb_location
> 	    + RADEON_READ(RADEON_CONFIG_APER_SIZE);

Actually, the above should read

	    + RADEON_READ(RADEON_CONFIG_APER_SIZE) * 2;

With the patch that is causing your problem...

> with
> 
> #define RADEON_CONFIG_MEMSIZE                         0x00F8  
> 	dev_priv->gart_vm_start = dev_priv->fb_location
> 	    + RADEON_READ(RADEON_CONFIG_MEMSIZE);
> 
> And tell us if it helps ?
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

