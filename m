Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWC3DMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWC3DMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWC3DMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:12:05 -0500
Received: from wproxy.gmail.com ([64.233.184.230]:52560 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751229AbWC3DME convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:12:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IP/LHd04ITNLQ9mwfW1+owTFOLE4NQYCPAMJgwTgXpcBZdfB/OYF0LNRmuVmZZWKsXXQvifr+a2jMxuJT94YGrneW6O17zHmc3kpwhKZXxg9Paw2qPanZKeL/6WME5wL5HDGWZwpIXq7WRVSXf0JGozJ38FJU0MUp6IGjPHsC8Y=
Message-ID: <c5e68b660603291912o3d5ae0d9s8b9a99ab18d090da@mail.gmail.com>
Date: Thu, 30 Mar 2006 05:12:03 +0200
From: "=?ISO-8859-1?Q?Ole_Andr=E9_Vadla_Ravn=E5s?=" <oleavr@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.16] rndis_host/cdc_ether: add support for Windows Mobile 5 based devices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060329154138.033eee05.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <c5e68b660603290342k2d46605bv5eeb4b341585e805@mail.gmail.com>
	 <20060329154138.033eee05.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Andrew Morton <akpm@osdl.org> wrote:
> "Ole André Vadla Ravnås" <oleavr@gmail.com> wrote:
> >
> > +             /* allocate and fill in the missing structures */
> > +             h = kmalloc(sizeof(struct usb_cdc_header_desc), GFP_KERNEL);
> > +             if (!h)
> > +                     return -ENOMEM;
> > +             info->header = h;
> > +
> > +             h->bLength = sizeof(struct usb_cdc_header_desc);
> > +             h->bDescriptorType = USB_DT_CS_INTERFACE;
> > +             h->bDescriptorSubType = USB_CDC_HEADER_TYPE;
> > +
> > +             h->bcdCDC = 0; /* FIXME */
> > +
> > +             u = kmalloc(sizeof(struct usb_cdc_union_desc), GFP_KERNEL);
> > +             if (!u)
> > +                     return -ENOMEM;
> > +             info->u = u;
>
> If the second kmalloc() fails, do we leak the memory at `h'?
>
> Please don't sprinkle `return' statements deep inside large and complex
> functions.  It makes the code hard to audit and to modify and it invites
> resource leaks and locking errors.  Instead, use `goto suitable_unwind_point;', thanks.

Ahh, very good point there! Thanks for pointing it out!  I'll fix it,
wait for a comment from David, and then resubmit.

Cheers,
Ole Andre
