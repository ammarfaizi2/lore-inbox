Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbUG1Xae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUG1Xae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUG1X2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:28:51 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:60546 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S267184AbUG1X0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:26:31 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Wed, 28 Jul 2004 19:26:29 -0400
User-Agent: KMail/1.6.82
References: <200407271233.04205.gene.heskett@verizon.net> <20040727142918.GE12308@parcelfarce.linux.theplanet.co.uk> <200407271331.13081.gene.heskett@verizon.net>
In-Reply-To: <200407271331.13081.gene.heskett@verizon.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281926.29920.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [141.153.76.185] at Wed, 28 Jul 2004 18:26:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I just had another crash, but this one was different.

/dev/hda5 developed an error and was remounted read
only by the system.  As thats /root, everything pretty
much came to a screeching halt several hours ago while
I was out carving the tapered ends on some split rail
fencing, a somewhat dangerous job because its arsenic
treated wood, and I made a large leaf bag of sawdust
and wood chips with bare hands and no resperator filter
device.

Here is the log for the event:
---------------
Jul 28 13:37:00 coyote kernel: EXT3-fs error (device hda5): ext3_free_blocks: bit already
cleared for block 761450
Jul 28 13:37:00 coyote kernel: Aborting journal on device hda5.
Jul 28 13:37:00 coyote kernel: ext3_free_blocks: aborting transaction: Journal has aborted
 in __ext3_journal_get_undo_access<2>EXT3-fs error (device hda5) in ext3_free_blocks: Jour
nal has aborted
Jul 28 13:37:00 coyote last message repeated 16 times
Jul 28 13:37:00 coyote kernel: ext3_reserve_inode_write: aborting transaction: Journal has
 aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hda5) in ext3_reserve_
inode_write: Journal has aborted
Jul 28 13:37:00 coyote kernel: EXT3-fs error (device hda5) in ext3_truncate: Journal has a
borted
Jul 28 13:37:00 coyote kernel: ext3_reserve_inode_write: aborting transaction: Journal has
 aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hda5) in ext3_reserve_
inode_write: Journal has aborted
Jul 28 13:37:00 coyote kernel: EXT3-fs error (device hda5) in ext3_orphan_del: Journal has
 aborted
Jul 28 13:37:00 coyote kernel: ext3_reserve_inode_write: aborting transaction: Journal has
 aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hda5) in ext3_reserve_
inode_write: Journal has aborted
Jul 28 13:37:00 coyote kernel: EXT3-fs error (device hda5) in ext3_delete_inode: Journal h
as aborted
Jul 28 13:37:00 coyote kernel: ext3_abort called.
Jul 28 13:37:00 coyote kernel: EXT3-fs abort (device hda5): ext3_journal_start: Detected a
borted journal
Jul 28 13:37:00 coyote kernel: Remounting filesystem read-only
Jul 28 18:34:29 coyote shutdown: shutting down for system reboot

On the reboot and e2fsck of /dev/hda5, one inode had
zero dtime and was fixed.

This is the third crash today.  I'm now building a plain
2.6.7 to run on this board as thats the newest version that
has a diff in fs/dcache.c, from 2.6.7-mm1 they are all identical.


>On Tuesday 27 July 2004 10:29,
> viro@parcelfarce.linux.theplanet.co.uk
>
>wrote:
>>On Tue, Jul 27, 2004 at 12:33:04PM -0400, Gene Heskett wrote:
>>> Greetings everybody;
>>>
>>> I have now had 4 crashes while running 2.6.8-rc2, the last one
>>> requiring a full powerdown before the intel-8x0 could
>>> re-establish control over the sound.
>>>
>>> All have had an initial Opps located in prune_dcache, and were
>>> logged as follows:
>>> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL
>>> pointer dereference at virtual address 00000000
>>
>>... which means that dentry_unused list got corrupted, which
>> doesn't really help.  Could you try to narrow it down to
>> 2.6.8-rc1-bk<day>?
>
>And something else that doesn't help, I just found that 2.6.8-rc1
>doesn't have the reverse engineered nforce2 support, so a remake for
>this mobo probably won't fly past the decompression stage.  But
>2.6.8-rc1-mm1 does have it, but under a different xconfig entry. 
> Its building now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
