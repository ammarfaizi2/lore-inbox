Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbTDSL1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTDSL1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 07:27:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:60421 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263379AbTDSL1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 07:27:23 -0400
Date: Sat, 19 Apr 2003 13:39:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in ide_xlate_1024 in 2.5.67-ac2
Message-ID: <20030419113921.GA19740@win.tue.nl>
References: <qwwr87z1l8l.fsf@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwwr87z1l8l.fsf@decibel.fi.muni.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 12:42:02AM +0200, Petr Konecny wrote:

> I am getting the appended oops. It happens after I plug in USB storage
> device and sd_mod gets modprobed by hotplug. It checks partitions on the
> disk and oopses during that. It looks similar to the bug reported here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0302.2/1305.html

>  EIP is at ide_xlate_1024+0xbe/0x1f0
>  Call Trace:
>   [blkdev_readpage+0/32] blkdev_readpage+0x0/0x20
>   [handle_ide_mess+245/640] handle_ide_mess+0xf5/0x280
>   [msdos_partition+60/928] msdos_partition+0x3c/0x3a0

Yesterday I answered someone else with a similar oops:

The code

int ide_xlate_1024 (struct block_device *bdev, ...) {
        ide_drive_t *drive = bdev->bd_disk->private_data;

is just broken - there is no guarantee that bdev is an IDE disk, 
and casting some private pointer to ide_drive_t and then
accessing fields must be unhealthy.

Try replacing the body of ide_xlate_1024 by just

        return 0;

Andries

