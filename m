Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130226AbRBUW1I>; Wed, 21 Feb 2001 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbRBUW07>; Wed, 21 Feb 2001 17:26:59 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:52238 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129842AbRBUW0n>; Wed, 21 Feb 2001 17:26:43 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: rayn <Wilfried.Weissmann@gmx.at>
Date: Thu, 22 Feb 2001 09:26:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.16520.832011.18@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: partitions for RAID volumes?
In-Reply-To: message from rayn on Wednesday February 21
In-Reply-To: <3A942AEC.4004DA3F@gmx.at>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 21, Wilfried.Weissmann@gmx.at wrote:
> Hi,
> 
> Is there any chance that RAID volumes would support partitions like the
> hard-disk driver in the future? 

Yep.
See: http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2-pre4/

You would need patches H,I,N,O,P,Q,R,  and you should consider this a
very early release, but it works for me.
It uses a second major device number for partitioned md arrays. You
can only partition the first 16 arrays (md0 - md15) and only have 15
partitions per array.  It wont work well for raid5, but for raid1
(which is what I particularly want) or raid0 it should be fine.

Using this, I can RAID1 hda and hdc together as md0 == mda and then
partition it up as mda1 (root) mda2 (swap) mda3 (other).  And if I
have too, I can boot off either drive individually with any raid
happening.

Lilo needs to be hacked a bit to do the right thing, and I have got a
major number officially allocated from lanana, but as I said, this is
a very early release.

NeilBrown
