Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbTCWOYZ>; Sun, 23 Mar 2003 09:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbTCWOYZ>; Sun, 23 Mar 2003 09:24:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47522
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263086AbTCWOYW>; Sun, 23 Mar 2003 09:24:22 -0500
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20030323010338.GA886@brodo.de>
References: <20030322140337.GA1193@brodo.de>
	 <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
	 <20030322162502.GA870@brodo.de>
	 <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
	 <20030323010338.GA886@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:47:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 01:03, Dominik Brodowski wrote:
> 	while (!list_empty(&list)) {
> 		ide_drive_t *drive = list_entry(list.next, ide_drive_t,
> list);
> 		list_del_init(&drive->list);
> 		if (drive->present)
> 			ata_attach(drive);

Can you boot and printk the drive name out each iteration see if the list
is hosed somewhere.

list is the list of all the drives. We pull the drive off the list
and attach it to the relevant device driver (or ide-default if none
is known).

The behaviour you see certainly sounds like the list got corrupted

