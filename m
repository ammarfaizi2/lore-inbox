Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbREBLef>; Wed, 2 May 2001 07:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbREBLeZ>; Wed, 2 May 2001 07:34:25 -0400
Received: from mx1.nameplanet.com ([213.203.30.51]:7434 "HELO
	mx1.nameplanet.com") by vger.kernel.org with SMTP
	id <S132760AbREBLeX>; Wed, 2 May 2001 07:34:23 -0400
Date: Wed, 2 May 2001 15:33:56 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
X-X-Sender: <ketil@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <lu01@rogge.yi.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Maximum files per Directory
In-Reply-To: <E14uhI2-0002NH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105021523100.1110-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Alan Cox wrote:

> > cyrus-imapd i ran into problems.
> > At about 2^15 files the filesystem gave up, telling me that there cannot be
> > more files in a directory.
> >
> > Is this a vfs-Issue or an ext2-issue?
>
> Bit of both. You exceeded the max link count, and your performance would have
> been abominable too. cyrus should be using heirarchies of directories for
> very large amounts of stuff.

That's not always best, is it? I've been testing a bit with reiserfs, and
with LOTS of files, I lose performance with a lot of directories compared
to putting all the files in one directory.

Of course, that is only read-performance. Write performance is enhanced
(at least when creating new files) by splitting this into some more
directories. So how you want to split this up depends whether your data is
write-many-read-once or write-once-read-many or something in between. That
is my experience with reiserfs, anyway.

Ketil

