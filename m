Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWGYTOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWGYTOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWGYTOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:14:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29078 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964840AbWGYTOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:14:09 -0400
Subject: Re: [patch] [resend] Fix swsusp with PNP BIOS
From: Adam Belay <abelay@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>,
       Ondrej Zary <linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200607250923.18678.ncunningham@linuxmail.org>
References: <200607242028.01666.linux@rainbow-software.org>
	 <200607242325.50229.rjw@sisk.pl>
	 <200607250923.18678.ncunningham@linuxmail.org>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 15:17:35 -0400
Message-Id: <1153855056.6508.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 09:23 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 25 July 2006 07:25, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Monday 24 July 2006 20:28, Ondrej Zary wrote:
> > > Hello,
> > > swsusp is unable to suspend my machine (DTK FortisPro TOP-5A notebook)
> > > with kernel 2.6.17.5 because it's unable to suspend PNP device 00:16
> > > (mouse).
> > >
> > > The problem is in PNP BIOS. pnp_bus_suspend() calls pnp_stop_dev() for
> > > the device if the device can be disabled according to pnp_can_disable().
> > > The problem is that pnpbios_disable_resources() returns -EPERM if the
> > > device is not dynamic (!pnpbios_is_dynamic()) but insert_device() happily
> > > sets PNP_DISABLE capability/flag even if the device is not dynamic. So we
> > > try to disable non-dynamic devices which will fail.
> > > This patch prevents insert_device() from setting PNP_DISABLE if the
> > > device is not dynamic and fixes suspend on my system.
> >
> > Thanks for the patch.
> >
> > Pavel, what do you think?
> 
> Adam is probably a better person to ask. (Added to cc).

I appreciate it.

> 
> Regards,
> 
> Nigel

The patch looks good.  Maybe we should even do this check for
PNP_CONFIGURABLE.

Thanks,
Adam


