Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbULHOyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbULHOyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbULHOyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:54:17 -0500
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:43478 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261227AbULHOyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:54:12 -0500
Message-ID: <41B7156C.2000702@246tNt.com>
Date: Wed, 08 Dec 2004 15:53:32 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Kumar Gala <kumar.gala@freescale.com>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Second Attempt: Driver model usage on embedded processors
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com> <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
In-Reply-To: <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Malek wrote:

> Why don't you just use the feature_call() model like we currently
> use for PowerPC on the PMac?  Isolate those places in the driver
> that need that information and call the function with a 
> selector/information
> request (and varargs) to get it. 


> For example,
> a driver could:
>
> feature_call(SOC_FTR, Fast_Ethernet1, INIT_IO_PINS);
>
> to configure the IO pins associated with the device, then it could:
>
> feature_call(SOC_FTR, Fast_Ethernet1, GET_CLKS, &txclk, &rxclk);
>
> to get the routing for the transmit and receive clocks, and finally:
>
> feature_call(SOC_FTR, Fast_Ethernet1, GET_PHY_IRQ, &phy_irq);
>
> to get the external interrupt number associated with the PHY.
>

FWIW, I really like this model.

Just as another example, for the I2C driver i2c-mpc, almost the only
variation between model is the clock selection and that forced to put
some processor specific stuff into the driver. With that model, you could
easly avoid theses platform/cpu specific stuff and isolate them.

USB with some really alike bus glues comes to mind too ...

Being able to do "action" in plus of just passing parameters is really nice
IMHO.


    Sylvain
