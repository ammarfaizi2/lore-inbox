Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbRAJQcW>; Wed, 10 Jan 2001 11:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRAJQcM>; Wed, 10 Jan 2001 11:32:12 -0500
Received: from saraksh.alkar.net ([195.248.191.65]:22799 "EHLO smtp3.alkar.net")
	by vger.kernel.org with ESMTP id <S130886AbRAJQcC>;
	Wed, 10 Jan 2001 11:32:02 -0500
Message-ID: <3A5C8DE7.C9237D88@namesys.botik.ru>
Date: Wed, 10 Jan 2001 19:29:27 +0300
From: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect 
 SuSELinux)
In-Reply-To: <205320000.979142950@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

> On Wednesday, January 10, 2001 07:02:08 PM +0300 "Vladimir V. Saveliev"
> <vs@namesys.botik.ru> wrote:
>
> > Hi
> >
> > Chris Mason wrote:
> >
> >> On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann
> >> <pcg@goof.com> wrote:
> >>
> >> >>> EIP; c013f911 <filldir+20b/221>   <=====
> >> > Trace; c013f706 <filldir+0/221>
> >> > Trace; c0136e01 <reiserfs_getblk+2a/16d>
> >>
> >> The buffer reiserfs is sending to filldir is big enough for
> >> the huge file name, so I think the real fix should be done in VFSland.
> >>
> >> But, in the interest of providing a quick, obviously correct fix, this
> >> reiserfs only patch will refuse to create file names larger
> >> than 255 chars, and skip over any directory entries larger than
> >> 255 chars.
> >>
> >
> > Hmm, wouldn't it make existing long named files unreachable?
> >
>
> Yes, that was intentional.  We can make a different version of the patch
> that changes reiserfs_find_entry to allow opening the large filenames for
> delete and such.  But, as a quick fix, I wanted to close all possible paths
> to the long names.
>

Sorry, I still do not understand what you are fixing :)

Btw, I do not see how does fs/readdir.c:fillonedir (I am looking at
2.4.0-test10) check that buffer provided by user is long enough to keep the
name in. (that is old_readdir looks broken for me - am I missing something?)
Whereas filldir seems to check whether there is enough space left in the
buffer.

Thanks,
vs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
