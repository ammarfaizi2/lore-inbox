Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUI0TcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUI0TcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUI0TcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:32:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14482 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267180AbUI0TcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:32:13 -0400
Date: Mon, 27 Sep 2004 21:31:32 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: micah milano <micaho@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andries Brouwer <andries.brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
Message-ID: <20040927193130.GC1398@apps.cwi.nl>
References: <70fda320409251214129bba57@mail.gmail.com> <70fda3204092514037c6dc039@mail.gmail.com> <58cb370e04092515157e9b72ef@mail.gmail.com> <20040926102937.GA27269@apps.cwi.nl> <58cb370e04092603596138133a@mail.gmail.com> <70fda32040927085019a5cd91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fda32040927085019a5cd91@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:50:23AM -0500, micah milano wrote:
> I agree that parted reports an error, however I think there is
> something else going on. When I run fdisk there is a different CHS
> reported for each disk, even though they are the same geometry.

A disk does not have a geometry, so two disks, even when identical
cannot be said to have the same geometry.

A geometry is a phantom, invented, depending on many parameters,
and one of them is the interface used. So, the same disk may get
different geometries on hdb and hdc.

See the FAQ http://www.win.tue.nl/~aeb/linux/Large-Disk-14.html#ss14.2
"14.2 Nonproblem: Identical disks have different geometry?"

> I can't partition the second disk to have the same partition sizes as
> the other disk because of this. I only mentioned parted because I was
> trying every partitioner there is.

Most existing partitioners allow you to specify your favourite
geometry.

> I was hoping someone might have a solution for how I can
> partition this second identical disk so it has identical partition
> sizing as the first so I can put software RAID mirroring on them. From
> what it sounds like you guys are saying (IANALKH) dmesg is reporting
> the wrong CHS, and parted has a fix for its error, but is there
> something I can do to get the partition sizing right?

No, it is entirely different. CHS is completely arbitrary and fake.
At least, as long as your disk is Linux only.
As soon as you use Windows on the same disk, you must be careful
to invent the same numbers that the BIOS will invent.

So, you think of some numbers - your birthday or so - and specify
the same numbers to fdisk while partitioning both disks.
Common numbers are S=63 and H=255. Don't specify C if you can avoid it.

Andries
