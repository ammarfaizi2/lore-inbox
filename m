Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSFSEnc>; Wed, 19 Jun 2002 00:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317764AbSFSEnb>; Wed, 19 Jun 2002 00:43:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36100 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317763AbSFSEna>; Wed, 19 Jun 2002 00:43:30 -0400
Message-ID: <3D100BE7.4040802@zytor.com>
Date: Tue, 18 Jun 2002 21:43:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x: arch/i386/kernel/cpu
References: <aeouoe$a66$1@cesium.transmeta.com> <20020619063807.B25509@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Jun 18, 2002 at 08:45:18PM -0700, H. Peter Anvin wrote:
>  > Whomever broke up arch/i386/kernel/setup.c and created the CPU
>  > directory (very good idea) messed up in at least one place:
> 
> Patrick Mochel takes credit/glory/fame/blame for this one.

Note that this is great.  We should do the same with bugs.h which is, if 
anything, an even worse mess.

>  > The *AMD-defined* CPUID flags (0x80000001) are not just used on AMD
>  > processors!  In fact, at least AMD, Transmeta, Cyrix and VIA all use
>  > them; I don't know about Centaur or Rise.  Intel supports the actual
>  > level starting with the P4 although it returns all zero.
> 
> Bugger, you're right.

Looked a little harder, and it should *definitely* be moved to generic, 
since it also includes the CPU name string check, which is supported 
even on Intel P4 CPUs.

> On my Cyrix III box before..
> 
>  CPU: After vendor init, caps: 00803135 80803035 00000000 00000000
>  CPU:     After generic, caps: 00803135 80803035 00000000 00000000
>  CPU:             Common caps: 00803135 80803035 00000000 00000000
> 
> and after..
> 
>  CPU: After vendor init, caps: 00803135 80000000 00000000 00000000
>  CPU:     After generic, caps: 00803135 80000000 00000000 00000000
>  CPU:             Common caps: 00803135 80000000 00000000 00000000
> 
> Interesting how it's picking up that 8 in the 2nd set of caps, but
> not any of the other bits..

That's the 3DNow! bit... I was thinking it might be handled specially, 
but it looks like that's only done for Centaur chips.  Are you sure your 
CPU isn't being mis-identified as Centaur by the new code?

>  > It should, in my opinion, be moved into generic_identify().  Anyone
>  > who has a reason why that shouldn't be done speak now or I'll send the
>  > patch to Linus.
> 
> Sounds reasonable to me, unless Patrick has a preferred way of fixing 
> this problem.
> 
>         Dave
> 
> 


