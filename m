Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSAGOLU>; Mon, 7 Jan 2002 09:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSAGOLL>; Mon, 7 Jan 2002 09:11:11 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:4579 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287588AbSAGOKu>; Mon, 7 Jan 2002 09:10:50 -0500
Message-Id: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 14:13:05 +0000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Cc: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Goodie. Now we need benchmarks for all the approaches... (-;

At 13:21 07/01/02, Jeff Garzik wrote:
<snip>
>patch7: implement ext2 use of s_op->{alloc,destroy}
>
>         at this point we have what Linus described:
>
>                 struct ext2_inode_info {
>                         ...ext2 stuff...
>                         struct inode inode;
>                 };

If we were to raise compiler requirements to gcc-2.96 or later this could 
be simplified with an annonymous struct (having elements in struct inode 
with the same name as elements in ...ext2 stuff... should be a shooting 
offence IMO):

         struct ext2_inode_info {
                 ...ext2 stuff...
                 struct inode;
         };

Advantage of this would be that as far as the fs is concerned there is only 
one inode and each element can just be dereferenced straight away without 
need to think was that the generic inode or the fs inode and without need 
for keeping two pointers around. This leads to simpler code inside the 
filesystems once they adapt.

Of course fs which are not adapted would still just work with the fs_i() 
and fs_sb() macros and/or using two separate pointers.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

