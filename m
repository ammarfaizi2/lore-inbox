Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJQBJi>; Tue, 16 Oct 2001 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273364AbRJQBJ3>; Tue, 16 Oct 2001 21:09:29 -0400
Received: from the-kramers.net ([64.81.202.169]:33043 "EHLO
	moleasses.the-kramers.net") by vger.kernel.org with ESMTP
	id <S273345AbRJQBJS>; Tue, 16 Oct 2001 21:09:18 -0400
Message-ID: <3398.160.79.112.174.1003280991.squirrel@mail.the-kramers.net>
Date: Tue, 16 Oct 2001 21:09:51 -0400 (EDT)
Subject: =?iso-8859-1?Q?RAID_5_performance_better_in_degraded_mode!=3F?=
From: "Adam Kramer" <adam@the-kramers.net>
To: <linux-kernel@vger.kernel.org>
Reply-To: adam@the-kramers.net
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If this has been been covered already I apologize in advance, I spent
several hours looking over the archives and could find nothing on this
particular issue.

(I am running kernel 2.4.12)

I have 4 WD600AB drives (I'll call them hda hdc hde hdg) which I want to
run in RAID 5. I have one drive per channel, 2 connected to the motherboard
(VIA KT266A chipset) and 2 connected to a Promise Ultra66 controller. Each
drive is capable of ~38MB/sec sequential transfer rate. My primitive method
for benchmarking is to run vmstat 1 on a virtual console and cat /dev/hda
> /dev/null on another, and look at how many blocks it reads per second.
Sloppy yes, but the results are just about exactly the same as bonnie
reports and this takes less time :)

The promise driver seems to have some performance issues, if I cat /dev/hde
> /dev/null & cat /dev/hdg > /dev/null & and look at blocks in, it maxes
out around 53MB/sec, if I do the same with hda and hdc I get ~77MB/sec
which follows with how fast the drives can transfer. If I read from all 4
hard drives at the same time i'm pulling about 125MB/sec total from the
drives, which seems to indicate to me it isn't a hardware/IDE driver
problem.

I made an array in degraded mode on hdc hde and hdg intending to copy files
over and then add hda into the array as well. I tested reads from the md
device and was getting ~53MB/sec from it, which seemed about right since 2
of the drives were connected to the promise controller.

I then copied my data over from hda onto the array, and added it. Once the
array was done reconstructing, the fastest I could read off of it was
~44MB/sec maximum, average around 41.
Writing was actually faster, on the degraded array writes were about
28MB/sec and on the 4 drive array they are 40MB/sec. I expected this to be
the opposite, writing might be faster on a degraded array but reading
should definitely be slower.

I am using a stripe size of 64K, but tried it with a 128K stripe and it
made no difference.

I made a 3 drive raid0 array out of hdc hde hdg and was reading at 76MB/sec
off of it which seems much more reasonable.


I tried 2.4.12-ac2 and had SERIOUS performance issues with the hard drives,
things just didn't "feel" right.

I am not yet subscribed to linux-kernel so please CC me if anyone has any
interesting ideas.

thanks,
Adam Kramer



