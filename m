Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937431AbWLEKt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937431AbWLEKt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937515AbWLEKt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:49:56 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:51124 "EHLO
	myri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937431AbWLEKtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:49:55 -0500
Message-ID: <45754EB2.5030203@myri.com>
Date: Tue, 05 Dec 2006 11:49:22 +0100
From: Brice Goglin <brice@myri.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: David Rientjes <rientjes@cs.washington.edu>
CC: Martin Mares <mj@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci quirks: remove redundant check
References: <Pine.LNX.4.64N.0612031153370.18549@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0612031153370.18549@attu4.cs.washington.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> Removes redundant check for dev->subordinate; if it is NULL, the function 
> returns before the patch-affected code region.
>   

ACK, looks like I forgot to remove it when copy-pasting the quirk right
above it.

Brice



> Cc: Martin Mares <mj@ucw.cz>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
> ---
>  drivers/pci/quirks.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 9ca9b9b..7571863 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1688,8 +1688,7 @@ static void __devinit quirk_nvidia_ck804
>  	 * a single one having MSI is enough to be sure that MSI are supported.
>  	 */
>  	pdev = pci_get_slot(dev->bus, 0);
> -	if (dev->subordinate && !msi_ht_cap_enabled(dev)
> -	    && !msi_ht_cap_enabled(pdev)) {
> +	if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
>  		printk(KERN_WARNING "PCI: MSI quirk detected. "
>  		       "MSI disabled on chipset %s.\n",
>  		       pci_name(dev));
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

