Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132449AbQKKUty>; Sat, 11 Nov 2000 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132454AbQKKUto>; Sat, 11 Nov 2000 15:49:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:11258 "EHLO
	e34.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S132449AbQKKUtj>; Sat, 11 Nov 2000 15:49:39 -0500
Importance: Normal
Subject: Re: [patch] nfsd optimizations for test10
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
        nfs-devel@linux.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF9401A42C.AB2D078B-ON88256994.0070AF60@LocalDomain>
From: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Sat, 11 Nov 2000 12:51:44 -0800
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.5 |September 22, 2000) at
 11/11/2000 12:49:34 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 1/ Do you have any stats showing what sort of speedup this gives -
    I'm curious.


I don't have the exact timing stats to show the improvements, but I do have
some stats that I gathered when running SPEC SFS.
Basically with the default racache scheme which only keeps 80 entries in
the table (if I remember the # right), since SPEC SFS works on a lot of
files, I can see that shortly after the SPEC SFS test gets started, the
table is filled up, and nfsd_get_raparam() will never insert any other ra
values to the table, i.e., the racache hit ratio is always 0 for the SPEC
SFS runs, and yet each time when it's called, it scans the entire table
once, i.e., 80 table entries. On the other hand, when hash table is used,
on average, the old files can be removes and new entries can be added
dynamically, so the hit ratio improves and even if there isn't a hit, the
hash chain search is far more better than a table scan. On average, at most
a few list walk will suffice.


 2/ Was there a particular reason that you didn't use the
      include/linux/list.h
    list structures for the hash and lru chains?  If not, I suggest
    that doing so would be a good idea.  It should make the code
    clearer and more in-keeping with other code in the kernel.

No there isn't. Oh, well, maybe there is... I used nfscache.c as the base
when I built racache, which didn't use list.h.
Having said that, I just did not try hard to make the kernel more
consistant.

 3/ It is easiest for (many of) us if you just include the patch
    in-line in your email messages rather than as an attachment.   You
    can then be sure that EVERY mail reader can display it
    effectively, and Linus has said a number of times that he doesn't
    like attachments.
 3a/ If you or your mailer insists on using attachments, please make
    sure that the mime-type of the attachment is correct - text/plain,
    not applications/x-unknown.  Again, that makes it a lot easier to
    read your patch.

No problem with this. I will do that for the future patches.

 4/ I doubt that this is significant enough to go in before 2.4.0-final
now,
    but it probably has a reasonable chance of getting in shortly
    afterwards.

I really hope that this can go into 2.4, since the changes are really
straight-forward and I've been testing and running this under a wide range
of situations for a couple months in my own patched kernels. I probably
should have sent it a bit earlier. Oh, well.


NeilBrown
knfsd maintainer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
