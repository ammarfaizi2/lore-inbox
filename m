Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTFAXkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 19:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbTFAXkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 19:40:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31440 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264765AbTFAXkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 19:40:09 -0400
Date: Mon, 2 Jun 2003 00:53:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: [FIX] Re: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Message-ID: <20030601235333.GN9502@parcelfarce.linux.theplanet.co.uk>
References: <200306012259.h51Mx2i14095@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306012259.h51Mx2i14095@freya.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 03:59:02PM -0700, Adam J. Richter wrote:
> 	Disk partition under linux-2.5.70-bk[56] systems with two
> IDE disks is broken.  Under these kernels, the first disk gets
> the partitioning of the second disk.  Reverting drivers/ide/ide.c
> to the 2.5.70-bk4 version makes the problem go away.

vi drivers/ide/ide.c -c'/drive->list.*driver->drives/s/list_add/&_tail/|x'

Now that we use idedefault_driver.drives instead of ata_unused, the order
of drives on the driver->drives becomes significant; note that when we added
to ata_unused, we had done that to the end of list.
