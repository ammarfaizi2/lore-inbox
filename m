Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbRESG6H>; Sat, 19 May 2001 02:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbRESG55>; Sat, 19 May 2001 02:57:57 -0400
Received: from ha2.rdc2.nsw.optushome.com.au ([203.164.2.51]:16609 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S261669AbRESG5s>; Sat, 19 May 2001 02:57:48 -0400
Message-ID: <3B06194B.C487240C@gnu.org>
Date: Sat, 19 May 2001 16:57:15 +1000
From: Andrew Clausen <clausen@gnu.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben LaHaise <bcrl@redhat.com>
CC: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise wrote:
> The work-in-progress patch for-demonstration-purposes-only below consists
> of 3 major components, and is meant to start discussion about the future
> direction of device naming and its interaction block layer.  The main
> motivations here are the wasting of minor numbers for partitions, and the
> duplication of code between user and kernel space in areas such as
> partition detection, uuid location, lvm setup, mount by label, journal
> replay, and so on...

(1) these issues are independent.  The partition parsing could
be done in user space, today, by blkpg, if I read the code correctly
;-)  (there's an ioctl for [un]registering partitions)  Never
tried it though ;-)

(2) what about bootstrapping?  how do you find the root device?
Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.

(3) how does this work for LVM and RAID?

(4) <propaganda>libparted already has a fair bit of partition
scanning code, etc.  Should be trivial to hack it up... That said,
it should be split up into .so modules... 200k is a bit heavy just
for mounting partitions (most of the bulk is file system stuff).
</propaganda>

(5) what happens to /etc/fstab?  User-space ([u]mount?) translates
/dev/hda1 into /dev/hda/offset=63,limit=1235823, and back?

Andrew Clausen
