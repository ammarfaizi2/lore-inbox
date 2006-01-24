Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWAXP3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWAXP3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWAXP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:29:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19108 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964842AbWAXP3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:29:36 -0500
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <43D5CC88.9080207@comcast.net>
References: <43D5CC88.9080207@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 15:29:38 +0000
Message-Id: <1138116579.14675.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
> problem.  The problem is that there appears to be two nvidia/amd ata 
> drivers and I'm unsure which I should try using, if i compile both in, 
> which get loaded first (i assume scsi is second to ide) and if i want my 
> pata disks loaded under the new libata drivers, will my cdrom work under 
> them too, or do i still need some sort of regular ide drivers loaded 
> just for cdrom (to use native ata mode for recording access).  

The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
its entirity with code using the newer and cleaner libata logic. There
is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
are using libata and the additional patch patches still queued.

> 1.  Atapi is most definitely not supported by libata, right now.

It works in the -mm tree.

> 4.  moving to pata libata drivers _will_ change the enumeration of your 
> sata devices, it seems that pata is initialized first, so when setting 
> up your fstab entries and grub, you'll have to take into account how 
> many pata devices you have and offset your current sata device names by 
> that amount.

Or use labels. As you move into the world of hot pluggable hardware it
becomes more and more impractical to guarantee drive ordering by name.

You can mix and match the drivers providing you don't try and load both
libata and old ide drives for the same chip. Even then it should fail
correctly with one of them reporting resources unavailable.

In fact I do this all the time when debugging so I've got a stable disk
for debug work and a devel disk.

Alan

