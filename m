Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759651AbWLCNGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759651AbWLCNGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759656AbWLCNGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:06:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:18229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759650AbWLCNGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:06:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ObVUPXFvNTYf5Om6XXQDNTL+ZuLlpvf1ZZvC0I8N1OfJY25dfdn7Kqie8GPGxO13Mcm3Zbm3v2HL7chE8OBzo+7OttZACA4cMK6IyzrFjHpoFJ8fBrqazDvBgsh8RB09NhWxjY6tmSGw+SY66+MhnOODZiRg93QG90piwLlPMbA=
Message-ID: <4572CBAF.1010800@gmail.com>
Date: Sun, 03 Dec 2006 22:05:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 3/3] sata_promise: cleanups
References: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
In-Reply-To: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.

Ack.

> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init().

Please explain why.

> @@ -704,7 +684,7 @@ static void pdc_host_init(unsigned int c
>  {
>  	void __iomem *mmio = pe->mmio_base;
>  	struct pdc_host_priv *hp = pe->private_data;
> -	int hotplug_offset = hp->hotplug_offset;
> +	int hotplug_offset = (hp->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR : PDC_SATA_PLUG_CSR;

People tend to prefer explicit if () over ?: and dislike lines much
longer than 80 column, well, at least in libata.

Thanks.

-- 
tejun
