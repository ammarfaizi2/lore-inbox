Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVHPWeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVHPWeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVHPWeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:34:14 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:5041 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbVHPWeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:34:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y21i6oQspyjSflz8hcGugK3G9tbyTIdjWLQnQ3X5ydk+4qSVzUaqXGlIRcyHU1neuLFLgV2x4xwAUC+Tvyz+XL2tmbbca2fSMGYQLAgHpalQVAS1/IB1q4ynbMEu8OK3Ff+cKuqqtCcTpHPZ80Q2LRqERGfYw/+7YPAO6akS1Bk=
Message-ID: <d120d5000508161534451ebd7a@mail.gmail.com>
Date: Tue, 16 Aug 2005 17:34:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
Cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0508151654210.19345-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d50005081113294dbb4961@mail.gmail.com>
	 <Pine.LNX.4.44L0.0508151654210.19345-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Alan Stern <stern@rowland.harvard.edu> wrote:

> On the face of it, neither is particularly more attractive than the other.
> However, reading through the various places that call these routines (for
> example, drivers/input/serio/serio.c or drivers/pnp/card.c) revealed a
> pattern.  In most cases, the callers of device_bind_driver _really_ want
> something that functions more like driver_probe_device but without the
> matching step.  The callers are invoking the probe methods by hand rather
> than relying on the driver core to do so.  There's maybe only one place
> where a caller actually does want the device bound to the driver without
> doing a probe.
> 

Alan,

I am sorry I don't have time to properly review the patch at
themoment, just a couple of comments about serio - I would not look at
serio for examples of typical use as it was trying very hard to work
around the original driver model limitation that prevented drivers to
register childern on the same bus from their probe function. I think
now that that limitation is lifted serio implemenation can be
simplified.

-- 
Dmitry
