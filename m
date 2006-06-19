Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWFSMwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWFSMwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWFSMwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:52:47 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:46783 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932436AbWFSMwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:52:47 -0400
Message-ID: <44969E0E.7030403@myri.com>
Date: Mon, 19 Jun 2006 08:52:30 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <4493709A.7050603@myri.com> <44941632.4050703@myri.com> <20060619005329.GA1425@greglaptop> <200606191028.51242.ak@suse.de>
In-Reply-To: <200606191028.51242.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> We got a Serverworks based Supermicro system where the driver for the 
> integrated tg3 NIC complains about MSI not working. So either that particular
> system has a specific BIOS issue or it is broken for on motherboard
> devices.
>  
> I was extrapolating from that.
>
> It doesn't complain on another Supermicro system, but that seems
> to be because that particular BCM570x silicon revision is blacklisted
> for MSI in the tg3 driver.
>
> From that experience I certainly cannot say that MSI works 
> very well on Serverworks so far. It might be safer to blacklist
> until someone can explain what's going on on these systems.
> The problem is that not all drivers do the MSI probing tg3 do,
> so if you got a system where MSI doesn't work. but it tells
> the kernel it does, and a driver turns on MSI things just
> break.
>   

Initially, we thought MSI did not work. But, we actually discovered that
it was caused by the MSI cap being disabled in the Hypertransport config
space. Enabling the MSI cap there seems to make it work.

My patches check the HT MSI cap in a quirk. So you will only get MSI for
your driver if the BIOS/chipset has been correctly initialized.

The next step would be to explicitely set the MSI cap in the
Hypertransport config space in my quirk. I have patches to do so, but
I'd rather wait until my current patches to are stabilized/merged.

Brice

