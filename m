Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132221AbRAGNwa>; Sun, 7 Jan 2001 08:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRAGNwV>; Sun, 7 Jan 2001 08:52:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132221AbRAGNwK>; Sun, 7 Jan 2001 08:52:10 -0500
Subject: Re: Patch (repost): cramfs memory corruption fix
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sun, 7 Jan 2001 13:53:17 +0000 (GMT)
Cc: parsley@roanoke.edu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010106224109.A1601@adam.yggdrasil.com> from "Adam J. Richter" at Jan 06, 2001 10:41:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGG7-0002ff-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >ramfs croaks with 'kernel BUG in filemap.c line 2559' anytime I make a
> >file in ac2 and ac3.  Works fine in 2.4.0 vanilla.  Should be quite
> >repeatable...

I'll take a look at the ramfs one. I may have broken something else when fixing
everything else with ramfs (like unlink) crashing

> 	This sounds like a bug that I posted a fix for a long time ago.
> cramfs calls bforget on the superblock area, destroying that block of
> the ramdisk, even when the ramdisk does not contain a cramfs file system.
> Normally, bforget is called on block that really can be trashed,
> such as blocks release by truncate or unlink.  If it worked for
> you before, you were just getting lucky.  Here is the patch.
> 
> 	Linus, please consider applying this.  Thank you.

This isnt the fix. If -ac also fails well it contains this cramfs fix. So
there must be other problems

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
