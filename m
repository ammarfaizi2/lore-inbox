Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281203AbRKHApE>; Wed, 7 Nov 2001 19:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKHAos>; Wed, 7 Nov 2001 19:44:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63883 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281203AbRKHAog>;
	Wed, 7 Nov 2001 19:44:36 -0500
Date: Wed, 07 Nov 2001 16:44:26 -0800 (PST)
Message-Id: <20011107.164426.35502643.davem@redhat.com>
To: adilger@turbolabs.com
Cc: tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011107173626.S5922@lynx.no>
In-Reply-To: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de>
	<20011107.160950.57890584.davem@redhat.com>
	<20011107173626.S5922@lynx.no>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Dilger <adilger@turbolabs.com>
   Date: Wed, 7 Nov 2001 17:36:27 -0700

   No, only a limited number of them cast to a signed value, which means
   that a large number of them get the comparison wrong in the case of
   jiffies wrap (where the difference is a large unsigned value, and not
   a small negative number).
   
Why do they these cases that are actually in the code need to cast to
a signed value to get a correct answer?  They are not like your
example.

Almost all of these cases are:

	(jiffies - SOME_VALUE_KNOWN_TO_BE_IN_THE_PAST) > 5 * HZ

So you say if we don't cast to signed, this won't get it right on
wrap-around?  I disagree, let's say "long" is 32-bits and jiffies
wrapped around to "0x2" and SOME_VALUE... is 0xfffffff8.  The
subtraction above yields 10, and that is what we want.

Please show me a bad case where casting to signed is necessary.

I actually ran through the tree the other night myself starting to
convert these things, then I noticed that I couldn't even convince
myself that the code was incorrect.

Franks a lot,
David S. Miller
davem@redhat.com
