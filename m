Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQLKXcW>; Mon, 11 Dec 2000 18:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbQLKXcM>; Mon, 11 Dec 2000 18:32:12 -0500
Received: from uberbox.mesatop.com ([208.164.122.9]:32521 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130670AbQLKXcF>; Mon, 11 Dec 2000 18:32:05 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Date: Mon, 11 Dec 2000 16:02:27 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <00121008312900.00872@localhost.localdomain> <006b01c062e2$b4c3ddc0$0500a8c0@methusela>
In-Reply-To: <006b01c062e2$b4c3ddc0$0500a8c0@methusela>
Cc: vii@penguinpowered.com, mojomofo@mojomofo.com
MIME-Version: 1.0
Message-Id: <00121116022700.12045@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:
>Rerun the 2.4.0 with kgcc to be fair. :)

John Fremlin wrote:
>Two points: (1) gcc 2.95 makes slightly slower code than egcs-1.1
>(according to benchmarks on gcc.gnu.org) so compile 2.4 kernel with
>egcs for a fairer comparison. (2) The new VM was a performance

Ok, several people have said that kgcc makes a slightly
better (faster) kernel than gcc.  Here are some more results.

 1   2   3   ave.

453 456 455  454.7 make bzImage for 2.4.0t12p7 running 2.4.0t12p7kgcc

compare this to my previous test using test12-pre7 compiled with gcc:

460 458 454  457.3 make bzImage for 2.4.0t12p7 running 2.4.0t12p7gcc

2.4.0t12p7kgcc is shorthand for 2.4.0-test12-pre7k made with kgcc.
2.4.0t12p7gcc is shorthand for 2.4.0-test12-pre7 made with gcc.

kgcc does indeed make a slightly faster (0.5%) kernel, but I think
we're getting into the pregnant or dimpled chad thing at this point.

To create a kgcc test12-pre7, I modified line 18 and 29 of the top
level Makefile to be =kgcc.  Of course, I then restored the Makefile
to original, since I'm not testing how fast gcc vs kgcc compiles a
bunch of code. I modified EXTRAVERSION to be -test12k so I could
double check with uname -r to make sure I booted the correct kernel.

Kgcc made a somewhat larger kernel than gcc. The same .config file
was used for both kernels.

829034 Dec  7 20:46 vmlinuz-2.4.0-test12-pre7
854863 Dec 11 14:12 vmlinuz-2.4.0-test12-pre7k

I have a SMP (dual P-III 733Mhz) machine at work, but it will be 
unavailable for testing for a few more days.  I suspect that 2.4.0-test12
will do better than 2.2.18 with 2 CPUs.  I'll know in a few days.

Building kernels is something we do so frequently and this test is so easy
to reproduce is why I performed it in the first place.  I think it may be as 
good a test of real performance as some of the more formal benchmarks.
Comments anyone?

Steven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
