Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRAKE4U>; Wed, 10 Jan 2001 23:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAKE4K>; Wed, 10 Jan 2001 23:56:10 -0500
Received: from uvillage236.customer.onvoy.com ([206.145.228.236]:38925 "EHLO
	3po.dhs.org") by vger.kernel.org with ESMTP id <S131979AbRAKE4H>;
	Wed, 10 Jan 2001 23:56:07 -0500
Message-ID: <3A5D3CE6.6CC24666@tc.umn.edu>
Date: Wed, 10 Jan 2001 22:56:06 -0600
From: Michael Hicks <hick0088@tc.umn.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE troubles (power cycle on mount, write problems)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize this may not be the place to send IDE questions.  Hopefully
I'm not intruding too much.

Anyway, I have two problems.  I know the first is IDE related, but the
second might not be.

First, I have had problems with relatively recent kernels in that my
first drive (Maxtor 90845D4, 8GB), which holds my root filesystem, will
power cycle when the root filesystem is mounted (it seems to get through
fscks just fine, the mounting is the problem).

It appears that the drive cannot operate with (U)DMA.  Up until around
kernel 2.2.17 (sorry - I'm not certain of the kernel), the drive
absolutely refused to work in DMA mode.  Even if DMA support was
compiled in, turned on, and enabled with hdparm, it still wouldn't go
with DMA.  Recently, that changed, and I've been forced to turn off `Use
PCI DMA by default' in the kernel configuration.  In 2.4, it appears
that even forcing that option doesn't work if I have support compiled in
for my motherboard's chipset (VIA VP3).

I'm pretty sure that whatever caused this to happen in the 2.2.x series
is the same thing that caused it in 2.3/2.4, as they both happened
around the same chronological time (I assume whatever changed was
backported or foreported).

Anyway, this won't kill me if it isn't fixed.  Other drives appear to
work without trouble, and I believe that I'll just have to keep DMA
support out of the kernel.

My second problem appears to be much more difficult to solve.  It has
occurred across a large range of kernel versions, and has survived
through three different motherboard/cpu combinations.

I got the above-mentioned 8GB drive in early 1999.  At the time, I was
running either a late 2.1.x or early 2.2.x kernel on a P166 with a PIIX
IDE controller.  I had read about problems formatting disks that large,
but I figured I'd have a go at it anyway.  mke2fs crashed the system a
few times before it finally decided that a good filesystem had been
written to the disk (though I have to question how `good' the filesystem
actually was..)  For a few months, it seemed to work just fine, but
after a while, the system would just lock up, particularly after
extended disk writes, such as when ripping the audio from a CD.

For a long time, I've wondered if these hangs occurred when the disk
detected a bad block or sector and moved it to extra tracks on the
disk.  If the kernel was unable to handle any messages that occurred at
this point, that would explain the problem.  It's about the only reason
I could ever come up with.  Then again, it could just be a bad drive,
and I might be wasting a lot of time and energy complaining about
nothing (though new drives cost money...)

Anyway, I think the lockups associated with that drive are not happening
as much or at all anymore.  However, I have had trouble with reiserfs on
that drive and a new 60 GB drive of mine.  Unfortunately, I can't be
sure if my problems have to do with reiserfs or the ide system itself. 
The same can be said of the old hangups.  I'm still not certain if
they're due to ext2 or the ide system.  I tried reiserfs on the 8gb
drive for a while (I used it on my /home directory -- I don't think I'll
ever do that again..).  At first, things seemed to work really well --
no hangs when ripping CDs ;-)  After a while, I came across all sorts of
corruption and my /home and /usr partitons went back to ext2.

Well, that's the end of my train of thought.  Maybe this rings a bell
with someone.  If not, just trash this message, and I'll just consider
this box to be cursed ;-)

-- 
 _  _  _  _ _  ___    _ _  _  ___ _ _  __   If you're not part of the 
/ \/ \(_)| ' // ._\  / - \(_)/ ./| ' /(__   solution, you're part of  
\_||_/|_||_|_\\___/  \_-_/|_|\__\|_|_\ __)  the precipitate. 
[ Mike Hicks | http://umn.edu/~hick0088/ | mailto:hick0088@tc.umn.edu ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
