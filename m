Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSAGAav>; Sun, 6 Jan 2002 19:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSAGAam>; Sun, 6 Jan 2002 19:30:42 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:43468 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289056AbSAGAaZ>; Sun, 6 Jan 2002 19:30:25 -0500
Message-Id: <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 00:30:58 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16NLzo-0001Ld-00@starship.berlin>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:42 06/01/02, Daniel Phillips wrote:
>I wrote:
> > To be honest I fail to see how one additional slab allocation will make
> > any difference.                                                      /
>                                                                       /
>You could say the same about any aspect of Linux: and, relaxing your /
>standards in such a way, you would inevitably end up with a dog.  A /
>good fast system emerges from its many small perfections.  Half of /
>the number of cache entries for inodes qualifies as one of those. /

Big words but mere rhetoric IMHO... You would first have to prove that 
combining the two structures (vfs and fs inodes) is an actual "perfection" 
compared to the case where they are individual, which is what I am not 
convinced about.

Due to the nature of the content in the vfs vs. fs inode I would expect 
that one is used independent of the other in many, if not in the majority 
of cases. If this is correct, then it might well be an actual benefit to 
have the two separate and to benefit from the hwcache line alignment in the 
fs specific part. Also considering that allocation happens once in 
read_inode but the structure is then accessed many times.

Please note, I am not saying you are wrong, most likely you are quite right 
in fact, I am just raising a caution flag that perhaps benchmarks of both 
implementations for the same fs might be a Good Idea(TM)...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

