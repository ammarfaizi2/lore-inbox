Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRELOSZ>; Sat, 12 May 2001 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261255AbRELOSF>; Sat, 12 May 2001 10:18:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261254AbRELOSC>; Sat, 12 May 2001 10:18:02 -0400
Subject: Re: Ext2, fsync() and MTA's?
To: andrewm@connect.com.au (Andrew McNamara)
Date: Sat, 12 May 2001 15:13:55 +0100 (BST)
Cc: tytso@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010512115034.A6245285B9@wawura.off.connect.com.au> from "Andrew McNamara" at May 12, 2001 09:50:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ya9b-0004Bc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Under Linux, the Postfix MTA sets "chattr +S" on it's spool directories
> - obviously this hurts it's performance badly (compared to the BSD's).

Not really. BSD directory updates are always synchronous in the cases postfix
cares about. At least on the old BSD FFS/UFS file systems. Thats the only
reason the postfix stuff doesnt need it on BSD.

> It would be really nice to be able to say it's no longer necessary. It
> wants to know that a file (file data, inode and directory entry) are
> commited to stable storage when an fsync returns.

fsync guarantees the inode data is up to date, fdatasync just the data. The
directory name SuS and posix dont cover or provide any method for guaranteeing.
The convention Linux adopted is that its valid to fsync() a directory file
handle. It seemed the logical abstraction.

Alan



