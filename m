Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbRE0WhG>; Sun, 27 May 2001 18:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbRE0Wgq>; Sun, 27 May 2001 18:36:46 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:33933 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262865AbRE0Wgf>; Sun, 27 May 2001 18:36:35 -0400
Message-Id: <5.1.0.14.2.20010527232717.04827460@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 27 May 2001 23:37:19 +0100
To: Martin von Loewis <loewis@informatik.hu-berlin.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Linux-ntfs] Re: [Linux-NTFS-Dev] Re: ANN: NTFS new
  release available (1.1.15)
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <200105271253.OAA22557@pandora.informatik.hu-berlin.de>
In-Reply-To: <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:53 27/05/2001, Martin von Loewis wrote:
> > Yes and no. They will be uncompressed but not when opening the inode. It
> > will be "uncompress required extent's run list on demand".
>
>Are you sure this can work?

No.

>Initially, I thought I could use the attribute list to only uncompress the 
>extend that has the VCN I'm interested in.

Same idea here.

>That would not work: NT would split individual runs across extends
>(i.e. split them in the middle).

Argh! That seems really stupid thing to do, as it makes it difficult to 
interpret what the highest_vcn/lowest_vcn field of attribute extents is 
supposed to mean!?!

This does however explain some of the code uglyness I have seen (and chosen 
to ignore) in the ntfs.sys disassembly run list handling...

>Did I misunderstand, or do you have a solution for that as well.

No solution. I wasn't aware this could happen. I knew a compression block 
could be split in it halves but I didn't realize this braindamaged 
complication.

I guess we will have to decode the whole run list in one go then. Anything 
else would be slower over all. - What we could do of course is to walk the 
mapping pairs array real quick not reading the numbers only to get the 
correct starting offset into the next extent and then only decode that one 
but that would mean walking the mapping pairs array repeatedly (once to get 
each extent) which would be overall slower than just getting the lot at 
once. - I maintain that we should do this on demand and not on inode open, 
though. - I will have another think about this, but if it is true that NT 
splits the records anywhere, then it would be impossible to start at any 
extent other than the first one.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

