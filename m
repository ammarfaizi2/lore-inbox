Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVIAUBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVIAUBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIAUBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:01:06 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:56071 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030340AbVIAUBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:01:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g4JWOzhgqrQLnmvSqJUTVSCRuayceK7Wwg8xzdc1oJ1Mxp4vno1OJzTWJCiApB8XzPZmaM7bVLz5GkAqvvO5+9He+7iCtUDz5wPKgOcCXsPUYZ5h5hGjdfJhkpXFEMP+ExYvD1LmvbWIVjRflK3mxSbSc1WDkBKqlOC9qJ/hxEg=
Date: Fri, 2 Sep 2005 00:10:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] Unhandled error condition in aic79xx
Message-ID: <20050901201029.GA10893@mipter.zuzino.mipt.ru>
References: <1125603501.4867.21.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125603501.4867.21.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 12:38:21PM -0700, Daniel Walker wrote:
> This patch should handle the case when scsi_add_host() fails.

> --- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic79xx_osm.c
> +++ linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c

> @@ -2065,7 +2066,11 @@ ahd_linux_register_host(struct ahd_softc
>  	ahd_unlock(ahd, &s);
>  
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
> -	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
> +	error = scsi_add_host(host, &ahd->dev_softc->dev); 
> +	if (error) {
> +		scsi_host_put(host);
> +		return(error);
> +	}
>  	scsi_scan_host(host);
>  #endif
>  	return (0);

I see malloc(), kernel_thread() and multiple ahd_linux_alloc_target()
above. Ditto for 7xxx patch.

