Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVIJXoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVIJXoW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVIJXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:44:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46486 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932385AbVIJXoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:44:20 -0400
Message-ID: <43236FD2.6010501@pobox.com>
Date: Sat, 10 Sep 2005 19:44:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <20050910153110.36a44eba.akpm@osdl.org> <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 10 Sep 2005, Andrew Morton wrote:
> 
>>Who do I bug about these longstanding ppc64 warnings, btw ;)
>>
>>drivers/scsi/sata_svw.c: In function `k2_sata_tf_load':
>>drivers/scsi/sata_svw.c:111: warning: passing arg 2 of `eeh_writeb' makes pointer from integer without a cast
>>drivers/scsi/sata_svw.c:116: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast
>>drivers/scsi/sata_svw.c:117: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast

> I used to have a patch to fix them, and sent it to Jeff ages ago. At that 
> point, he didn't want to use the iomap() functionality, but maybe that has 
> changed.
> 
> Jeff? It requires making almost all the SATA IO base pointers be iomapped: 
> the current

Glad you two asked!  :)

I -do- want to use iomap.  The problem is that no one has yet come up 
with a few that does all the proper resource reservation.  Everybody 
(including myself) did the ioread/iowrite part, but gave up before 
handling all cases of (a) legacy ISA iomap, (b) native PCI IDE iomap, 
and (c) non-standard MMIO iomap.

This "works, but leaks resources" code exists in the 'iomap' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

It languished in this incomplete stage for a while, but very recently 
got moving again:

> commit 374b1873571bf80dc0c1fcceaaad067980f3b9de
> Author: Jeff Garzik <jgarzik@pobox.com>
> Date:   Tue Aug 30 05:42:52 2005 -0400
> 
>     [libata] update several drivers to use pci_iomap()/pci_iounmap()

I actually made a promise to use iomap, since libata will benefit quite 
a bit from ioread/iowrite usage.  I intend to keep that promise... it's 
just taking me a while to get us there.  Now that I figured out the path 
I want to take, we should get there around 2.6.1[56].

	Jeff


