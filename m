Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbTCWAvf>; Sat, 22 Mar 2003 19:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTCWAvf>; Sat, 22 Mar 2003 19:51:35 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30637 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262187AbTCWAvd>; Sat, 22 Mar 2003 19:51:33 -0500
Date: Sun, 23 Mar 2003 02:03:39 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
Message-ID: <20030323010338.GA886@brodo.de>
References: <20030322140337.GA1193@brodo.de> <1048350905.9219.1.camel@irongate.swansea.linux.org.uk> <20030322162502.GA870@brodo.de> <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 05:42:02PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 16:25, Dominik Brodowski wrote:
> > > Where is the lock, what does the NMI oopser show ?
> > 
> > The lock is directly "below" that line -- and the NMI oopser isn't
> > triggered, AFAICT
> 
> Anything useful off right-alt scroll-lock etc ?

not from this debugging source - USB wireless keyboard :) - however, ~1000
printks later I've found out the following: the kernel spins in the while()
loop in drivers/ide/ide_register_driver:

	while (!list_empty(&list)) {
		ide_drive_t *drive = list_entry(list.next, ide_drive_t,
list);
		list_del_init(&drive->list);
		if (drive->present)
			ata_attach(drive);
	}


It was called by ide_register_driver, which itself got called by
idedisk_init. 

	Dominik
