Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWAOUKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWAOUKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWAOUKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:10:12 -0500
Received: from ebb.errno.com ([69.12.149.25]:59152 "EHLO ebb.errno.com")
	by vger.kernel.org with ESMTP id S932132AbWAOUKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:10:10 -0500
Message-ID: <43CAABD4.3070004@errno.com>
Date: Sun, 15 Jan 2006 12:08:52 -0800
From: Sam Leffler <sam@errno.com>
Organization: Errno Consulting
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Stefan Rompf <stefan@loplof.de>
CC: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <200601151340.10730.stefan@loplof.de> <56187.84.135.205.30.1137340292.squirrel@secure.sipsolutions.net> <200601151853.31710.stefan@loplof.de>
In-Reply-To: <200601151853.31710.stefan@loplof.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:
> Am Sonntag 15 Januar 2006 16:51 schrieb Johannes Berg:
> 
>> Isn't that rather a question of having good user-space tools that make
>> deactivating one type of interface and activating another seamless?
> 
> Well, it's always easy to point to userspace. However, unregister_netdev() 
> initiates a lot of actions. IPv4 addresses and routes are removed, same for 
> IPv6, IPX, Appletalk etc. Stacked VLAN devices are recursively unregistered 
> (even though I have not tried yet if it works when I create VLANs over 802.3 
> emulated wlan interfaces ;-), udev bloat runs. And all this stuff has to be 
> restored by the nifty new configuration utility, possibly including ifindex 
> and future protocols.
> 
> This is from my usage pattern that I want to go into monitor mode on current 
> channel, look at some packets and return to the association without losing 
> layer 3 configuration.
> 
> So after all, it is IMHO way less painful to handle a mode change in the 
> kernel.

To do what you describe I would create a monitor mode device, switch 
channel, then destroy it.  All the time you leave the station device 
unchanged, though you probably need to disable it.  This may not be 
possible with all devices--i.e. for those that require different 
firmware to do monitoring you will be restricted to a single virtual 
device and/or operating mode.

	Sam
