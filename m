Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSFQVqH>; Mon, 17 Jun 2002 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSFQVqG>; Mon, 17 Jun 2002 17:46:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25051 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317037AbSFQVqF>; Mon, 17 Jun 2002 17:46:05 -0400
Date: Mon, 17 Jun 2002 17:46:05 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206172146.g5HLk5a29878@devserv.devel.redhat.com>
To: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] 2.5.22: ibm partition support.
In-Reply-To: <mailman.1024345981.31841.linux-kernel2news@redhat.com>
References: <mailman.1024345981.31841.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> another resend of the partition patch for ibm.c. Nobody sent a veto so far
> so please add it.

I suspect Linus wants it fixed "right", as we promised.
I made the kludge with genhd_dasd_ioctl because Red Hat
need to ship _something_ working while passing Viro approval.
I never intended it to be applied to 2.5.

Remember that what Al did first _almost_ worked. The recursion
happened because the SCSI code was so insanely convoluted,
and only for SCSI removables. Perhaps it may be doable to
fix that instead. Also I am thinking about special-casing
the minor 0 and make it open without partition probing;
then the probing happens on top of pre-opened minor 0
and spawns other minors. That should be good and proper.

The bad part is that the real fix for old broken ibm.c partitioning
is now a hostage of resolution of ioctl-during-partitioning
problem. I see no easy way to resolve it, it has to wait.
Good thing my Hercules uses FBAs :)

-- Pete
