Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVCMACR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVCMACR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCMACR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 19:02:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:9896 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262466AbVCMACI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 19:02:08 -0500
Date: Sat, 12 Mar 2005 12:36:42 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] be more verbose in gen-devlist
Message-ID: <20050312203642.GC11865@kroah.com>
References: <20050311192858.GA11077@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311192858.GA11077@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 08:28:58PM +0100, Olaf Hering wrote:
> 
> gen-devlist should print how many bytes will be cut off and pci.ids
> entry. Also print the removed '[more blah]' part.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> --- ../linux-2.6.10/drivers/pci/gen-devlist.c	2004-12-24 22:34:45.000000000 +0100
> +++ ./drivers/pci/gen-devlist.c	2005-03-11 20:10:11.542098265 +0100
> @@ -72,9 +72,19 @@ main(void)
>  						/* Too long, try cutting off long description */
>  						bra = strchr(c, '[');
>  						if (bra && bra > c && bra[-1] == ' ')
> +#if 0
> +						{
> +							fprintf(stderr, "Line %d: cut off '%s' from line:\n", lino, bra);
> +							fprintf(stderr, " '%s'\n", c);
>  							bra[-1] = 0;
> +							fprintf(stderr, " '%s'\n", c);
> +						}
> +#else
> +							bra[-1] = 0;
> +#endif

Why #if this?  Why not just always do this?

thanks,

greg k-h
