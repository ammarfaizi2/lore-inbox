Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSASPVi>; Sat, 19 Jan 2002 10:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSASPVS>; Sat, 19 Jan 2002 10:21:18 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:17863 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286647AbSASPVJ>; Sat, 19 Jan 2002 10:21:09 -0500
Message-Id: <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: Message from Miquel van Smoorenburg <miquels@cistron.nl> 
   of "Sat, 19 Jan 2002 11:10:06 GMT." <a2bk6e$t2u$1@ncc1701.cistron.net> 
Date: Sat, 19 Jan 2002 16:21:01 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> said:

[...]

> It results in:
> 
> link("/proc/self/fd/3", "flink-test2.txt") = -1 EXDEV (Invalid cross-device lin
> k)
> 
> This is probably because link() doesn't look up the target of the
> symlink, it links the symlink itself. Linux allows symlinks with
> a nlink count of 2:
> 
> % ln -s a b
> % ln b c
> ln: `b': warning: making a hard link to a symbolic link is not portable
> % ls -l
> lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 b -> a
> lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 c -> a
> 
> This could be hacked around ofcourse in fs/namei.c, so I tried
> it for fun. And indeed, with a minor correction it works:
> 
> % perl flink.pl 
> Success.
> 
> I now have a flink-test2.txt file. That is pretty cool ;)

This is a possible security risk: The unlinking program thinks the file is
forever inaccessible, but it isn't...
-- 
Horst von Brand			     http://counter.li.org # 22616
