Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTLHPeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbTLHPeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:34:06 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9186 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265421AbTLHPeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:34:01 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16340.39394.588507.612973@laputa.namesys.com>
Date: Mon, 8 Dec 2003 18:33:54 +0300
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect inode count on reiserfs
In-Reply-To: <slrnbt9322.27h.erik@bender.home.hensema.net>
References: <3FD47BFC.9020008@scssoft.com>
	<16340.33245.887082.96412@laputa.namesys.com>
	<slrnbt9322.27h.erik@bender.home.hensema.net>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema writes:
 > Nikita Danilov (Nikita@Namesys.COM) wrote:
 > > Petr Sebor writes:
 > > > I have noticed this behavior when moving the inn2 news server to 
 > > > 2.6.0-test11 kernel
 > > > from 2.4.23
 > > > (inn2 refuses to start because if free inode shortage)
 > 
 > [...]
 > 
 > > reiserfs has no fixed predefined number of inodes on the file
 > > system. Hence, field f_files of struct statfs (see man 2 statfs) is not
 > > applicable to this file system. Man page explicitly says:
 > > 
 > >        Fields that are undefined for a particular file system are
 > >        set  to  0.
 > > 
 > > Previous man page stated that file system should put -1 (4294967295)
 > > into undefined fields. Reiserfs has been changed to conform to the
 > > changed specification.
 > 
 > [...]
 > 
 > > Fix would really be simple: ignore test results if ->f_files is 0 or
 > > 0xffffffff.
 > 
 > But innwatch checks for a out-of-inodes condition. How can it differentiate
 > between a undefined number of inodes (field set to 0) and a system that ran
 > out of inodes (field dropped to 0)?
 > 
 > A '4294967295 inodes should be enough for anyone'-situation is preferable I
 > think.

This is messy, because we have both statfs and statfs64 and this would
lead to the overflow detection problems.

I don't know what is the best solution here. statfs(2) is just not very
good interface. It was obviously designed to serve ffs/ufs/ext2 type
file systems only.

Looking at the magic in f_type field, is ugly, but should work.

 > 
 > -- 
 > Erik Hensema <erik@hensema.net>

Nikita.
