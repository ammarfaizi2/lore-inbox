Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbREUJrN>; Mon, 21 May 2001 05:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbREUJrD>; Mon, 21 May 2001 05:47:03 -0400
Received: from ha2.rdc2.nsw.optushome.com.au ([203.164.2.51]:19640 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S262424AbREUJqq>; Mon, 21 May 2001 05:46:46 -0400
Message-ID: <3B08E3BF.50AAB562@gnu.org>
Date: Mon, 21 May 2001 19:45:35 +1000
From: Andrew Clausen <clausen@gnu.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105191728140.15174-100000@penguin.transmeta.com> <3B0717CE.57613D4A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Here's a dumb question, and I apologize if I am questioning computer
> science dogma...
> 
> Why are LVM and EVMS(competing LVM project) needed at all?

EVMS and LVM aren't really competing projects, BTW.  EVMS is
"competing" more with MD.  EVMS will probably use LVM.  (I have
been "out of it" for a month, damned uni assignments...!)
 
> Surely the same can be accomplished with
> * md
> * snapshot blkdev (attached in previous e-mail)
> * giving partitions and blkdevs the ability to grow and shrink
> * giving filesystems the ability to grow and shrink

This last one has little to do with LVM/EVMS.  (it's largely
the same for partitions)  The only difference is you don't need
to handle the resize-the-start case (see below)

> On-line optimization (defrag, etc) shouldn't be hard once you have the
> ability to move blocks and files around, which would come with the
> ability to grow and shrink blkdevs and fs's.

(1) traditional partition implementations tend to have bad
implementations (small static limits on # partitions, etc.)
In other words, partition tables weren't designed for lots
of partitions, which is useful.  (For example, when you expand
a logical volume, you don't need partitions to be "next to each
other"... but the cost is you need to create another partition.
Existing partition table formats tend to starve you)

(2) layering MD on top of partitions means it's impossible to
get redundancy (across disks) on partition table metadata.  So,
if you lose your partition table on one disk, that makes that
whole disk useless.

(3) probably not a good reason: the tools to manage LVM
are more convienient than maintaining partition tables +
MD.

Andrew Clausen
