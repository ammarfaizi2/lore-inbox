Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSJ3INw>; Wed, 30 Oct 2002 03:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSJ3INw>; Wed, 30 Oct 2002 03:13:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46094 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264618AbSJ3INu>; Wed, 30 Oct 2002 03:13:50 -0500
Message-ID: <3DBF9600.4060208@namesys.com>
Date: Wed, 30 Oct 2002 11:19:12 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: Nikita Danilov <Nikita@Namesys.COM>, landley@trommello.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time"
 series.)
References: <200210280534.16821.landley@trommello.org> <15805.27643.403378.829985@laputa.namesys.com>
In-Reply-To: <200210280534.16821.landley@trommello.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to submit a patch appropriate for inclusion as an 
experimental FS on Halloween.   I hope you will forgive our pushing the 
limit timewise, it is not by choice, but the algorithms we used to more 
than double reiserfs V3 performance were, quite frankly, hard to code.

A description of it can be found at www.namesys.com/v4/fast_reiser4.html.

I am going to ask persons to volunteer to produce independent 
benchmarks.  I am told by Oleg and Zam that it is now faster than in the 
benchmarks in the above draft paper, and I hope to see this verified by 
persons outside Namesys.

I hope you will also find our atomic transactions infrastructure 
interesting.  It allows us to guarantee each system call to reiserfs is 
fully atomic, and in later versions we hope to use it to make atomicity 
available to user space so that multiple fs operations can be guaranteed 
atomic.  This will hopefully help to eliminate a major class of security 
holes, as well as provide significantly better protection against user 
data corruption by crashes than any current filesystem.  As you can see, 
it does not seem to substantially harm performance, or at least we 
assume that our more than doubling performance means that performance 
was not harmed.;-)

Finally, and I think in the longterm most importantly, we have 
implemented a full plugin infrastructure for reiser4.  This will make it 
possible for us to implement database and search engine functionality 
one plugin at a time.  (See www.namesys.com/whitepaper.html for a 
description of those semantics.)  We hope you will find the semantics 
much more fun than tacking SQL onto the FS like OFS is going to do.;-)

We don't know how fast OFS will be, but we hope you will enjoy watching 
us raise the bar a few feet.  We are very excited by more than doubling 
performance.  The read performance improvements are more than I expected.  

(If any of you attempt to replicate the benchmarks, please be sure to 
use reiser4 readdir order for writes to reiser4 (that means don't use 
tarballs made from ext2), and to use the latest hard drives and fast 
processors with udma 5 turned on.  We are quite sensitive to transfer 
speed since we do a good job of avoiding seeks.  We are sensitive to 
readdir order because we sort directory entries (which is necessary for 
having efficient large directory lookups)).   In reiser4.1 we will ship 
a repacker, and then it won't matter what order you do writes in so long 
as the repacker gets a chance to run at night.

Cheers,

Hans

Nikita Danilov wrote:

>Rob Landley writes:
> > Hi Linus.
> > 
> > This list is the result of a week of scouring linux-kernel and posting
> > more or less daily versions soliciting feedback from everybody seriously
> > trying to get a patch into 2.5.  This is the ninth and final posting of
> > this list.
> > 
> > Previous versions, and the discussion they spawned, were here:
> > 1.0) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7006.html
> > 1.1) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7051.html
> > 1.2) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7363.html
> > 1.3) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7452.html
> > 1.4) http://lists.insecure.org/lists/linux-kernel/2002/Oct/7827.html
> > 1.5) http://lists.insecure.org/lists/linux-kernel/2002/Oct/8174.html
>
>[...]
>
> > http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
> > 
> > ----------------------------------------------------------------------------
> > 
> > 30) Reiser4.
> > 
> > I don't have a patch yet, but Hans Reiser is very insistent that this
> > will be ready by halloween.  (VERY insistent.)  I'll let him speak for
> > himself:
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/8793.html
> > 
> > And again (promises, promises):
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/9082.html
> > 
> > Still no patch at the time of this writing, though.  In theory it
> > should show up here:
> > http://namesys.com/download.html
>
>Snapshot is available at http://www.namesys.com/snapshots/:
>
>reiser4 proper:
>http://www.namesys.com/snapshots/reiser4-2002.10.24.tar.gz
>
>necessary changes to the core kernel, plus some UML patches, plus some
>patches for debugging:
>http://www.namesys.com/snapshots/reiser4-core-2002.10.24.diff
>
>utils:
>http://www.namesys.com/snapshots/reiser4progs-2002.10.24.tar.gz
>
>I shall produce newer snapshot to-morrow.
>
>It does work, but code is not production quality yet. Do *NOT* put
>anything close to critical data on it.
>
> > 
> > Or perhaps here:
> > ftp://ftp.lugoj.org/pub/reiserfs/devlinux.com/pub/namesys/reiserfs-for-2.5
> > 
> > In the meantime, all I can find on Reiser4 is some kind of hybrid
> > marketing brochure/design document thing:
> > http://www.reiserfs.org/v4/v4.html
> > 
> > Did I mention Hans was insistent?  The man can make puppy eyes through email.
> > It's quite impressive.
>
>Works without email too. :-)
>
> > -- 
> > http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
> > CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
>
>Nikita.
>
> > -
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


