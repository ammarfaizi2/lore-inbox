Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136510AbREIOqJ>; Wed, 9 May 2001 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136511AbREIOpt>; Wed, 9 May 2001 10:45:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136510AbREIOpe>; Wed, 9 May 2001 10:45:34 -0400
Subject: Re: reiserfs, xfs, ext2, ext3
To: martin@bugs.unl.edu.ar (=?iso-8859-1?q?Mart=EDn=20Marqu=E9s?=)
Date: Wed, 9 May 2001 15:49:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01050910381407.26653@bugs> from "=?iso-8859-1?q?Mart=EDn=20Marqu=E9s?=" at May 09, 2001 10:38:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xVHE-0002VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that reiserfs has had lots of bugs, and is marked as experimental in kernel 
> 2.4.4. Not to mention that the people of RH discourage there users from using 
> it.

At the time Red Hat 7.1 was mastered Reiserfs was not stable. The reiserfs in
the RH kernel has some of the tail fixes but newer ones are not present. Also
it had other problems then: the fsck tool was useless, it didnt work on
big endian machines (eg PPC, S/390).

If Hans sent me a patch removing the experimental tag from Reiserfs the only
thing that would make me hesitate the slightest from applying it would be the
endianness thing, and thats not enough to stop it being applied.

> There has also been lots of talks about reiserfs being the cause of some data 
> lose and performance lose (not sure about this last one).

If you are running 2.4.4/2.4.4-ac/2.4.5pre I believe all the relevant reiserfs
patches are applied. The new fsck seems to work a lot better too. The limiters
right now are:
	-	You need a patch for NFS (its on their site no big deal)
	-	You can only use little endian boxes (x86 for you so ok)

> So what I want is to know which is the status of this 3 journaling FS. Which 
> is the one we should look for?
> 
> I think that the data lose is not significant in a proxy cache, if the FS is 
> really fast, as is said reiserfs is.

reiserfs seems to handle large amounts of small files well, up to a point but
it also seems to degrade over time. ext3 isnt generally available for 2.4 but
is proving very solid on 2.2 and has good fsck tools. Ext3 does not add
anything over ext2 in terms of large directories of files and other ext2
performance limits.

XFS is very fast most of the time (deleting a file is sooooo slow its like using
old BSD systems). Im not familiar enough with its behaviour under Linux yet.

What you might want to do is to make a partition for 'mystery journalling fs'
and benchmark a bit.

Alan

