Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTKJK4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 05:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTKJK4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 05:56:54 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:62725 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263137AbTKJK4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 05:56:52 -0500
Date: Mon, 10 Nov 2003 11:56:50 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031110105650.GA15743@win.tue.nl>
References: <20031110102444.GA8552@synertronixx3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110102444.GA8552@synertronixx3>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:24:44AM +0100, Konstantin Kletschke wrote:
> We have a new boot log at
> 
> http://ludenkalle.de/ide_change_kernel.txt
> 
> With CONFIG_BLK_DEV_IDEDISK=y but unset CONFIG_BLK_DEV_HD_IDE and the
> inserted (and no used) printk stuff.

Good. Now it really does partition reading.
At some later time we must come back and find out what is
wrong with hd.c. You call the printk stuff unused, but
it was used and printed

partition start 63 size 4096512 type 85 p1
partition start 4096575 size 15904350 type 85 p2
partition start 0 size 0 type 0
partition start 0 size 0 type 0                          

Let us compare with your data from earlier:

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       365   2931831   83  Linux
/dev/hda2           366      1245   7068600    5  Extended
/dev/hda5           366       487    979933+  83  Linux
/dev/hda6          1185      1245    489951   82  Linux swap

Clearly, you have EZDrive installed, the table below is what
is found in sector 1, the data printed above is what is in
sector 0. The tables differ - fdisk was used after installation
of EZDrive.

I suppose that booting with boot parameter "hda=remap" should work.
At some later time we must worry about how to get rid of EZDrive.

Andries

