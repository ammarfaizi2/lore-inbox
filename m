Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269533AbSIRXP4>; Wed, 18 Sep 2002 19:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269618AbSIRXP4>; Wed, 18 Sep 2002 19:15:56 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:15258 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269533AbSIRXPz>;
	Wed, 18 Sep 2002 19:15:55 -0400
Message-ID: <3D890A51.7000103@candelatech.com>
Date: Wed, 18 Sep 2002 16:20:49 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch this
 time]
References: <3D88217A.6070702@candelatech.com>	<3D8826BE.5090007@candelatech.com> <20020918.155534.102954410.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Wed, 18 Sep 2002 00:09:50 -0700
>    
>    http://www.candelatech.com/sts_2.4.19.patch
> 
> I don't think I'll be applying this:
> 
> 1) No tcp ipv6 bits

I know squat about this, so am reluctant to hack code there.

> 2) SIOC{S,G}ACCEPTLOCALADDRS added, but no 32-bit translation
>    code added to varions 64-bit/32-bit biarch port ioctl handling.
>    Also, no code added to the ioctl dispatch in the networking
>    so that devices could actually receive these requests.

See http://www.candelatech.com/sts2_hack.patch (32-bit only), it contains the missing
bits, I'm not good at generating two patch sets (ie pktgen and send-to-self)
when they touch the same file...

> 3) Finally, it's just too damn ugly.  If you have to ifdef it then
>    it really doesn't belong in the tree.  Maybe if the device number
>    comparison logic changes existed via macros in tcp.h and thus
>    removing all the CONFIG_NET_SENDTOSELF ifdefs from tcp*.c code
>    it might be more palatable.

The #ifdefs were per request, I personally would like them not to be there
either.  As far as I can tell, the changes are backwards compatible, so there
should be no need for ifdefs.

> 4) I haven't reviewed the ramifications of the route lookup changes,
>    that is Alexey's territory.
> 
> Sorry, these changes are pretty ugly right now.
> 

Thanks for looking at them.  I can fix the #ifdef cruft, but adding 64bit
support or hacking ipv6 is beyond my means of testing at this point, so
I cannot make those changes.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


