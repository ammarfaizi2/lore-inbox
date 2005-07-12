Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVGLOPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVGLOPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVGLONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:13:37 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:2830 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261544AbVGLONV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:13:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=og6jjDCIwSUxO9yGrz2irHThQTj2sZ63s0i5W8PbW04M6zz2OAjs6Rbh8x5fdpCeYsJR4gPKI38zy0OE/HGwfkFi4Ehe0RShGjRGr6tl/zJj1LoDLoWfWE1FKYRGYT4oSwS/B3SR34Q8Y1QpbQcpD+ZabpkAKtSrqUSLJyPMY7Y=
Message-ID: <d120d5000507120713646089ee@mail.gmail.com>
Date: Tue, 12 Jul 2005 09:13:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <1121159126.4656.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050708101731.GM18608@sd291.sivit.org>
	 <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
	 <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
	 <1121080115.12627.44.camel@localhost.localdomain>
	 <20050711112121.GA24345@ucw.cz>
	 <1121159126.4656.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
>
> +       dev->input.id.bustype = BUS_USB;
> +       dev->input.id.vendor = id->idVendor;
> +       dev->input.id.product = id->idProduct;
> +       dev->input.id.version = ATP_DRIVER_VERSION;
> +

Why don't we do what most of the other input devices and get version
from the device too? Actually we have this in input tree:

static inline void
usb_to_input_id(const struct usb_device *dev, struct input_id *id)
{
        id->bustype = BUS_USB;
        id->vendor = le16_to_cpu(dev->descriptor.idVendor);
        id->product = le16_to_cpu(dev->descriptor.idProduct);
        id->version = le16_to_cpu(dev->descriptor.bcdDevice);
}

-- 
Dmitry
