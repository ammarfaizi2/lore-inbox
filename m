Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268250AbSIRRxd>; Wed, 18 Sep 2002 13:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268251AbSIRRxd>; Wed, 18 Sep 2002 13:53:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268250AbSIRRxb>;
	Wed, 18 Sep 2002 13:53:31 -0400
Date: Wed, 18 Sep 2002 10:54:39 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Lev Makhlis <mlev@despammed.com>
cc: <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
In-Reply-To: <200209141457.54905.mlev@despammed.com>
Message-ID: <Pine.LNX.4.33L2.0209181052360.19972-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Lev Makhlis wrote:

| > +#define MSEC(x) ((x) * 1000 / HZ)
|
| Perhaps it would be better to report the times in ticks using
| jiffies_to_clock_t(), and let the userland do further conversions?
| The macro above has an overflow problem, it creates a counter
| that wraps at 2^32 / HZ (instead of 2^32), and theoretically, the
| userland doesn't even know what the internal HZ is.  The overflow
| can be avoided with something like
| #define MSEC(x) (((x) / HZ) * 1000 + ((x) % HZ) * 1000 / HZ)
| but I think it would be cleaner just to change the units to ticks,
| especially if we're moving it to a different file and procps will
| need to be changed anyway.

Thanks for pointing this out.

I'd rather not expose more ticks in /proc, so for now
I'll ask Rick to use this #define for MSEC, which does
indeed work nicely.

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

