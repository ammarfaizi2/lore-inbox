Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVDCTSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVDCTSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDCTSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:18:32 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:20999 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S261876AbVDCTSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:18:17 -0400
In-Reply-To: <424FE1D3.9010805@osvik.no>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <524d7fda64be6a3ab66a192027807f57@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: Use of C99 int types
Date: Sun, 3 Apr 2005 21:23:27 +0200
To: Dag Arne Osvik <da@osvik.no>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 3, 2005, at 2:30 PM, Dag Arne Osvik wrote:

> Stephen Rothwell wrote:
>
>> On Sun, 03 Apr 2005 13:55:39 +0200 Dag Arne Osvik <da@osvik.no> wrote:
>>
>>> I've been working on a new DES implementation for Linux, and ran into
>>> the problem of how to get access to C99 types like uint_fast32_t for
>>> internal (not interface) use.  In my tests, key setup on Athlon 64 
>>> slows
>>> down by 40% when using u32 instead of uint_fast32_t.
>>>
>>
>> If you look in stdint.h you may find that uint_fast32_t is actually
>> 64 bits on Athlon 64 ... so does it help if you use u64?
>>
>>
>
> Yes, but wouldn't it be much better to avoid code like the following, 
> which may also be wrong (in terms of speed)?
>
> #ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
>  #define fast_u32 u64
> #else
>  #define fast_u32 u32
> #endif

Isn't it better to use a general integer type, reflecting the cpu's 
native register-size and let the compiler sort it out? Restrict all 
uses of explicit width types to where it's *really* needed, that is, in 
drivers, network-code, etc. I firmly oppose any definition of "#define 
fast_u32 u64". This kind of definitions will only create needless 
confusion.

I wonder how much other code is suffering from this kind of overly 
explicit typing. It's much easier to make assumptions about integer 
size unwittingly than it is to avoid them. I used to assume (for 
instance) that sizeof(int) == sizeof(long) == sizeof(void *) at one 
point in my career. Fortunately, reality soon asserted itself again.

Regards,

Renate Meijer.

