Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRKLW6p>; Mon, 12 Nov 2001 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281161AbRKLW6f>; Mon, 12 Nov 2001 17:58:35 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:24328 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S281158AbRKLW6T>;
	Mon, 12 Nov 2001 17:58:19 -0500
Date: Mon, 12 Nov 2001 23:56:42 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Frank de Lange <lkml-frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112235642.A17544@unternet.org>
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF02BA4.D7E2D70E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Nov 12, 2001 at 03:05:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 03:05:56PM -0500, Jeff Garzik wrote:
> Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?

Here's the results from some tests I did:

2.2.20
======
without filesystem activity
no slowdowns observed
time ls -al /usr/|sort -k 5 -n
real	0m0.121s
user	0m0.000s
sys	0m0.090s

with filesystem activity on ext2
no slowdowns observed
time ls -al /opt/|sort -k 5 -n
real	0m0.079s
user	0m0.010s
sys	0m0.100s

2.4.13-ac5
==========
no slowdowns observed
without filesystem activity
time ls -al /usr/|sort -k 5 -n
real	0m0.142s
user	0m0.000s
sys	0m0.000s

with filesystem activity on ext2
no slowdowns observed
time ls -al /opt/|sort -k 5 -n
real	0m0.022s
user	0m0.020s
sys	0m0.010s

with filesystem activity on reiserfs
 - it took 31 seconds to just open this small ( < 1 kb) text file (which
   resides in my home directory, on an ext2 filesystem) in vi...
time ls -al /usr/|sort -k 5 -n
real    0m6.136s
user    0m0.020s
sys     0m0.020s


2.4.15-pre4
===========
without filesystem activity
no slowdowns observed
time ls -al /usr/|sort -k 5 -n
real	0m0.081s
user	0m0.010s
sys	0m0.010s

with filesystem activity on ext2
no slowdowns observed
time ls -al /usr/|sort -k 5 -n
real    0m0.146s
user    0m0.000s
sys     0m0.020s

with filesystem activity on reiserfs
system behaviour erratic, some slowdowns
time ls -al /opt|sort -k5 -n
real    0m13.232s
user    0m0.020s
sys     0m0.010s

Seems that reiserfs is the common factor here, at least on my box. This is a 35
GB reiserfs filesystem, app 80% used, both large and small files.

As said in my previous message, the numbers themselves don't mean squat. It is
the large delays (the fact that user+sys <<< real) which are the problem here.

Any other magic anyone wants me to perform? Hans, you reading this?

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \ lkml-frank@unternet.org  /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
