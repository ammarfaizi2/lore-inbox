Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSATEaz>; Sat, 19 Jan 2002 23:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSATEaq>; Sat, 19 Jan 2002 23:30:46 -0500
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:53730 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287948AbSATEad>; Sat, 19 Jan 2002 23:30:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 15:24:51 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120043033.TXUB9511.femail23.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 January 2002 10:21 am, Horst von Brand wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> said:
>
> [...]
>
> > It results in:
> >
> > link("/proc/self/fd/3", "flink-test2.txt") = -1 EXDEV (Invalid
> > cross-device lin k)
> >
> > This is probably because link() doesn't look up the target of the
> > symlink, it links the symlink itself. Linux allows symlinks with
> > a nlink count of 2:
> >
> > % ln -s a b
> > % ln b c
> > ln: `b': warning: making a hard link to a symbolic link is not portable
> > % ls -l
> > lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 b -> a
> > lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 c -> a
> >
> > This could be hacked around ofcourse in fs/namei.c, so I tried
> > it for fun. And indeed, with a minor correction it works:
> >
> > % perl flink.pl
> > Success.
> >
> > I now have a flink-test2.txt file. That is pretty cool ;)
>
> This is a possible security risk: The unlinking program thinks the file is
> forever inaccessible, but it isn't...

It's only accessable to the same user.  (permissions 700 in /proc/blah/fs.)  
If you're running at the same user, you can attach a debugger to the process 
and look at anything it's got.  So it's just an easier way to do something 
you could effectively already do anyway...

Rob
