Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135753AbRDSXaL>; Thu, 19 Apr 2001 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135752AbRDSXaB>; Thu, 19 Apr 2001 19:30:01 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:25758 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S135751AbRDSX3o>;
	Thu, 19 Apr 2001 19:29:44 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrea@suse.de
Subject: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]
Date: Fri, 20 Apr 2001 00:28:09 +0100
X-Mailer: KMail [version 1.2]
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <01042000280900.01311@orion.ddi.co.uk>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You asked for some benchmarks Andrea, so I've obtained some.

The set of test modules can be found at:

	ftp://infradead.org/pub/people/dwh/rwsem-test.tar.bz2

(This also includes rwsem-stat.txt which has a copy of the benchmark results 
in as well)

There are six test programs. They can be made for i386 by the following 
command:

	make

And can also be made to invoke the scheduler after each pass through the loop:

	make SCHED=yes

I ran each individual test twice, hence the two sets of results for 
permutation.

My machine is a Dual 400MHz PII with an 440BX chipset. All the tests were run 
in runlevel 3 with no other applications running.

I benchmarked four different environments:

	(1) 2.4.4-pre3 + Andrea's generic rwsem patch
	(2) 2.4.4-pre4 using XADD to implement the rwsems
	(3) same as (2) but with a tweak to make rwsem_wake() less fair
	(4) 2.4.4-pre3 using my generic spinlock code to implement the rwsems

David


TEST		NUM READERS	NUM WRITERS	CONTENTION
===============	===============	===============	==========
rwsem-rw	4		2		r-w & w-w
rwsem-ro	4		0		no
rwsem-wo	0		4		w-w only
rwsem-r1	1		0		no
rwsem-w1	0		1		no
rwsem-r2	2		0		no


ENVIRONMENT			TEST	SCHED	READERS		WRITERS
===============================	=======	=======	===============	=======
Linux-2.4.4-pre3 + AA-rwsem	rws-rw	no	 3330281	    1009
						 3331972	     994
					yes	 1767102	  607091
						 1743420	  642095
				rws-ro	no	 2534630	n/a
						 3535202	n/a
					yes	 2837218	n/a
						 3164814	n/a
				rws-wo	no	n/a		 2507449
						n/a		 2399102
					yes	n/a		 1568467
						n/a		 1412262
				rws-r1	no	 9232485	n/a
						 9217585	n/a
					yes	 5483757	n/a
						 5487028	n/a
				rws-w1	no	n/a		 9900333
						n/a		 9918021
					yes	n/a		 5745657
						n/a		 5747063
				rws-r2	no	 3499275	n/a
						 3518590	n/a
					yes	 3184431	n/a
						 3180287	n/a

-------------------------------	-------	-------	---------------	-------
Linux-2.4.4-pre4 [XADD]		rws-rw	no	  563388	  283005
						  558159	  280288
					yes	  683670	  197017
						  700714	  194316
				rws-ro	no	 6316985	n/a
						 6314241	n/a
					yes	 4309406	n/a
						 4575043	n/a
				rws-wo	no	n/a		  765699
						n/a		  763876
					yes	n/a		  650512
						n/a		  652287
				rws-r1	no	15171532	n/a
						15158899	n/a
					yes	 7222310	n/a
						 7229793	n/a
				rws-w1	no	n/a		13942744
						n/a		13991823
					yes	n/a		 7362605
						n/a		 7356127
				rws-r2	no	 5517671	n/a
						 5516168	n/a
					yes	 3452796	n/a
						 3331947	n/a

-------------------------------	-------	-------	---------------	-------
Linux-2.4.4-pre4 [XADD]		rws-rw	no	  531929	  267129
 + slightly-unfair-contention			  531093	  266822
   tweak				yes	  839560	  185670
						  903995	  183958
				rws-ro	no	 6318293	n/a
						 6320336	n/a
					yes	 4257862	n/a
						 4315243	n/a
				rws-wo	no	n/a		  766427
						n/a		  766471
					yes	n/a		  644036
						n/a		  642236


-------------------------------	-------	-------	---------------	-------
Linux-2.4.4-pre4 [GENERIC-SPIN]	rws-rw	no	  545138	  274002
						  545378	  273785
					yes	  755343	  187874
						  745888	  185562
				rws-ro	no	 4500398	n/a
						 4506583	n/a
					yes	 3137883	n/a
						 3129119	n/a
				rws-wo	no	n/a		  763599
						n/a		  763059
					yes	n/a		  641256
						n/a		  647319
				rws-r1	no	13110083	n/a
						13115436	n/a
					yes	 6950687	n/a
						 6951901	n/a
				rws-w1	no	n/a		13004627
						n/a		13003754
					yes	n/a		 6899764
						n/a		 6898953
				rws-r2	no	 4741615	n/a
						 4746860	n/a
					yes	 3340292	n/a
						 2967268	n/a
0ãA8
