Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTEUN20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTEUN20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:28:26 -0400
Received: from stine.vestdata.no ([195.204.68.10]:4576 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id S262093AbTEUN2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:28:23 -0400
Date: Wed, 21 May 2003 15:41:20 +0200
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: "Michael S. Peek" <peek@tiem.utk.edu>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       peek@vger.kernel.org
Subject: Re: Questions about LARGE, RAID storage under Linux
Message-ID: <20030521134120.GQ7706@vestdata.no>
References: <S263852AbTETQCk/20030520160240Z+2889@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <S263852AbTETQCk/20030520160240Z+2889@vger.kernel.org>
User-Agent: Mutt/1.5.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 12:15:39PM -0400, Michael S. Peek wrote:
> I am looking at using a hardware RAID device that appears to it's SCSI host as
> a single large drive.  I am well aware that I can break this device down into
> multiple LUNS, but if possible I need to keep it as one big drive.  I
> understand from the Linux Info Sheet, last updated in 1998 according to it's
> text, that Linux is able to handle partitions up to 4TB in size.

What is the Linux Info Sheet?

AFAIK linux has never had a partition-limit of 4 TB.
There is a limit in any block-device of 2^32 sectors, typically 2 TB.
Some drivers may have sign-issues, leaving you with only 2^31 sectors (1
TB).


> What I want to know is:
> 
> (a) Is 4TB still the maximum limitation on a single partition size?  If not,
> what is the current maximum?
> 
> (b) Would this maximum partition size still apply when using the software RAID
> tools to combine two or more of these devices together?

I believe the 2.4 kernel is still limited to 2 TB for both scsi-devices
and virtual block-devices such as md or lvm.

I think 2.5 has an option added for large block devices. This should
allow you to use both scsi-devices and md virtual devices larger than
2TB. It may depend on changes in the actual scsi-drivers, so possible it
only works for a subset of scsi-adapters. Last time I checked it didn't
enable larger LVM-volumes, so you're limited to md for virtual devices.

> What I am looking for is the ability to mount and format an external SCSI
> device that's 3.5TB in size.  (It's a Promise UltraTrak RM1500 w/ 15 x 250GB
> drives).  I want to be able to upgrade the hard drives at a later date and
> know that the Linux box to which it is attached will still be able to handle
> them.  Ideally, I would like to purchase a second (or even a third) device
> later down the road and use software RAID to concatenate them together.

I think you would want to use LVM to concatenate them together, and
AFAIK that is not yet possible. There is work in progress though.

I think your best chances of making this work in the future without
having to reformat your system is to use LVM2 with a large physical
extentsize from the start.


My information may be out of date, so take this with a grain of salt.


-- 
Ragnar Kjørstad
Zet.no
