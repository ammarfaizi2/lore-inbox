Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUAHCp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUAHCp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:45:27 -0500
Received: from ns1.wanfear.com ([207.212.57.1]:35768 "EHLO ns1.wanfear.com")
	by vger.kernel.org with ESMTP id S263593AbUAHCpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:45:16 -0500
Message-ID: <3FFCC430.4060804@candelatech.com>
Date: Wed, 07 Jan 2004 18:45:04 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local>
In-Reply-To: <20040107210255.GA545@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Stephan,
> 
> On Wed, Jan 07, 2004 at 08:05:56PM +0100, Stephan von Krawczynski wrote:
> 
>>Setup is a simple pair of routers with 2 nics each, all e1000. If you start a
>>vrrp setup with keepalived and interface state is down during keepalived
>>startup, then the failover does not work. If the nics are UP during startup
>>everything works well. Now the kernel part of the story: the exact same setup
>>works with tulip cards.
>>Is there a difference regarding UP/DOWN state handling/events in e1000 and
>>tulip. e100 and eepro100 show the same problem btw.
> 
> 
> I noticed the exact same problem about 1 year ago with the early 2.4
> bonding code and eepro100. At this time, I attributed this to a yet
> undiscovered but in the bonding state machine, and could not investigate
> much since it was on a remote production machine. Someone went there and
> rebooted it and everything went OK. Before the reboot, the switch alredy
> detected an UP link, while the bonding code saw it down (using MII at this
> time, not ethtool). I recently read one report (here or on keepalived list)
> about someone who got the same problem with another eepro100. I wonder
> whether there would not be a bug either in the driver or in the chip itself.
> 
> What I noticed is that if you load the driver while the cable is unplugged,
> and then plug it, the MII status says the link is still down. Unfortunately,
> the only e100 I have access to are in prod at a customer's and I really
> cannot make tests there.

You have to bring the interface 'UP' before it will detect link,
with something like:  ifconfig eth2 up

Could that be the problem?

Ben

> 
> Cheers,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


