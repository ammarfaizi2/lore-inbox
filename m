Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136226AbRAGSSs>; Sun, 7 Jan 2001 13:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136239AbRAGSSi>; Sun, 7 Jan 2001 13:18:38 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:43277 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136226AbRAGSSZ>;
	Sun, 7 Jan 2001 13:18:25 -0500
Message-ID: <3A58C1C9.1E4B6265@candelatech.com>
Date: Sun, 07 Jan 2001 12:21:45 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Gleb Natapov <gleb@nbase.co.il>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup (DoesNOT 
 meet Linus' sumission policy!)
In-Reply-To: <Pine.GSO.4.30.0101071241160.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> A very good reason why you would want them to have separate ifindices.
> Essentially, vlans have to be separate interfaces today. Other "virtual"
> interfaces such as aliased devices are not going to work with route
> daemons today since they dont meet this requirement.
> 
> Not to rain on Ben's parade but:
> My thought was to have the vlan be attached on the interface ifa list and
> just give it a different label since it is a "virtual interface" on top
> of the "physical interface". Now that you mention the SNMP requirement,
> maybe an idea of major:minor ifindex makes sense. Say make the ifindex
> a u32 with major 16 bit and minor 16 bit. This way we can have upto 2^16
> physical interfaces and upto 2^16 virtual interfaces on the physical
> interface. The search will be broken into two 16 bits.

What problem does this fix?

If you are mucking with the ifindex, you may be affecting many places
in the rest of the kernel, as well as user-space programs which use
ifindex to bind to raw devices.

On the other hand, the hash patch touches only one file, and should
not have any external impacts.

> 
> Thoughts?
> 
> cheers,
> jamal

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
