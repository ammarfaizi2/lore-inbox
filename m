Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVEEO5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVEEO5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVEEO5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:57:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14740 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262124AbVEEO5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:57:39 -0400
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e050505051360d0588c@mail.gmail.com>
References: <20050505004854.GA16550@animx.eu.org>
	 <58cb370e050505031041c2c164@mail.gmail.com>
	 <20050505111324.GA17223@animx.eu.org>
	 <58cb370e050505051360d0588c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115304977.23360.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 15:56:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-05-05 at 13:13, Bartlomiej Zolnierkiewicz wrote:
> Please be aware that new applications are expected to use
> /sys/firmware/edd/default_* instead of legacy HDIO_GETGEO ioctl
> and there is currently no way to set these sysfs entries (maybe it
> would be worthwile to add such functionality?).

Please be aware that edd is platform specific, buggy and dependant on
firmware features that many machines don't have. Don't use the EDD data
its junk. Bartlomiej's advice isn't something I'd agree with on this
point.

The fundamental issue behind all this though and the problem with
HDIO_GETGEO and friends is that geometry is basically a convenient
fiction for legacy software that needs an answer and apps that interact
with it.

For PC type systems you actually want to go and look at the partition
table itself and then follow that if one exists. If it doesn't exist
then you are in firmware magic land and you need to look at the drive's
current geometry reporting as well as the BIOS CMOS data, EDD on the
boxes that have it, openprom etc and so forth. Or better yet look at
parted and at least keep all the crap in one place.

Alan

