Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUFINPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUFINPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUFINOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:14:30 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:57032 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265786AbUFINLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:11:49 -0400
Message-ID: <55780.67.8.218.172.1086786707.squirrel@webmail.krabbendam.net>
In-Reply-To: <40C6E07C.6060609@serice.net>
References: <40BD2841.2050509@serice.net>
    <54574.67.8.218.172.1086758675.squirrel@webmail.krabbendam.net>
    <40C6E07C.6060609@serice.net>
Date: Wed, 9 Jun 2004 09:11:47 -0400 (EDT)
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
From: "Eric Lammerts" <eric@lammerts.org>
To: "Paul Serice" <paul@serice.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The second line of reasoning is that I do not know of any other common
> use of inode numbers in user space, and while posix says inode numbers
> shall be unique, BSD (at least NetBSD) appears to me to assign
> non-unique inode numbers for files by returning the lower 32 bits of
> the byte offset.

Tar uses inode numbers to determine which files are hardlinked. So if you
tar up a tree containing 0-byte files, then untar it somewhere, all 0-byte
files will end up being hardlinked to each other. The same happens when you
use cp -a.

> In conclusion, I just don't see much long-term difference in any of
> the inode numbering schemes, and the advantage of the scheme in my
> patch is that directories should always have unique inode numbers
> which to me is the important case.

Or take a hybrid approach: use your scheme for directories and my scheme for
files; use bit 0 or bit 31 to indicate what scheme is used. Then directories
have unique inode numbers, and files too as long as their directory records
are in the first 64Gb of the disc.

Eric

