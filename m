Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTDMPQE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDMPQD (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 11:16:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62382
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263538AbTDMPQC (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 11:16:02 -0400
Subject: Re: Benefits from computing physical IDE disk geometry?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timothy Miller <tmiller10@cfl.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
References: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050244174.24187.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Apr 2003 15:29:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-12 at 23:46, Timothy Miller wrote:
> Any good SCSI drive knows the physical geometry of the disk and can
> therefore optimally schedule reads and writes.  Although necessary features,
> like read queueing, are also available in the current SATA spec, I'm not
> sure most drives will implement it, at least not very well.

Some of them are in recent PATA and Jens Axboe implemented the TCQ for
IDE, but its all a bit limited right now

> So, what if one were to write a program which would perform a bunch of
> seek-time tests to estimate an IDE disk's physical geometry?  It could then
> make that information available to the kernel to use to reorder accesses
> more optimally.

Its a common misconception that a disk looks something like it did 15
years ago. Your ATA disk is basically an entire standalone computer 
running a small OS. The physical disk layout does not divide neatly 
into equal sized cylinders and some blocks may even be in suprising
places due to bad block sparing or anything else the drive manufacturer
felt appropriate.

The drive firmware will look after a lot of the optimising for you,
and once it gets TCQ it will probably get you all you want from SCSI
with SATA. Until then playing games with it isnt likely to help - feed
IDE disks large, sequential I/O as much as possible and they'll deliver
you very nice numbers. 

Alan

