Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDSV6N>; Fri, 19 Apr 2002 17:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSDSV6M>; Fri, 19 Apr 2002 17:58:12 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:29115 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313026AbSDSV6L>;
	Fri, 19 Apr 2002 17:58:11 -0400
Message-ID: <3CC092F2.8090009@candelatech.com>
Date: Fri, 19 Apr 2002 14:58:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <Pine.LNX.4.33L2.0204191408450.15597-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

> On Fri, 19 Apr 2002, Ben Greear wrote:
> 
> | I would like to be able to devide 64bit numbers in a kernel module,
> | but I get unresolved symbols when trying to insmod.
> |
> | Does anyone have any ideas how to get around this little issue
> | (without the obvious of casting the hell out of all my __u64s
> | when doing division and throwing away precision.)?
> 
> Did you look at linux/include/asm*/div64.h ?


I changed my code to look like this:

		char *p = info->pg_result;
                 __u64 mbps = 0;
                 __u64 t1 = (info->pg_sofar*1000);
                 __u64 t2 = do_div(total, 1000);
                 __u64 pps = 0; /* do_div(t1, t2); */
                 t1 = (info->pg_sofar * 1000);
                 mbps = 0;/* do_div(t1, t2); */
                 /* mbps *= info->pkt_size; */

This code will load w/out problems.  However, if I uncomment the do_div
on the line: __u64 pps = 0; /* do_div(t1, t2); */
then I get another unresolved symbol:
__umodi3

I'm guessing that there is some optimization the compiler is doing that
is using the mod operator somehow, but I am unsure about how to work around
this.

Thanks,
Ben


> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


