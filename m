Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291121AbSBGE4z>; Wed, 6 Feb 2002 23:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291114AbSBGE4p>; Wed, 6 Feb 2002 23:56:45 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:690 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291110AbSBGE41>;
	Wed, 6 Feb 2002 23:56:27 -0500
Message-ID: <3C6208F1.2090307@candelatech.com>
Date: Wed, 06 Feb 2002 21:56:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@lxorguk.ukuu.org.uk, ionut@cs.columbia.edu,
        linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu>	<3C6200B5.5060704@candelatech.com> <20020206.203838.107294675.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Wed, 06 Feb 2002 21:21:09 -0700
>    
>    Alan Cox wrote:
>    
>    > UDP is not flow controlled.
>    
>    If it makes it through sendto, where can it be dropped before it
>    hits the wire?
> 
> If the packet ends up being fragmented on the way out and the socket
> cannot take on the allocation against it's buffer space.


In the fragmentation case (at least over 1500 MTU ethernet), the
headers are a relatively small portion of the total PDU, right?
So, if we reserved 10-15% (or whatever it works out to) that should
make it so we never drop the packet due to fragmentation, right?  I can't see any reason
not to reserve this space, because sending a little later is definately
better than going through the work to send it sooner but then having to
drop it down in the local kernel.  We may only want to reserve the buffers
when they are fairly large (ie not you your very small and slow embedded devices
where memory is very precious).


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


