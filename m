Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbULFAtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbULFAtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbULFArv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:47:51 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:63929 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261445AbULFAqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:46:52 -0500
Message-ID: <41B3ABFE.5090105@free.fr>
Date: Mon, 06 Dec 2004 01:46:54 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Adam Belay <ambx1@neo.rr.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
References: <41B3A963.4090003@keyaccess.nl>
In-Reply-To: <41B3A963.4090003@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Hi Adam.
> 
> Between 2.6.8 and 2.6.9, the following patch to rsparser.c was merged:
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@414703f7MEe33PTYY-aFQaM3CLKjZw?nav=index.html|src/|src/drivers|src/drivers/pnp|src/drivers/pnp/pnpbios|related/drivers/pnp/pnpbios/rsparser.c 
> 
> 
> The added warning triggers on my machine:
> 
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f7740
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6634, dseg 0xf0000
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
> 
> I don't believe those warnings should be printed, what with "broken" the 
> expected state of anything coming from the BIOS. The attached patch 
> removes them again. Works for me...
> 
> Rene.
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.10-rc3.orig/drivers/pnp/pnpbios/rsparser.c	2004-12-04 03:10:03.000000000 +0100
> +++ linux-2.6.10-rc3/drivers/pnp/pnpbios/rsparser.c	2004-12-06 01:12:50.000000000 +0100
> @@ -433,14 +433,10 @@
>  		case SMALL_TAG_ENDDEP:
>  			if (len != 0)
>  				goto len_err;
> -			if (option_independent == option)
> -				printk(KERN_WARNING "PnPBIOS: Missing SMALL_TAG_STARTDEP tag\n");
this one shouldn't be removed
>  			option = option_independent;
>  			break;
>  
>  		case SMALL_TAG_END:
> -			if (option_independent != option)
> -				printk(KERN_WARNING "PnPBIOS: Missing SMALL_TAG_ENDDEP tag\n");
ok for this one, may be change it to pnp_dbg(...)
>  			p = p + 2;
>          		return (unsigned char *)p;
>  			break;

Matthieu
