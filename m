Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277255AbRJLGXW>; Fri, 12 Oct 2001 02:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277252AbRJLGXC>; Fri, 12 Oct 2001 02:23:02 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62062 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277247AbRJLGWv>; Fri, 12 Oct 2001 02:22:51 -0400
Date: Fri, 12 Oct 2001 02:23:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: <gaby@applianceware.com>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for Multiple Device driver - md.c (kernel 2.4.12)
In-Reply-To: <Pine.LNX.4.33.0110111801490.1143-100000@gaby.applianceware.com>
Message-ID: <Pine.LNX.4.33.0110120220290.7954-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Oct 2001 gaby@applianceware.com wrote:

> Suppose you can hot-swap a hard disk in a system. Now if you have a
> degraded Software RAID device (for example a RAID-5 with one disk
> failed) and you replace the failed disk on-the-fly you cannot start
> reconstruction (with raidhotadd) of the Software RAID device with the
> replaced disk because it says it is BUSY.

this is possible already: you should first raidhotremove the failed drive,
then raidhotadd the new drive. It can be the 'same' drive if it's a
hot-swap disk, or it can be another, spare disk.

> +	if (rdev && rdev->faulty) {
> +		err = hot_remove_disk(mddev, dev);

what your patch does is a forced remove of any drive that is
raidhotadd-ed. This is less finegrained than the current solution, and
might make the method more volatile. (easier to mess up accidentally.) Is
there anything your patch allows that is not possible today, via
raidhotremove+raidhotadd?

	Ingo

