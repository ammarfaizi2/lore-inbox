Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTKIL7B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKIL7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:59:01 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:25348 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262375AbTKIL67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:58:59 -0500
Date: Sun, 9 Nov 2003 12:58:57 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031109115857.GA15484@win.tue.nl>
References: <20031109011205.GA21914%konsti@ludenkalle.de> <20031109023625.GA15392@win.tue.nl> <20031109034940.GA8532@zappa.doom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031109034940.GA8532@zappa.doom>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 04:49:40AM +0100, Konstantin Kletschke wrote:
> * Andries Brouwer <aebr@win.tue.nl> [Sun, Nov 09, 2003 at 03:36:25AM +0100]:
> 
> > > hda: hda hda2
> > 
> > I suppose that second hda is a typo for hda1?
> 
> Yes ;)
> 
> > What partition table? (fdisk -l /dev/hda or sfdisk -l -x -uS /dev/hda)
> 
> 	 Disk /dev/hda: 255 heads, 63 sectors, 1245 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       365   2931831   83  Linux
> /dev/hda2           366      1245   7068600    5  Extended
> /dev/hda5           366       487    979933+  83  Linux
> /dev/hda6          1185      1245    489951   82  Linux swap

Hmm. msdos.c has

                        put_partition(state, slot, start, size == 1 ? 1 : 2);
                        printk(" <");
                        parse_extended(state, bdev, start, size);
                        printk(" >");

The "hda2" is printed by put_partition(). But no " <" is printed.
An impossible error. Recompile your kernel.

Andries


[If a clean compile still fails, add
	printk("partition start %u size %u type %u",
		start, size, SYS_IND(p))
after the
        for (slot = 1 ; slot <= 4 ; slot++, p++) {
                u32 start = START_SECT(p)*sector_size;
                u32 size = NR_SECTS(p)*sector_size;
around line 413 in fs/partitions/msdos.c.]



