Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310127AbSCAVTu>; Fri, 1 Mar 2002 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310137AbSCAVTl>; Fri, 1 Mar 2002 16:19:41 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:59844 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S310131AbSCAVTY>;
	Fri, 1 Mar 2002 16:19:24 -0500
Message-ID: <3C7FF04D.1090202@candelatech.com>
Date: Fri, 01 Mar 2002 14:19:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com> <20020301174619.A6125@devcon.net> <3C7FD1E3.800A61FD@mandrakesoft.com> <20020301213458.A30120@devcon.net> <3C7FE9B4.441B553@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:


>>Well, this was discussed on the VLAN mailing list. The conclusion
>>there was that it will not hurt on most cards if it is enabled
>>unconditionally.
>>
> 
> Well, conclusions like that slow down packet processing on the chip,
> quite often...


Do you expect to see slowdowns by just enabling large packet receives,
or just when you actually receive a large packet?


> 
> It does, but not directly.  The infrastructure for VLAN and changing MTU
> share common elements, so both should be merged at the same time.
> 
> This is ESPECIALLY key with 3c59x, because we are turning on support for
> large frames, not specifically VLAN.  That is obviously the same
> operation as changing MTU to a larger, non-standard one, and so should
> not be treated as something vlan-specific.


The subtle difference is that we want to be able to have an MTU 4 bytes
bigger than the VLAN device's MTU, but we most likely do NOT want
the rest of the stack to know we are using the higher MTU, because
then non-vlan packets may not be accepted at the other end.  In
other words, we want eth0's MTU to be 1500, and VLAN1's MTU to be
1500, as far as the layer 3 stacks are concerned.  However, eth0
must really be able to handle a packet of 1504 length.


> Early next week, I will likely make a bombing run through several
> drivers, fixing up the large frame and MTU issues.  That should be
> enough for software VLAN.


That will be a very welcome development!

Thanks,
Ben


> 
> 	Jeff
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


