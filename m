Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755811AbWKQSsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbWKQSsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbWKQSsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:48:38 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:56913 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755811AbWKQSsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:48:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=OroZWC1TCfdfy+JRgAewl+XABKuH0/S3CNFDIN2ceJu+2vvAB3ILLrDp0+sErdImisDo8wXI3IHviwUeXil3EBNP/5UHNLkQ6DCnBsjHhBbxcNN/W9DSuKl/mUO7dEtzF0Xs2cDTwc7hIcc69GQ4P8RvyWq3jjIto/Q0vHhE5io=  ;
X-YMail-OSG: 8gx8GNIVM1njYfdshxdV3Sit2dYY1iF7gVdnJ7pSD2p0aE1JgBkN_z6zMDozhDHFhQ.ciVKybdis8BBauaVfOz7L8iWK3mIqU_EljTOg1yMCbte1051lAg--
From: David Brownell <david-b@pacbell.net>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.19-rc6] platform_driver_probe(), can save codespace
Date: Fri, 17 Nov 2006 10:48:32 -0800
User-Agent: KMail/1.7.1
Cc: "Greg KH" <greg@kroah.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <200611162328.47987.david-b@pacbell.net> <d120d5000611170632v5ab837a6u6df9fe054988e15@mail.gmail.com>
In-Reply-To: <d120d5000611170632v5ab837a6u6df9fe054988e15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171048.33086.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 6:32 am, Dmitry Torokhov wrote:
> On 11/17/06, David Brownell <david-b@pacbell.net> wrote:
> > +
> > +       /* Fixup that section violation, being paranoid about code scanning
> > +        * the list of drivers in order to probe new devices.  Check to see
> > +        * if the probe was successful, and make sure any forced probes of
> > +        * new devices fail.
> > +        */
> > +       spin_lock(&platform_bus_type.klist_drivers.k_lock);
> > +       drv->probe = NULL;
> > +       if (code == 0 && list_empty(&drv->driver.klist_devices.k_list))
> > +               retval = -ENODEV;
> > +       drv->driver.probe = platform_drv_probe_fail;
> > +       spin_unlock(&platform_bus_type.klist_drivers.k_lock);
> 
> I think this code should not be executed if driver is compiled as a
> module because __init sections will stay anyway.

Huh??  No they won't.  Are you thinking "__devinit" with CONFIG_HOTPLUG?
(Remember, this routine is not for use with hotpluggable devices.)


>	 Also, why don't you 
> also remove "bind" attribute if driver is built-in. That should save a
> bit of dynamic memory.

That would be an additional nuance.  Feel free to submit another patch
on top of this one ... :)

- Dave


> -- 
> Dmitry
> 
