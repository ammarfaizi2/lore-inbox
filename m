Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVIATVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVIATVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVIATVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:21:13 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:62990 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965148AbVIATVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:21:12 -0400
Message-ID: <431755E4.70703@gentoo.org>
Date: Thu, 01 Sep 2005 20:26:28 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
Cc: Alex Williamson <alex.williamson@hp.com>, Andreas Schwab <schwab@suse.de>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
References: <jehdda2tqt.fsf@sykes.suse.de>	 <1125288175.5595.3.camel@localhost.localdomain> <1125311951.4662.3.camel@localhost.localdomain>
In-Reply-To: <1125311951.4662.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stelian Pop wrote:
> Confirmed on an Apple Powerbook too.
> 
> For reference, the (already reverted) patch which needs to be applied is
> below.
> 
> Signed-off-by: Stelian Pop <stelian@popies.net>
> 
> Index: linux-2.6.git/drivers/pci/setup-res.c
> ===================================================================
> --- linux-2.6.git.orig/drivers/pci/setup-res.c	2005-08-29 10:03:00.000000000 +0200
> +++ linux-2.6.git/drivers/pci/setup-res.c	2005-08-29 12:23:20.980716336 +0200
> @@ -53,9 +53,7 @@
>  	if (resno < 6) {
>  		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
>  	} else if (resno == PCI_ROM_RESOURCE) {
> -		if (!(res->flags & IORESOURCE_ROM_ENABLE))
> -			return;
> -		new |= PCI_ROM_ADDRESS_ENABLE;
> +		new |= res->flags & IORESOURCE_ROM_ENABLE;
>  		reg = dev->rom_base_reg;
>  	} else {
>  		/* Hmm, non-standard resource. */
> 

Sorry for my ignorance. Which tree was this reverted in? You are probably 
aware that this bug made it into 2.6.13 (patch was not reverted there).

Daniel
