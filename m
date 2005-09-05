Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVIEB2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVIEB2A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 21:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVIEB2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 21:28:00 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:23459 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S932116AbVIEB17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 21:27:59 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Wilco Baan Hofman <wilco@baanhofman.nl>
Date: Mon, 5 Sep 2005 11:27:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17179.40731.907114.194935@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID1 ramdisk patch
In-Reply-To: message from Wilco Baan Hofman on Monday September 5
References: <431B9558.1070900@baanhofman.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 5, wilco@baanhofman.nl wrote:
> Hi all,
> 
> I have written a small patch for use with a HDD-backed ramdisk in the md 
> raid1 driver. The raid1 driver usually does read balancing on the disks, 
> but I feel that if it encounters a single ram disk in the array that 
> should be the preferred read disk. The application of this would be for 
> example a 2GB ram disk in raid1 with a 2GB partition, where the ram disk 
> is used for reading and both 'disks' used for writing.
> 
> Attached is a bit of code which checks for a ram-disk and sets it as 
> preferred disk. It also checks if the ram disk is in sync before 
> allowing the read.

Hi,
 equivalent functionality is now available in 2.6-mm and is referred
 to as 'write mostly'.
 If you use mdadm-2.0 and mark a device as --write-mostly, then all
 read requests will go to the other device(s) if possible,.
 e.g.
   mdadm --create /dev/md0 --level=1 --raid-disks=2 /dev/ramdisk \
      --writemostly /dev/realdisk

 Does this suit your needs?

 You can also arrange for the write to the writemostly device to be
 'write-behind' so that the filesystem doesn't wait for the write to
 complete.  This can reduce write-latency (though not increase write
 throughput) at a very small cost of reliability (if the RAM dies, the
 disk may not be 100% up-to-date).

NeilBrown

