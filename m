Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSASPds>; Sat, 19 Jan 2002 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbSASPdi>; Sat, 19 Jan 2002 10:33:38 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:31628 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S286750AbSASPdb>; Sat, 19 Jan 2002 10:33:31 -0500
Date: Sat, 19 Jan 2002 10:32:57 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.44.0201191030490.23101-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002, Horst von Brand wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> said:
> [...]
> > It results in:
> > link("/proc/self/fd/3", "flink-test2.txt") = -1 EXDEV (Invalid cross-device link)
> > This is probably because link() doesn't look up the target of the
> > symlink, it links the symlink itself. Linux allows symlinks with
> > a nlink count of 2:
> > % ln -s a b
> > % ln b c
> > ln: `b': warning: making a hard link to a symbolic link is not portable
> > % ls -l
> > lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 b -> a
> > lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 c -> a
> > This could be hacked around ofcourse in fs/namei.c, so I tried
> > it for fun. And indeed, with a minor correction it works:
> > % perl flink.pl
> > Success.
> > I now have a flink-test2.txt file. That is pretty cool ;)

> This is a possible security risk: The unlinking program thinks the file is
> forever inaccessible, but it isn't...
	Will the ability to access this linked file still be there  across
	a reboot ?  Or an fsck ?  Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

