Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSHYQUZ>; Sun, 25 Aug 2002 12:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHYQUY>; Sun, 25 Aug 2002 12:20:24 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:62859 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S317400AbSHYQUX>;
	Sun, 25 Aug 2002 12:20:23 -0400
Date: Sun, 25 Aug 2002 12:17:42 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
cc: Mala Anand <manand@us.ibm.com>, <netdev@oss.sgi.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
Message-ID: <Pine.GSO.4.30.0208251158260.29461-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mala,

Could you please at least cc netdev on networking related issues?
It says so in the kernel FAQ.
I swore back around 95 to join lk only when Linux gets a IDE maintainer
who is not insane. Hasnt happened yet.

Can you repeat your tests with the hotlist turned off (i.e set to 0)?
Also if you would be doing tests on NAPI please either copy us or netdev;
it is not nice to read weeks after you post.

Also Robert and i did a few tests and we did find skb recycling (based on
a patch from Robert a few years back) was infact giving perfomance
improvements of upto 15% over regular slab.
Did you test with that patch for the e1000 he pointed you at?
I repeated the tests (around June/July) with the tulip with input rates of
a few 100K packets/sec and noticed a improvement over regular NAPI by
about 10%. Theres one bug on the tulip which we are chasing that
might be related to tulips alignment requirements;

The idea of only freeing on the same CPU a skb allocated is free with
the e1000 NAPI driver style but not in the tulip NAPI  where a txmit
interupt might happen on a different CPU. The skb recycler patch only
recylces if allocation and freeing are happening on the same CPU;
otherwise we let the slab take the hit. On the tulip this happens about
50% of the time.

cheers,
jamal

