Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423148AbWANAGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423148AbWANAGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423149AbWANAGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:06:04 -0500
Received: from khc.piap.pl ([195.187.100.11]:48914 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1423148AbWANAGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:06:02 -0500
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com>
	<20060113212605.GD16166@tuxdriver.com>
	<20060113213011.GE16166@tuxdriver.com>
	<20060113221935.GJ16166@tuxdriver.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 14 Jan 2006 01:05:59 +0100
In-Reply-To: <20060113221935.GJ16166@tuxdriver.com> (John W. Linville's message of "Fri, 13 Jan 2006 17:19:36 -0500")
Message-ID: <m3oe2fd66w.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John W. Linville" <linville@tuxdriver.com> writes:

> Virtual devices will have a mode (e.g. station, AP, WDS, ad-hoc, rfmon,
> raw?, other modes?) which defines its "on the air" behaviour.  Should
> this mode be fixed when the wlan device is created?

I think so. If needed one can delete and create.

>  Or something
> that can be changed when the net_device is down?

IMHO: unnecessary complicates things.

> It may be necessary to remove, suspend, and/or disable wlan devices
> in order to add, resume, and/or enable other types of wlan devices
> on the same WiPHY device (especialy true for rfmon).  A mechanism is
> needed for drivers to be able to influence or disallow combinations
> of wlan devices in accordance with capabilities of the hardware.

If the control messages go through the main (WiPHY) driver it can
decide and/or forward the request further, to the library.

Not sure about netlink. OTOH I'm at all not sure netlink should be
used for configuration. sysfs, ioctl seem a better options. Netlink
is better for state monitoring etc. I don't know it very well though.

> Do "global" config requests go to any associated wlan device?

Are they any global config settings?
sysctl or sysfs maybe?

> Or must they be directed to the WiPHY device?  Does it matter?

If you mean "settings for a particular physical card" then WiPHY.

> I think we should require "global" configuration to target the WiPHY
> device, while "local" configuration remains with the wlan device.

If "local" means "concerning the wlan device" then sure, yes.

> (I'm not sure how important this point is?)  Either way, the WiPHY
> device will need some way to be able to reject configuration requests
> that are incompatible among its associated wlan devices.  Since the
> wlan interface implementations should not be device specific, perhaps
> the 802.11 stack can be smart enough to filter-out most conflicting
> config requests before they get to the WiPHY device?

I don't think so. The hardware driver should get the request first,
the rest should look like a library.

I've played with both approaches for years and I would avoid
"802.11 using the hw driver" scenario if at all possible.
-- 
Krzysztof Halasa
