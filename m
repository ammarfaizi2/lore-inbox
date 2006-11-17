Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755800AbWKQTLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbWKQTLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755801AbWKQTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:11:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:57789 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755781AbWKQTLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:11:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=euMQySoc4pAVE2dPxPRBdaKXrg9mR6qOpIEJp2OYybstMKsJG3jFBCPubsZVDjysjoplxABELJ076ENlgjZWgL/Pb6/aIeWv17bHjA2/SESS3R31GmIPBhvIYNCwqOyBHYzJSwXlKD8thRgLg1OM95HztXxqE/JS/xHewkw1mGE=
Message-ID: <d120d5000611171111g51f624a6mb9ad694005f690a8@mail.gmail.com>
Date: Fri, 17 Nov 2006 14:11:19 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.19-rc6] platform_driver_probe(), can save codespace
Cc: "Greg KH" <greg@kroah.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200611171048.33086.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611162328.47987.david-b@pacbell.net>
	 <d120d5000611170632v5ab837a6u6df9fe054988e15@mail.gmail.com>
	 <200611171048.33086.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/06, David Brownell <david-b@pacbell.net> wrote:
> On Friday 17 November 2006 6:32 am, Dmitry Torokhov wrote:
> > On 11/17/06, David Brownell <david-b@pacbell.net> wrote:
> > > +
> > > +       /* Fixup that section violation, being paranoid about code scanning
> > > +        * the list of drivers in order to probe new devices.  Check to see
> > > +        * if the probe was successful, and make sure any forced probes of
> > > +        * new devices fail.
> > > +        */
> > > +       spin_lock(&platform_bus_type.klist_drivers.k_lock);
> > > +       drv->probe = NULL;
> > > +       if (code == 0 && list_empty(&drv->driver.klist_devices.k_list))
> > > +               retval = -ENODEV;
> > > +       drv->driver.probe = platform_drv_probe_fail;
> > > +       spin_unlock(&platform_bus_type.klist_drivers.k_lock);
> >
> > I think this code should not be executed if driver is compiled as a
> > module because __init sections will stay anyway.
>
> Huh??  No they won't.  Are you thinking "__devinit" with CONFIG_HOTPLUG?
> (Remember, this routine is not for use with hotpluggable devices.)
>

Do we discard __init sections in modules nowadays? I thought we did
that only for the kernel image itself.

-- 
Dmitry
