Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRAIPYX>; Tue, 9 Jan 2001 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAIPYN>; Tue, 9 Jan 2001 10:24:13 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:29967 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129324AbRAIPYD>;
	Tue, 9 Jan 2001 10:24:03 -0500
Message-ID: <3A5B3BF3.485A6375@candelatech.com>
Date: Tue, 09 Jan 2001 09:27:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hashed device lookup (New Benchmarks)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com> <3A597665.4B68C39@candelatech.com> <200101080700.XAA10037@pizda.ninka.net> <3A59EA1F.AEAD08A6@candelatech.com> <20010108175036.A22154@fred.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Mon, Jan 08, 2001 at 04:23:41PM +0100, Ben Greear wrote:
> > I don't argue that ifconfig shouldn't be fixed, but the hash speeds up
> 
> It's already fixed since months. There was one stupid algorithm, which
> I was to blame for when I changed ifconfig to use a device list two years ago.

The benchmark was run against this one:
[root@candle lanforge]# ifconfig --version
net-tools 1.57
ifconfig 1.40 (2000-05-21)


The latest I could find anywhere....  Please tell me the version of a
newer one if it exists.

> > ip by about 2X too.  Is that not useful enough?  ip seems to be implemented
> > pretty efficient, so if the hash helps it significantly then maybe it
> > can help other efficient programs too.  Notice that it is the system
> > (ie kernel) time that stays remarkably flat with the hash + ip graph.
> 
> Just does your benchmark represent anything that real users do frequently ?

I'm going to write something that binds to a raw device, which is something
users (DHCP, for sure) does.  If it does not show any significant improvement,
then I'll drop the issue untill many-many interfaces are more common.

> 
> If you really want to optimize I'm sure there are lots of areas in the kernel
> where your efforts are better spent ;) [just run with a the kernel profiler on
> for a few days on your box and look at all the real hot spots]

I was just trying to smooth VLAN's adoption into the kernel by removing the
one linear-lookup that I know of relating to lots of VLANs.  It obviously
isn't horribly important, but it was fun :)


> 
> BTW, if you just want to optimize ip link ls speed it would be probably enough
> to keep a one behind cache that just caches the next member after the last
> search.

That is still linear in the kernel...or do you mean cache in the kernel?  At any
rate, I'm more concerned about random access.

> 
> -Andi

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
