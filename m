Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTIAQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIAQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:59:42 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:27617 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S263147AbTIAQ7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:59:34 -0400
Subject: Re: [PATCH] Firmware loading depends on hotplug support
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030901163505.GA27754@ip68-0-152-218.tc.ph.cox.net>
References: <200309011502.h81F2Mq6003467@hera.kernel.org> 
	<20030901163505.GA27754@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2003 18:59:15 +0200
Message-Id: <1062435561.30892.193.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

> > 	[PATCH] Firmware loading depends on hotplug support
> > 	
> > 	This patch makes the firmware loading support only selectable if the
> > 	hotplug support is also enabled.
> > 
> > 
> > # This patch includes the following deltas:
> > #	           ChangeSet	1.1065.2.2 -> 1.1065.2.3
> > #	       lib/Config.in	1.4     -> 1.5    
> > #
> > 
> >  Config.in |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > 
> > diff -Nru a/lib/Config.in b/lib/Config.in
> > --- a/lib/Config.in	Mon Sep  1 08:02:24 2003
> > +++ b/lib/Config.in	Mon Sep  1 08:02:24 2003
> > @@ -41,7 +41,8 @@
> >    fi
> >  fi
> >  
> > -if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
> > +if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
> > +     "$CONFIG_HOTPLUG" = "y" ]; then
> >     tristate 'Hotplug firmware loading support (EXPERIMENTAL)' CONFIG_FW_LOADER
> >  fi
> 
> Is this really a good idea, given that USB devices may be hot-plugged,
> without CONFIG_HOTPLUG set (drivers are compiled in, for example) ?

this option is only provided for drivers outside the kernel. If a driver
inside the kernel needs it, it is selected automaticly like the CRC32
routines.

If you disable hotplug support the request_firmware() routine will
return an error and this must be handled by the driver.

Regards

Marcel


