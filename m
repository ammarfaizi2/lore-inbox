Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUDFSqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUDFSqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:46:02 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:16327 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S263950AbUDFSp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:45:58 -0400
Date: Tue, 6 Apr 2004 14:45:57 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Stupid question re: register_cdrom()
In-Reply-To: <20040405230351.GR3445@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.33L2.0404061445020.21665-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Tony Breeds wrote:

> On Mon, Apr 05, 2004 at 04:53:16PM -0400, Calin A. Culianu wrote:
> >
> > Let's say I was coding a cdrom emulator in software for kernel 2.4.  I
> > am unclear about register_cdrom().  Does register_cdrom() in
> > cdrom.c take care of telling the kernel that my kdev_t major/minor
> > combination in fact leads to a real driver?  Or do I need to take care of
> > that outside of regsiter_cdrom()?
> >
> > If not.. how do I tell the kernel data structures that my driver's major
> > number does in fact point to a cdrom driver.  Basically, I want my
> > driver's major number to show up in /proc/devices..
> >
> > This might be a stupid question, but I am not a linux kernel expert...
>
> Neither am I, therefore I hope you get a reply from someone else
> refuting or acknowledging my claims.
>
>
> I looks to me that the code that does the actual registration of the
> driver is in drivers/ide/ide-cd.c NOT cdrom.c.  Specifically
> ide_cdrom_attach().  Said function eventually calls the register_cdrom()
> you ask about.
>
> For writing a cdrom emulator  You may want to look more closely at the
> non-IDE/SCSI devices as they seem to register their driver data
> themselves  I had a quick read of aztcd.c, I think between cdrom.c and
> aztcd.c you should be able to piece together what you want.
>
> Also Try reading http://www.xml.com/ldd/chapter/book/ for details on 2.4
> drivers

FYI --

It turns out that you need to either call devfs_register_blkdev, or plain
old register_blkdev in the non-devfs codepath.  :)


Thanks a ton for giving me the advice to read other drivers.  That's what
did it! :)

-Calin

