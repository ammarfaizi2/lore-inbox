Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTE0DgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTE0DgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:36:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263078AbTE0DgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:36:18 -0400
Message-ID: <3ED2E03E.80004@pobox.com>
Date: Mon, 26 May 2003 23:49:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] xirc2ps_cs irq return fix
References: <200305252318.h4PNIPX4026812@hera.kernel.org>	 <3ED16351.7060904@pobox.com>	 <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com> <1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2003-05-26 at 02:00, Zwane Mwaikambo wrote:
> 
>>My interpretation of it is the PCMCIA controller was triggering interrupts 
>>on exit and the link handler for the card was still installed even after 
>>the netdevice was down.
> 
> 
> This is exactly what will happen all the time on PCMCIA devices. The
> edge triggered interrupt will cause an IRQ to float around every remove
> of the device on most hardware
> 
> The fix is basically correct, although the odd floating IRQ ought to be
> cleaned up by the heuristics being fixed in the core IRQ disaster
> detector


huh?

If the fix is correct, we need to do a bombing run that adds the 
following code to each driver,

	if (!netif_device_present(dev))
		return IRQ_HANDLED;

but of course the irq _wasn't_ handled by the driver.  Silly, isn't it?

I still maintain it needs to be fixed elsewhere.  Touching every driver 
for this is just not scalable, in addition to pointing the finger at the 
pcmcia core instead of individual drivers.

	Jeff


