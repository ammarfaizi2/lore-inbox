Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbSAMPCB>; Sun, 13 Jan 2002 10:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSAMPBv>; Sun, 13 Jan 2002 10:01:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23559 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285134AbSAMPBn>; Sun, 13 Jan 2002 10:01:43 -0500
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
To: matthew@hairy.beasts.org (Matthew Kirkwood)
Date: Sun, 13 Jan 2002 15:13:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        manfred@colorfullife.com (Manfred Spraul),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201131216230.24442-100000@sphinx.mythic-beasts.com> from "Matthew Kirkwood" at Jan 13, 2002 12:38:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PmKA-0007BS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, that'd be fine.  However, you then lose the neatness
> of "lock==file descriptor", and need something other than
> read/write for down/up.

If I have to have 2000 pages and 2000 file handles for 2000 locks I've
kind of lost interest. read/write syscalls take offsets. I can pread/pwrite
a lock in a set of locks. The only reason for using an fd I can see is so
you can poll on a lock. All the other neatness issues are wrapped in the
library support code anyway.

> I guess the alternative is to store them in a hash table
> or tree but I don't know what that would do to the
> contended case.

Read my old mail you need neither a hash table or a tree. You just need
the required shadow object

	offset = addr - vma->vm_start;
	offset /= sizeof(struct user_lock);
	lock = ((struct lock *)vma->vm_private_data)[offset];

Alan
