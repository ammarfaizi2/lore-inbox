Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264345AbUEIPgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbUEIPgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 11:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUEIPgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 11:36:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:32731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264345AbUEIPgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 11:36:13 -0400
Date: Sun, 9 May 2004 08:35:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
Message-ID: <Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org>
References: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 May 2004, Guennadi Liakhovetski wrote:

> On Sat, 8 May 2004, Linus Torvalds wrote:
> 
> >    1:     5.04 % (    5.04 % cum -- 2246)
> >    2:     5.19 % (   10.23 % cum -- 2312)
> 
> Ok, risking to state the obvious - it was intentional to count "."s and
> ".."s, wasn't it? Just this makes it a bit non-trivial to compare this
> statistics with Andrew's.

Ok, here's a version that doesn't count "." and "..". My numbers don't 
really change much for the kernel:

   1:     0.00 % (    0.00 % cum -- 2)
   2:     0.17 % (    0.17 % cum -- 68)
   3:     0.62 % (    0.79 % cum -- 247)
   4:     3.67 % (    4.46 % cum -- 1469)
   5:     3.72 % (    8.18 % cum -- 1492)
   6:     4.84 % (   13.03 % cum -- 1940)
   7:     8.40 % (   21.43 % cum -- 3365)
   8:    10.72 % (   32.14 % cum -- 4293)
   9:    10.19 % (   42.34 % cum -- 4084)
  10:    12.21 % (   54.55 % cum -- 4891)
  11:     8.50 % (   63.05 % cum -- 3406)
  12:     7.79 % (   70.84 % cum -- 3122)
  13:     5.74 % (   76.58 % cum -- 2298)
  14:     4.26 % (   80.84 % cum -- 1706)
  15:     3.86 % (   84.69 % cum -- 1545)
  16:     2.34 % (   87.04 % cum -- 939)
  17:     1.64 % (   88.67 % cum -- 655)
  18:     1.18 % (   89.85 % cum -- 472)
  19:     0.76 % (   90.61 % cum -- 303)
  20:     0.47 % (   91.08 % cum -- 188)
  21:     0.32 % (   91.40 % cum -- 128)
  22:     0.27 % (   91.66 % cum -- 107)
  23:     0.16 % (   91.82 % cum -- 63)

and we've reached over 90% coverage with the 24-byte inline name.

(We don't strictly _need_ the terminating '\0' at the end of the dentry 
name, since they are all counted strings anyway, but it certainly is safer 
that way).

Same goes for my full tree:

   1:     0.11 % (    0.11 % cum -- 1073)
   2:     0.41 % (    0.53 % cum -- 3918)
   3:     1.82 % (    2.35 % cum -- 17256)
   4:     4.32 % (    6.68 % cum -- 40925)
   5:     3.58 % (   10.25 % cum -- 33860)
   6:     4.74 % (   15.00 % cum -- 44874)
   7:     8.00 % (   23.00 % cum -- 75750)
   8:     9.35 % (   32.35 % cum -- 88451)
   9:     8.98 % (   41.33 % cum -- 84987)
  10:    10.99 % (   52.32 % cum -- 104021)
  11:     8.81 % (   61.13 % cum -- 83404)
  12:     9.28 % (   70.41 % cum -- 87826)
  13:     5.04 % (   75.45 % cum -- 47690)
  14:     3.87 % (   79.32 % cum -- 36592)
  15:     3.11 % (   82.43 % cum -- 29431)
  16:     2.04 % (   84.47 % cum -- 19311)
  17:     1.55 % (   86.02 % cum -- 14703)
  18:     1.21 % (   87.23 % cum -- 11410)
  19:     0.95 % (   88.17 % cum -- 8952)
  20:     0.89 % (   89.07 % cum -- 8423)
  21:     0.98 % (   90.04 % cum -- 9264)
  22:     0.82 % (   90.87 % cum -- 7798)
  23:     0.80 % (   91.66 % cum -- 7534)

so Andrew really must have a fairly different setup if he sees 20% 
filenames being > 23 characters.

> [OT, educational]: Do "." and ".." actually take dentries?

Nope, they are resolved early. So you're right, I shouldn't have counted 
them.

		Linus
