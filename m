Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQJ3J2i>; Mon, 30 Oct 2000 04:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbQJ3J23>; Mon, 30 Oct 2000 04:28:29 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2758 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129030AbQJ3J2U>; Mon, 30 Oct 2000 04:28:20 -0500
From: kumon@flab.fujitsu.co.jp
Date: Mon, 30 Oct 2000 18:27:44 +0900
Message-Id: <200010300927.SAA05368@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: kumon@flab.fujitsu.co.jp, Andi Kleen <ak@suse.de>,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FB02D5.9AF89277@uow.edu.au>
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>
	<39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
	<20001027094613.A18382@gruyere.muc.suse.de>
	<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
	<39FAF4C6.3BB04774@uow.edu.au>
	<39FB02D5.9AF89277@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > 
 > I agree with me.  Could you please test the scalability
 > of this?

Here is the result, measured on 8-way profusion.

Andrew posted two paches, so called P1 and P2.

		Req/s
test10-pre5:	2255	bad performance
----
test9+P2:	5243
test10-pre5+P1:	5187
test10-pre5+P2:	5258

P2 may be a little bit better.

----------
Data summary sorted by the performance:
	test8		5287 <-- best performance
	test10-pre5+P2:	5258
	test9+P2:	5243
	test9+mypatch:	5192 <-- a little bit worse
	test10-pre5+P1:	5187
	test1		3702 <-- no good scalability
	test10-pre5:	2255 <-- negative scalability
	test9		2193

The value changes within 30-50 seems fluctuations.


--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
