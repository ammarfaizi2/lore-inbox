Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137138AbRAHHJQ>; Mon, 8 Jan 2001 02:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137137AbRAHHJH>; Mon, 8 Jan 2001 02:09:07 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:55826 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136990AbRAHHJC>;
	Mon, 8 Jan 2001 02:09:02 -0500
Message-ID: <3A597665.4B68C39@candelatech.com>
Date: Mon, 08 Jan 2001 01:12:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hashed device lookup (New Benchmarks)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See a pretty graph showing performance of ifconfig and ip
both with and without my device-hashed-lookup patch:

http://grok.yi.org/~greear/hashed_dev.png
(If you can't get to it, let me know and I'll email it to you...some
 cable modem networks have I firewalled.)

I ran ifconfig -a and ip addr show every 50 interfaces,
as I added 4000 interfaces, and used the 'time -p' program to
find the system and user times.

Summary:
	ifconfig scales badly, ip is better.
	Both ip and ifconfig work better with the hash patch, at
        least when the number of interfaces grows past 1000.

If anyone wants the raw numbers, I can provide them and the script
that generated them.

NOTE:  I stopped the non-hashed test after 3000 interfaces because
it was just going too slow (ifconfig was killing me!)

So, is this good enough reason to add the hashed patch?

If not, I feel sure I can write a program that binds to a specific
interface 10k times, and my assumption is that the hash will help
significantly if there are lots of interfaces.  However, I'd
rather not go to the hassle if the ifconfig/ip numbers are sufficient.

If no amount of benchmarking will change key player's minds, then
go ahead and tell me now so that I can go back to hacking code
and just include this patch with my VLAN patch.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
