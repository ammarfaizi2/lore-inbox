Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbTBNOXB>; Fri, 14 Feb 2003 09:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTBNOXB>; Fri, 14 Feb 2003 09:23:01 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:27399 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268402AbTBNOXA>; Fri, 14 Feb 2003 09:23:00 -0500
Date: Fri, 14 Feb 2003 17:32:17 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
Message-ID: <20030214173217.A17730@jurassic.park.msu.ru>
References: <1044241767.3924.14.camel@mulgrave> <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Feb 14, 2003 at 11:16:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 11:16:24AM +0100, Marc Zyngier wrote:
> # - Add driver for i82375 PCI/EISA bridge.

I believe this driver will work for any PCI/EISA bridge without
any changes, not only for i82375. Probably we need to look for a
class code rather than a device id.

Also, to get rid of that x86-ism I'd suggest something like

	i82375_root.dev		     = &pdev->dev;
	i82375_root.dev->driver_data = &i82375_root;
-	i82375_root.bus_base_addr    = 0; /* Warning, this is a x86-ism */
-	i82375_root.res		     = &ioport_resource;
+	i82375_root.res		     = pdev->bus->resource[0];
+	i82375_root.bus_base_addr    = pdev->bus->resource[0]->start;
	i82375_root.slots	     = EISA_MAX_SLOTS;

Without that you'll have resource conflicts on multi-hose alphas.

Otherwise, the patch looks good to me.

Ivan.
