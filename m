Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268892AbRG0QuT>; Fri, 27 Jul 2001 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268893AbRG0QuB>; Fri, 27 Jul 2001 12:50:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268891AbRG0Qts>; Fri, 27 Jul 2001 12:49:48 -0400
Subject: Re: ext3-2.4-0.9.4
To: leg+@andrew.cmu.edu (Lawrence Greenfield)
Date: Fri, 27 Jul 2001 17:50:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Lawrence Greenfield" at Jul 27, 2001 12:24:56 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QAon-00061p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> This sort of attitude is just ridiculous.  Unix had a defined set of
> semantics.  This might have been stupid semantics, but it had them.

The unix defined semantics are very simple and very clear. They btw
dont contain the guarantees that certain email system authors think they do
and they never have.

rename() itself is new as of 4BSD, rather than ever being in true unix.
True unix did the right thing. It said 'this problem is hard, this problem
is application specific, do it at application level'.

> When I contacted the Linux JFS team about the semantics of link(), I
> was told that there is _no way_ of forcing a link() to disk.  Not an
> fsync() on the file, not an fsync() on the directory, just _not
> possible_.

I would expect an fsync of the directory to do that. It does on other
Linux file systems so it violates the least suprise bit. Right now JFS
isnt a standard file system on Linux however, and they have much left to do.
I suspect its something to ask them about.

> Thus why all reasonably paranoid MTAs and other mail programs say "use
> chattr +S on ext2"---we need ordered metadata writes.

And then your IDE disk gets you anyway. Also if you write metadata first 
then you risk delivering email to the wrong person instead. 

> You want to help performance?  Give us an fsync() that works on
> multiple file descriptors at once, or an async fsync() call.  Don't
> make us fight the OS on getting data to disk.

And what pray does an asynchronous fsync do. It seems to be a nop to me.

Doing reliabile transactions on disk is a hard problem. That is why oracle
and friends have spent many man years of research on this kind of problem. 
Current unix mailers do the smoke mirrors and prayer bit to reduce the
probability a little that is all, regardless of fs and os.

Alan
