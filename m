Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUAYS5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUAYS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:57:09 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12508 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265170AbUAYS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:57:02 -0500
Date: Sun, 25 Jan 2004 19:56:58 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle disks? (to allow spin-downs)
Message-ID: <20040125185658.GA27397@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40140B0A.90707@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40140B0A.90707@isg.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Lutz Vieweg wrote:

> I run a server that usually doesn't have to do anything on the local
> filesystems, it just needs to answer some requests and perform some
> computations in RAM.
> 
> So I use the "hdparm -S 123" parameter setting to keep the (IDE)
> system disk from spinning unneccessarily.
> 
> Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot
> find a way to let the harddisk spin down - I found out that
> "kjournald" writes a few blocks every few seconds.
> 
> As I wouldn't like to downgrade to ext2: Is there any way to keep the
> 2.6 kjournald from writing to idle disks?
> 
> I cannot see a good reason why kjournald would write when there are no
> dirty buffers - but still it does.

I can spin down my "extra" hard drives just fine with 2.6; I have a
"hde" drive (IBM DTLA, a wonder it's still alive, it's just a cache disk
however, no valuable data on it) attached to a Promise PDC 20265R which
has one large ext3fs partition, /dev/hde1, across the whole disk, which
will sit idle for ages, without spinning up. I have another IDE harddisk
with just reiserfs and vfat, it stays in standby as well. The third IDE
harddisk is so quiet I can't tell, without asking hdparm -C, whether it
is up, and I do not really care, but it seems it stays in standby as
well.

So the question is, do you run stuff that marks blocks dirty regularly?
atime updates? Does mounting ALL the partition (including root) with
option "noatime" help, policy and applications permitting?

Another thing I find very annoying however: whenever a disk writes the
last dirty block and is in a known-good shape, it should mark its state
as "clean" so it doesn't need to be spun up just to change the
superblock from "not clean" to "clean" when the computer is shut down
and the FS is umounted. The first action when touching the disk would
then mark the fs "not clean" until after the last fs was marked "clean".

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
