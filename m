Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVAKAlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVAKAlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAKAle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:41:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:27009 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262762AbVAKAkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:40:46 -0500
Message-ID: <41E31D95.50205@osdl.org>
Date: Mon, 10 Jan 2005 16:28:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
References: <8746466a050110153479954fd2@mail.gmail.com> <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 10 Jan 2005, Dave wrote:
> 
>>After all said and done, the struct resource members start and end
>>must support 64bit integer values in order to work. On a 64bit arch
>>that would be fine since unsigned long is 64bit. However on a 32bit
>>arch one must use unsigned long long to get 64bit.
> 
> 
> We really should make "struct resource" use u64's. It's wrong even on x86, 
> but we've never seen any real problems in practice, so we've had little 
> reason to bother.
> 
> This has definitely come up before, maybe there's even some old patch 
> floating around. It should be as easy as just fixing up "start/end" to be 
> "u64" (and perhaps move them to the beginning of the struct to make sure 
> packing is ok on all architectures), and fixing any fall-out.

Speaking of fall-out, or more like trickle-down,
I'm almost done with a patch to make PCMCIA resources use
unsigned long instead of u_int or u_short for IO address:

incluce/pcmcia/cs_types.h:
#if defined(__arm__) || defined(__mips__)
typedef u_int   ioaddr_t;
#else
typedef u_short	ioaddr_t;
#endif

becomes:
typedef unsigned long	ioaddr_t;

and then include/pcmcia/cs.c needs some changes in use of
ioaddr_t, along with drivers (printk formats).

Does that sound OK?
I guess that it would become unsigned long long (or u64)
with this proposal?

-- 
~Randy
