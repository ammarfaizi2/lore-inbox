Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154532-17796>; Tue, 24 Nov 1998 18:46:34 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:26749 "EHLO neon.transmeta.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <154567-17796>; Tue, 24 Nov 1998 14:14:33 -0500
Date: Tue, 24 Nov 1998 12:40:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
Reply-To: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: pre-2.1.130-3
Message-ID: <Pine.LNX.3.95.981124122729.6535A-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


There's a new pre-patch for people who want to test these things out: I'll
probably make a real 2.1.130 soon just to make sure all the silly problems
in 2.1.129 are left behind (ie the UP flu in particular that people are
still discussing even though there's a known cure). 

The pre-patch fixes a rather serious problem with wall-clock itimer
functions, that admittedly was very very hard to trigger in real life (the
only reason we found it was due to the diligent help from John Taves that
saw sporadic problems under some very specific circumstances - thanks
John). 

It also fixes a very silly NFS path revalidation issue: when we
revalidated a cached NFS path component, we didn't update the revalidation
time, so we ended up doing a lookup over the wire every time after the
first time - essentially making the dcache useless for path component
caching of NFS. If you use NFS heavily, you _will_ notice this change (it
also fixes some rather ugly uses of dentries and inodes in the NFS code
where we didn't update the counter so the inode wasn't guaranteed to even
be there any more!). 

Also, thanks to Richard Gooch &co, who found the rather nasty race
condition when a kernel thread was started from an init-region. The
trivial fix was to not have the kernel thread function be inlined, but
while fixing it was trivial, it wasn't trivial to notice in the first
place. Good debugging.

And the UP flu is obviously fixed here (as it was in earlier pre-patches
and in various other patches floating around).

			Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
