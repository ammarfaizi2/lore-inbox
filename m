Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313168AbSC1OhL>; Thu, 28 Mar 2002 09:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313169AbSC1Ogv>; Thu, 28 Mar 2002 09:36:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47369 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313168AbSC1Ogs>; Thu, 28 Mar 2002 09:36:48 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15523.10878.394037.864862@laputa.namesys.com>
Date: Thu, 28 Mar 2002 17:36:46 +0300
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <Pine.GSO.4.21.0203280918190.24447-100000@weyl.math.psu.edu>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Wed, 27 Mar 2002, Andrew Morton wrote:
 > 
 > > In 2.5.7 there is a thinko in the allocation and initialisation
 > > of the fs-private superblock for ext2.  It's passing the wrong type
 > > to the sizeof operator (which of course gives the wrong size)
 > > when allocating and clearing the memory. 
 >  
 > > Lesson for the day: this is one of the reasons why this idiom:
 > > 
 > > 	some_type *p;
 > > 
 > > 	p = malloc(sizeof(*p));
 > > 	...
 > > 	memset(p, 0, sizeof(*p));
 > > 
 > > is preferable to
 > > 
 > > 	some_type *p;
 > > 
 > > 	p = malloc(sizeof(some_type));
 > > 	...
 > > 	memset(p, 0, sizeof(some_type));
 > 
 > ... however, there is a lot of reasons why the former is preferable.
 > For one thing, the latter is hell on any search.  Moreover, I would
 > argue that memset() on a structure is not a good idea - better do
 > the explicit initialization.

Explicit initialization always leaves room for some "pad" field inserted
by compiler for alignment to be left with garbage. This is more than
just annoyance when structure is something that will be written to the
disk. Reiserfs had such problems.

 > 
 > 

Nikita.
