Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUHWRHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUHWRHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHWRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:07:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:9651 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265973AbUHWRGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:06:39 -0400
Date: Mon, 23 Aug 2004 10:05:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: root@chaos.analogic.com
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Jean-Luc Cooke <jlcooke@certainkey.com>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040823100547.33b7a448@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.53.0408201518250.25319@chaos>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040820175952.GI5806@certainkey.com>
	<20040820185956.GV8967@schnapps.adilger.int>
	<Pine.LNX.4.53.0408201518250.25319@chaos>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The attached code will certainly work on Intel machines. It is
> in the public domain, having been modified by myself to produce
> a very long sequence...
> 
> I wouldn't suggest converting it to 'C' because the rotation
> takes many CPU instructions when one tries to do the test, shift,
> and OR in 'C',
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 

My choice of PRNG was not random. I am not a mathematician (IANAM),
but what I was looking for was:

+ well researched
+ fast
+ good distribution
+ small seed (since per cpu)
+ Free and open

The second version uses tausworthe because it was the fastest in the GNU scientific
library and had good properties.

See:

http://www1.physik.tu-muenchen.de/~gammel/matpack/html/LibDoc/Numbers/Random.html
----------
Returns integer pseudorandom numbers uniformly distributed within [0,4294967295].
The period length is approximately 288 (which is 3*1026).

This is Pierre L'Ecuyer's 1996 three-component Tausworthe generator "taus88"

This generator is very fast and passes all standard statistical tests.

P. L'Ecuyer, Maximally equidistributed combined Tausworthe generators, Mathematics of Computation 65, 203-213 (1996), see Figure 4.
P. L'Ecuyer, Random number generation, chapter 4 of the Handbook on Simulation, Ed. Jerry Banks, Wiley, 1997.
--------
http://www.gnu.org/software/gsl/manual/gsl-ref_17.html

Performance
The following table shows the relative performance of a selection the available random number generators. The fastest simulation quality generators are taus, gfsr4 and mt19937. The generators which offer the best mathematically-proven quality are those based on the RANLUX algorithm.

1754 k ints/sec,    870 k doubles/sec, taus
1613 k ints/sec,    855 k doubles/sec, gfsr4
1370 k ints/sec,    769 k doubles/sec, mt19937
 565 k ints/sec,    571 k doubles/sec, ranlxs0
 400 k ints/sec,    405 k doubles/sec, ranlxs1
 490 k ints/sec,    389 k doubles/sec, mrg
 407 k ints/sec,    297 k doubles/sec, ranlux
 243 k ints/sec,    254 k doubles/sec, ranlxd1
 251 k ints/sec,    253 k doubles/sec, ranlxs2
 238 k ints/sec,    215 k doubles/sec, cmrg
 247 k ints/sec,    198 k doubles/sec, ranlux389
 141 k ints/sec,    140 k doubles/sec, ranlxd2

1852 k ints/sec,    935 k doubles/sec, ran3
 813 k ints/sec,    575 k doubles/sec, ran0
 787 k ints/sec,    476 k doubles/sec, ran1
 379 k ints/sec,    292 k doubles/sec, ran2


