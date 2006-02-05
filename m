Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWBER0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWBER0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 12:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWBER0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 12:26:31 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:27847 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751244AbWBER0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 12:26:30 -0500
Date: Sun, 05 Feb 2006 12:26:28 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: Re: 2.6.15-mm3 hang with raid-1
In-reply-to: <20060205001424.0577ba83.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Reply-to: ebuddington@wesleyan.edu
Message-id: <20060205172628.GA1132@pool-70-109-243-235.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <20060202143623.GC1188@pool-71-123-118-13.spfdma.east.verizon.net>
 <20060205001424.0577ba83.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 12:14:24AM -0800, Andrew Morton wrote:
> Eric Buddington <ebuddington@verizon.net> wrote:
> >
> > Running 2.6.15-mm3 PREEMPT on an Athlon XP, Asus motherboard with
> > VT8366/A/7 chipset.
> > 
> > I have a 240GB raid0 on hda3 and hdc1 containing a reiser3
> > filesystem. It works fine.
> > 
> > I have a 40GB raid1 on hda2 and hdd1, which is giving me problems. I
> > can write to all of hda2 and hdd1 (before creating the array) without
> > error, and mdadm seems to create the array all right.
> > 
> > However, just after the array finishes synchronizing (either after
> > creation or messy reboot), all new commands hang (I can still type at
> > existing shells, but as soon as I try to run a program, it becomes
> > unresponsive). While hung, disk activity light is off. On reboot, the
> > array is detected as clean, no synchronization is done, and my system
> > works (until I try to use the raid1 array).
> > 
> > mkreiserfs /dev/md0 also causes the hang, when it syscalls fsync().
> > 
> > My system disk is hda1, so I don't know if all disks are hung up, or
> > just all of hda.
> > 
> > I'm doing all this at the console, and I see no error messages.
> > 
> > The computer keeps performing NAT, and alt-sysrq-b works.
> > 
> > What can I do to fix or help debug this problem?
> > 
> 
> Could you test -mm5 please?

using 2.6.16-rc1-mm5:
	- creation of reiserfs on resyncing raid1 works.
	- resync completes without hanging the system.
	- creating of reiserfs on resynced raid1 works

Looks good - thanks!

-Eric
