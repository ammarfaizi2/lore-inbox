Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262164AbSIZDbC>; Wed, 25 Sep 2002 23:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262165AbSIZDbC>; Wed, 25 Sep 2002 23:31:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36738 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262164AbSIZDbA>;
	Wed, 25 Sep 2002 23:31:00 -0400
Date: Wed, 25 Sep 2002 20:30:05 -0700 (PDT)
Message-Id: <20020925.203005.70220632.davem@redhat.com>
To: nf@hipac.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
 for Netfilter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209260344.26814.nf@hipac.org>
References: <200209260238.06400.nf@hipac.org>
	<20020925.173728.08323077.davem@redhat.com>
	<200209260344.26814.nf@hipac.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: nf@hipac.org
   Date: Thu, 26 Sep 2002 03:44:26 +0200
   
   Sorry, we are a bit confused of the formulation "adding the
   algorithmus to the new flow cache"
   Why to the flow cache? What exaclty is the job of this flow cache?
   Does the job go beyond caching recently "lookup results"?

It is just a lookup function, keyed on whatever we'd like to take
from the incoming packet.

I mean that if you find a stronger hash/lookup architecture that
is faster for this purpose, we can integrate into _whatever_
scheme we end up using.

   What happens if the flow cache doesn't have a certain lookup result
   in the cache yet?

It goes to the level 2 lookup tables, which are slightly more complex
yet are still reasonably fast for lookups.

   Is it right, that the code will then use a linear search algorithm and compare 
   the packet with each rule sequentially until a rule is found that matches all 
   relevant fields?
   
No linear search, but because we'll be doing masked/prefix lookups
on the various keys the lookup table will be different than the one
at the top level which uses perfect comparison results.

Just look at how the routing code works now, the final result will
be architected not much differently.

Franks a lot,
David S. Miller
davem@redhat.com
