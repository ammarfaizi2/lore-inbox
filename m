Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUBWBG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUBWBG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:06:57 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:9132 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261700AbUBWBGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:06:51 -0500
Message-ID: <40395227.9030606@cyberone.com.au>
Date: Mon, 23 Feb 2004 12:06:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cw@f00f.org, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <20040222033111.GA14197@dingdong.cryptoapps.com>	<4038299E.9030907@cyberone.com.au>	<40382BAA.1000802@cyberone.com.au>	<4038307B.2090405@cyberone.com.au>	<40383300.5010203@matchmail.com>	<4038402A.4030708@cyberone.com.au>	<40384325.1010802@matchmail.com>	<403845CB.8040805@cyberone.com.au>	<20040221221721.42e734d6.akpm@osdl.org>	<40384D9D.6040604@cyberone.com.au>	<20040222083637.GA15589@dingdong.cryptoapps.com>	<20040222011350.58f756e8.akpm@osdl.org>	<40394662.5060104@cyberone.com.au>	<20040222162634.560c5306.akpm@osdl.org>	<40394A9F.1050606@cyberone.com.au>	<20040222164617.7fba4321.akpm@osdl.org>	<40394F61.8060509@cyberone.com.au> <20040222170032.0219ea67.akpm@osdl.org>
In-Reply-To: <20040222170032.0219ea67.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>>yep.
>>>
>>>
>>>
>>Yeah this is good. I thought the patch you were proposing was
>>to shrink slab on highmem pressure.
>>
>
>That as well.
>
>

Well this is the complexity I'm talking about. Sure it
is actually "simpler" code wise, but you're making it
conceptually more complex.

>>Apply some lowmem pressure due to highmem pressure THEN shrink
>>slab as a result of the lowmem pressure is much better.
>>
>
>Prove it to me ;)
>
>

Your slab wasn't being shrunk because the slab pressure
calculation was way off for highmem systems. My patch fixed
that, so lowmem pressure should shrink slab properly.

Then with your patch, highmem pressure will apply lowmem
pressure. So the end result is that the slab gets appropriate
pressure.

Can't you just prove to me why that doesn't work? ;)

