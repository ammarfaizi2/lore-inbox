Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271651AbRH0Eli>; Mon, 27 Aug 2001 00:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271652AbRH0ElT>; Mon, 27 Aug 2001 00:41:19 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:44239 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271651AbRH0ElN>;
	Mon, 27 Aug 2001 00:41:13 -0400
Message-ID: <3B89CF75.376CBE5B@candelatech.com>
Date: Sun, 26 Aug 2001 21:41:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: VIA Rhine problem in 2.4.9-pre4
In-Reply-To: <Pine.LNX.4.10.10108251909110.13314-100000@ada.teststation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
> On Fri, 24 Aug 2001, Ben Greear wrote:
> 
> > This last time it happened, I noticed this printed to the console:
> >
> > eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x9 length 0 status 00000600
> > eth0:  Oversized Ethernet frame c7572090 vs c7572090.
> 
> I can't answer what this is, but I can point you to a prevous discussion
> on the subject:
>     http://uwsg.iu.edu/hypermail/linux/net/0006.1/0005.html
> 
> I assume that this is not a problem that you only get on 2.4.9-pre4, but
> on any kernel version you try?

I believe the problem was that my program that reads information out of
the drivers (IP, mask, MTU, QLEN, and the MII-diag flags) was in a very
tight loop, and so was almost constantly trying to read the information.

I fixed that problem, and haven't seen the NIC lock up since.  If I
get a chance, I'm going to make a stand-alone GPL version of that code, and when
I do I'll add an option to stress the kernel/drivers and see if I can
reproduce this NIC lockup.

Thanks,
Ben

> 
> Drivers for other cards have also reported this (search on google).
> 
> Donald Beckers answer to a question on this subject:
>     http://uwsg.iu.edu/hypermail/linux/net/9801.1/0159.html
> 
> > I looked at /proc/net/dev and didn't see too many errors (there were a few, though,
> > including carrier errors).  I tried replacing the cable but that did not fix
> > the problem.  The link does come back up after reboot...
> 
> Does unloading the modules and then reloading it help? (assuming you run
> it as a module). ifconfig down/up is another variant some people have
> used for other problems.

ifup/down didn't help, but I didn't try reloading the module.

> 
> /Urban
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
