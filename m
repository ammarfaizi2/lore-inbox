Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSDCAt2>; Tue, 2 Apr 2002 19:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312935AbSDCAtS>; Tue, 2 Apr 2002 19:49:18 -0500
Received: from xyzzy.dsl.speakeasy.net ([216.254.8.100]:54792 "EHLO
	xyzzy.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id <S312917AbSDCAtK>; Tue, 2 Apr 2002 19:49:10 -0500
Date: Tue, 2 Apr 2002 16:48:49 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
To: jim@rubylane.com
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
In-Reply-To: <20020402233842.25600.qmail@london.rubylane.com>
Message-ID: <Pine.LNX.4.04.10204021623420.5141-100000@xyzzy.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002 jim@rubylane.com wrote:
> 2. The MB IDE ports transfer data at about 18000K/sec while doing
> cat /dev/hda >/dev/null and looking at vmstat.

I think the serverworks IDE is only mode4, not even UDMA33.  I heard a lot of
bad things about it, and removed all the IDE drives from our serverworks
system's controller.

> hdk.  In a 32-bit slot, cat /dev/hdx >/dev/null shows 31300K/sec.  But
> doing cat /dev/hde4 (a specific partition) for example gives
> 8400K/sec.  That makes no sense to me.

The outer cylinders of a drive are faster than the inner cylinders.  Try
repartitioning the drive so that hde4 starts at cylinder 1, and see if that
changes the speed.

> 6. If the Promise card is installed in one of the two 64-bit/66MHz
> slots on the Supermicro MB, then hde (the first ide port) behaves the
> same: 31300K/sec if catting /dev/hde, but only 8400K/sec if catting
> /dev/hde4.  HOWEVER, the master drive on the second port, hdg, yields
> 31300K/sec for both cat /dev/hdg and cat /dev/hdg4.  I have swapped

How is hdg partitioned?  You should expect to see a significant speed
difference between the inner and outer cylinders of a drive.

> I dunno.  This is all getting way too confusing so I am going to find
> a configuration that works and stop trying to make it work perfectly
> and understand the ins and outs.

We have a supermicro 370DE6 (serverworks HE-sl) with a 3ware escalade 7850. 
It's very fast, faster than the mylex extremeraid 2000 with much more
expensive drives in the same computer.  The 3ware hasn't been used much yet in
that machine, but so far we have had no problems.  Maybe the promise cards and
the serverworks IDE controller are just crappy hardware, and are never going
to work correctly?

