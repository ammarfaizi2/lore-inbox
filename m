Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130299AbRAAUdc>; Mon, 1 Jan 2001 15:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRAAUdW>; Mon, 1 Jan 2001 15:33:22 -0500
Received: from hermes.mixx.net ([212.84.196.2]:52495 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130299AbRAAUdT>;
	Mon, 1 Jan 2001 15:33:19 -0500
Message-ID: <3A50E1E4.26A8124A@innominate.de>
Date: Mon, 01 Jan 2001 21:00:36 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10101010332330.1050-100000@zeus.fh-brandenburg.de> <Pine.GSO.4.21.0012312220290.7648-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> GFP_BUFFER _may_ become an issue if we move bitmaps into pagecache.
> Then we'll need a per-address_space gfp_mask. Again, patches exist
> and had been tested (not right now - I didn't port them to current
> tree yet). Bugger if I remember whether they were posted or not - they've
> definitely had been mentioned on linux-mm, but IIRC I had sent the
> modifications of VM code only to Jens. I can repost them.

Please, and I'll ask Rik to post them on the kernelnewbies.org patch
page.  (Rik?)  Putting bitmaps and group descriptors into the page cache
will allow the current adhoc bitmap and groupdesc caching code to be
deleted - the for-real cache should have better lru, be more efficient
to access, not need special locking and won't have an arbitrary limit on
number of cached bitmaps.  About 300 lines of spagetti gone.  I suppose
the group descriptor pages still need to be locked in memory so we can
address them through a table instead of searching the hash.  OK, this
must be what you meant by a 'proper' fix to the ialloc group desc bug I
posted last month, which by the way is *still* there.  How about
applying my patch in the interim?  It's a real bug, it just doesn't
trigger often.

> Some pieces of balloc.c cleanup had been posted on fsdevel. Check the
> archives. They prepare the ground for killing lock_super() contention
> on ext2_new_inode(), but that part wasn't there back then.
> 
> I will start -bird (aka FS-CURRENT) branch as soon as Linus opens 2.4.
> Hopefully by the time of 2.5 it will be tested well enough. Right now
> it exists as a large patchset against more or less recent -test<n> and
> I'm waiting for slowdown of the changes in main tree to put them all
> together.

It would be awfully nice to have those patches available via ftp. 
Web-based mail archives don't make it because you can't generally can't
get the patches out intact - the tabs get expanded and other noise
inserted.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
