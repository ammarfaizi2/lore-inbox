Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRDYRJq>; Wed, 25 Apr 2001 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRDYRJf>; Wed, 25 Apr 2001 13:09:35 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:39596 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S129242AbRDYRJ1>; Wed, 25 Apr 2001 13:09:27 -0400
Message-ID: <3AE704FA.DCF1BEC6@kegel.com>
Date: Wed, 25 Apr 2001 10:10:18 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tim@tjansen.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Device Registry (DevReg) Patch 0.2.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> On Tuesday 24 April 2001 18:39, Martin Dalecki wrote: 
> >> Are there alternatives to get complex and extendable information out to 
> >> user space? 
> > Yes filesystem structures. 
> 
> How exactly can this work? A single value per file is not very helpful if you 
> have a thousand values. You could cluster them (for example one level in the 
> XML hierarchy == one file), but this will soon get very complicated. Its much 
> more work to implement in the kernel, its painful in user-space and you cant 
> just use a text editor to look at it (because you always have to look at 10 
> files per device). 

The command
  more foo/* foo/*/* 
will display the values in the foo subtree nicely, I think.

Think of the /proc tree as the XML parse tree already exploded for you.

The only problem with /proc as it stands is that there is no formal
syntax for its entries.  Some of them are hard to parse.

Before we add a new /proc entry that generates XML which summarizes
the rest of /proc, it might make sense to standardize /proc entries
and write a regression test to verify they are formatted correctly.
It would then be trivial to write a /proc to XML converter which
ran solely in userspace.

See 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.0/0506.html
and
http://marc.theaimsgroup.com/?l=linux-kernel&s=%2Fproc+xml

for prior discussion on the matter.

I don't want to dismiss the reasons you want to use XML for this,
but tread carefully, lest you duplicate lots of code and introduce
cruft.  Better to factor the XML part out to a userspace library...

- Dan
