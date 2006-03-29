Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWC2Xj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWC2Xj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWC2Xj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751282AbWC2Xj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:39:27 -0500
Date: Wed, 29 Mar 2006 15:41:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s" ?= 
	<oleavr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16] rndis_host/cdc_ether: add support for Windows
 Mobile 5 based devices
Message-Id: <20060329154138.033eee05.akpm@osdl.org>
In-Reply-To: <c5e68b660603290342k2d46605bv5eeb4b341585e805@mail.gmail.com>
References: <c5e68b660603290342k2d46605bv5eeb4b341585e805@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ole André Vadla Ravnås" <oleavr@gmail.com> wrote:
>
> +		/* allocate and fill in the missing structures */
> +		h = kmalloc(sizeof(struct usb_cdc_header_desc), GFP_KERNEL);
> +		if (!h)
> +			return -ENOMEM;
> +		info->header = h;
> +
> +		h->bLength = sizeof(struct usb_cdc_header_desc);
> +		h->bDescriptorType = USB_DT_CS_INTERFACE;
> +		h->bDescriptorSubType = USB_CDC_HEADER_TYPE;
> +
> +		h->bcdCDC = 0; /* FIXME */
> +		
> +		u = kmalloc(sizeof(struct usb_cdc_union_desc), GFP_KERNEL);
> +		if (!u)
> +			return -ENOMEM;
> +		info->u = u;

If the second kmalloc() fails, do we leak the memory at `h'?

Please don't sprinkle `return' statements deep inside large and complex
functions.  It makes the code hard to audit and to modify and it invites
resource leaks and locking errors.  Instead, use `goto suitable_unwind_point;', thanks.


