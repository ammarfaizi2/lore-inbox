Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVFTSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVFTSdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFTSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:33:49 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:28943 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261430AbVFTSdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:33:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JHDAHb0UOkecIdltUFDWH61kLBqO0YJoJVLgJt3LYWpAxaKOrEERSiC84mOzglYcLL4tcrVs782ZdF4fl3GkKObux0q4NXYA2S85eaZ7bT5unX5vYApI8vTmVjgmYwcc8eRaSMIvAQqiby+p30v6cmHUIE1vA/EVJoAwl9hRanQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Olav Kongas <ok@artecdesign.ee>
Subject: gregkh-usb-usb-isp116x-hcd-add.patch (was 2.6.12-mm1)
Date: Mon, 20 Jun 2005 22:39:24 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202239.24248.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch provides an "isp116x-hcd" driver for Philips'
> ISP1160/ISP1161 USB host controllers.

--- /dev/null
+++ gregkh-2.6/drivers/usb/host/isp116x-hcd.c

> + *The driver passes all usbtests 1-14.

Missing space.

> +static void preproc_atl_queue(struct isp116x *isp116x)
> +{

> +			/* To please gcc */
> +			toggle = dir = 0;

Oh, just ignore bogus warnings. It's easy. ;-)

> +			ERR("%s %d: ep->nextpid %d\n", __func__, __LINE__,
> +			    ep->nextpid);
> +			BUG_ON(1);

Simply BUG().

> +static int isp116x_urb_enqueue(struct usb_hcd *hcd,
> +			       struct usb_host_endpoint *hep, struct urb *urb,
> +			       int mem_flags)
> +{

> +	if (!hep->hcpriv) {
> +		ep = kcalloc(1, sizeof *ep, (__force unsigned)mem_flags);

Please, drop this cast. The right thing is to change ->urb_enqueue method to
accept unsigned int mem_flags.

> +		if (!ep)
> +			return -ENOMEM;
> +	}

> +static int isp116x_hub_control(struct usb_hcd *hcd,
> +			       u16 typeReq,
> +			       u16 wValue, u16 wIndex, char *buf, u16 wLength)
> +{

> +	case GetHubStatus:
> +		DBG("GetHubStatus\n");
> +		*(__le32 *) buf = cpu_to_le32(0);
				  ^^^^^^^^^^^
Not needed. Zero is zero.

> +static int isp116x_suspend(struct device *dev, pm_message_t state, u32 phase)
> +{

> +		INFO("%s suspended\n", (char *)hcd_name);
> +	} else
> +		ERR("%s suspend failed\n", (char *)hcd_name);

Useless casts.
