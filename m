Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSGVVTk>; Mon, 22 Jul 2002 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSGVVTk>; Mon, 22 Jul 2002 17:19:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:57526 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317814AbSGVVTi>; Mon, 22 Jul 2002 17:19:38 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roe Peterson <roe@liveglobalbid.com>
Date: Tue, 23 Jul 2002 07:22:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15676.30628.139373.965937@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.27 raid1 bug...
In-Reply-To: message from Roe Peterson on Monday July 22
References: <3D3C4DA7.5DC4550C@liveglobalbid.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 22, roe@liveglobalbid.com wrote:
> 
> Okay, I've isolated a problem with raid1/md under 2.5.27...
> 
> Scenario:
> 
>     /dev/hda2 and /dev/hdb2 are unused partitions.
> 
> /etc/raidtab:
> raiddev  /dev/md0
> raid-level 1
> nr-raid-disks 2
> chunk-size 64k
> persistent-superblock 1
> nr-spare-disks 0
>  device /dev/hda2
>  raid-disk 0
>  device /dev/hdb2
>  raid-disk 1
> 
> mkraid /dev/md0
> 
> Fails with a kernel panic.  A bit of searching finds that this chunk of
> code (md.c, about line 850):
>      rdev = list_entry(&mddev->disks.next, mdk_rdev_t, same_set);
                         ^
>      sb = rdev->sb;
> 
>      memset(sb, 0, sizeof(*sb));
> 
> Is failing.  sb is == 1 !!
> 
> Anyone got any ideas?

Yep, that '&' is wrong.  Remove and it will work.

NeilBrown
