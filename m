Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268443AbTBNPYf>; Fri, 14 Feb 2003 10:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268447AbTBNPYf>; Fri, 14 Feb 2003 10:24:35 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:26332 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S268443AbTBNPYe>; Fri, 14 Feb 2003 10:24:34 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
References: <1044241767.3924.14.camel@mulgrave>
	<wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
	<20030214173217.A17730@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 14 Feb 2003 16:32:50 +0100
Message-ID: <wrpisvmri71.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030214173217.A17730@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ivan" == Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

Ivan> On Fri, Feb 14, 2003 at 11:16:24AM +0100, Marc Zyngier wrote:
>> # - Add driver for i82375 PCI/EISA bridge.

Ivan> I believe this driver will work for any PCI/EISA bridge without
Ivan> any changes, not only for i82375. Probably we need to look for a
Ivan> class code rather than a device id.

Unfortunately, the i82375 appears to be unclassified :

00:07.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 03)

I'll had PCI_CLASS_BRIDGE_EISA anyway, just in case.

Ivan> Also, to get rid of that x86-ism I'd suggest something like

Ivan> -	i82375_root.bus_base_addr    = 0; /* Warning, this is a x86-ism */
Ivan> -	i82375_root.res		     = &ioport_resource;
Ivan> +	i82375_root.res		     = pdev->bus->resource[0];
Ivan> +	i82375_root.bus_base_addr    = pdev->bus->resource[0]->start;
Ivan> 	i82375_root.slots	     = EISA_MAX_SLOTS;

Ivan> Without that you'll have resource conflicts on multi-hose alphas.

Applied, thanks.

        M.
-- 
Places change, faces change. Life is so very strange.
