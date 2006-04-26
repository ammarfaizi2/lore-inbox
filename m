Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWDZSgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWDZSgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDZSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:36:14 -0400
Received: from xenotime.net ([66.160.160.81]:11712 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964806AbWDZSgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:36:13 -0400
Date: Wed, 26 Apr 2006 11:38:35 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mgross@linux.intel.com
Cc: mark.gross@intel.com, minyard@acm.org, alan@lxorguk.ukuu.org.uk,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       steven.carbonari@intel.com, soo.keong.ong@intel.com,
       zhenyu.z.wang@intel.com
Subject: Re: Problems with EDAC coexisting with BIOS
Message-Id: <20060426113835.e3a05749.rdunlap@xenotime.net>
In-Reply-To: <20060426182638.GA28792@linux.intel.com>
References: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
	<20060425193405.0ee50691.rdunlap@xenotime.net>
	<20060426182638.GA28792@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 11:26:38 -0700 mark gross wrote:

> Signed-off-by: Mark Gross <mark.gross@intel.com>
> 
> 
> Trying mutt.

Yes, much better.  Almost there.


> diff -urN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/drivers/edac/e752x_edac.c linux-2.6.16_edac/drivers/edac/e752x_edac.c
> --- linux-2.6.16/drivers/edac/e752x_edac.c	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.16_edac/drivers/edac/e752x_edac.c	2006-04-26 08:36:25.000000000 -0700
> @@ -755,8 +756,16 @@
>  	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
>  	debugf0("Starting Probe1\n");
>  
> -	/* enable device 0 function 1 */
> +	/* check to see if device 0 function 1 is enbaled; if it isn't, we

"enabled"

> +	 * assume the BIOS has reserved it for a reason and is expecting
> +	 * exclusive access, we take care not to violate that assumption and
> +	 * fail the probe. */
>  	pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
> +	if (!force_function_unhide && !(stat8 & (1 << 5))) {
> +		printk(KERN_INFO "Contact your BIOS vendor to see if the "
> +			"E752x error registers can be safely un-hidden\n");
> +			goto fail;

The goto is indented too much...

> +	}

Thanks.
---
~Randy
