Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDAI3k>; Mon, 1 Apr 2002 03:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSDAI3a>; Mon, 1 Apr 2002 03:29:30 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:44811 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S310749AbSDAI3Y>;
	Mon, 1 Apr 2002 03:29:24 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204010828.g318SUH430119@saturn.cs.uml.edu>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
To: tim@physik3.uni-rostock.de (Tim Schmielau)
Date: Mon, 1 Apr 2002 03:28:30 -0500 (EST)
Cc: tomh@po.crl.go.jp (Tom Holroyd), schwab@suse.de (Andreas Schwab),
        linux-kernel@vger.kernel.org (kernel mailing list)
In-Reply-To: <Pine.LNX.4.33.0202201055010.708-100000@gans.physik3.uni-rostock.de> from "Tim Schmielau" at Feb 20, 2002 10:58:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau writes:
> On Wed, 20 Feb 2002, Tom Holroyd wrote:

>>>>  jif * smp_num_cpus - (user + nice + system)
>>>
>>> Changing the line to this:
>>>
>>>   jif * smp_num_cpus - user - nice - system
>>>
>>> should avoid the overflow.
>>
>> True.  It still might be a good idea to make them longs, though,
>> because they are really totals of all the CPUs, as in:
>>                 user += kstat.per_cpu_user[cpu];
>>
>> Now ultimately, kstat.per_cpu_user[cpu] will overflow, and I don't
>> know what to do about that, but making user, nice, and system unsigned
>> long will at least allow SMP systems to last a little while longer.
>> (Actually I don't know why Procps needs these values at all -- the
>> claim in the code is that all of this is just to compute the HZ value,
>> which is presumably needed to be able to interpret jiffies.  It'd be a
>> lot simpler just to have /proc/stat export the HZ value directly.)

Yeah, it would be a lot simpler. Try telling that to Linus. :-(

> I'd still prefer to export only 32 bit of user, nice, and system. This
> way they overflow in a clearly defined way - the 32 bits we export are
> exact, only the higher bits are missing.

The higher bits are absolutely required.

There are ways to push the work of doing a 64-bit counter out into the
proc filesystem and a timer that goes off every 31 bits worth of time.
I've posted an explanation before; you may search for it if you like.

