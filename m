Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTBDRak>; Tue, 4 Feb 2003 12:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbTBDRak>; Tue, 4 Feb 2003 12:30:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266640AbTBDRaj>;
	Tue, 4 Feb 2003 12:30:39 -0500
Date: Tue, 4 Feb 2003 09:37:49 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Denis Vlasenko wrote:

| On 3 February 2003 10:28, Matti Aarnio wrote:
| >
| > You don't need to have 64-bit jiffy for things like internal
| > timers, nor for uptime tracking.
| >
| > Timers have well behaving constructs to use 32-bit jiffy quite
| > successfully, and 64-bit values, especially atomicish, in 32-bit
| > register-poor machines (i386) are damn difficult.
| >
| > I do have a number of machines with 100 to 300 day uptimes, all
| > with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
| > one full wrap-around of jiffy.
|
| Your processes will show strange start times, CPU times etc.
| This will happen in 2.5 pretty soon (after 50 days uptime).
|
| However, this is a bit cosmetic. There is a much more serious problem:
|
| 		Jiffy Wrap Bugs
|
| There were reports of machines hanging on jiffy wrap.
| This is typically a result of incorrect jiffy use in some driver.
| Ask Tim - he is hunting those problems regularly, but he is outnumbered
| by buggy driver authors. :(
|
| There is a better solution to ensure correct jiffy wrap handling in
| *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
| Tim has a patch for such config option. This is almost right.
| This MUST NOT be a config option, it MUST be mandatory in every
| kernel. Driver writers would be bitten by their own bugs and will
| fix it themself. Tim, what do you think?

I like it too.  We should take advantage of easy-to-force/find/fix
problems like this.

-- 
~Randy

