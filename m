Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbREYJHA>; Fri, 25 May 2001 05:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263668AbREYJGk>; Fri, 25 May 2001 05:06:40 -0400
Received: from www.wen-online.de ([212.223.88.39]:11023 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263667AbREYJGk>;
	Fri, 25 May 2001 05:06:40 -0400
Date: Fri, 25 May 2001 11:06:14 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac17
In-Reply-To: <001d01c0e4dd$8f9cd7e0$53a6b3d0@Toshiba>
Message-ID: <Pine.LNX.4.33.0105251103440.241-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Jaswinder Singh wrote:

> Dear Mike ,
>
> >
> > This one I tested with memleak.  It wasn't a leak, it was dcache
> > growth.  Under vm stress, it shrank down fine.
> >
>
> It will depends upon lot of thing :-
> 1.What is your size of ramfs ,
unlimited.
> 2. Are you using any harddisk ,
(?? ramfs)  I think I misunderstand.
> 3. How many many files are you creating ,
lots of different names. (like you were)
> 4. How frequently you are making files .
as fast as a C proglet could create/maybe(random)access/destroy them.
> 5. What are the size of your files ?
varying from empty to small.
>
> In my case , my ramfs is of 14 MB , using no hard-disk , i am continously
> making and deleting files of 4 K size , my Machine hangs within 5 minutes ,
> by saying no memory left.

I can write random 4k files as fast and long as I like (with swap off)
and if I flush out the rather large dcache...

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  1      0  17600    104   4456   0   0   197     4  118    41   6  83  11
 1  0  0      0  14888    124   4476   0   0    31     0  123    37  13  87   0
 1  0  0      0  12252    124   4476   0   0     0     0  103     9  11  89   0
 1  0  0      0   9632    124   4476   0   0     0     0  105     7  17  83   0
 1  0  0      0   7032    124   4480   0   0     0     0  103    10  11  89   0
 1  0  0      0   4460    124   4476   0   0     0     0  101    10  12  88   0
 1  0  1      0  20272    128   4480   0   0     1     2  116    16  23  77   0
 1  0  0      0  17860    128   4480   0   0     0    15  115    10  17  83   0
 1  0  0      0  15196    128   4476   0   0     0     0  110     7  15  85   0
dentry_cache      747962 747990    128 24933 24933    1
dentry_cache      769651 769680    128 25656 25656    1
dentry_cache      792664 792690    128 26423 26423    1
dentry_cache      814779 814800    128 27160 27160    1
dentry_cache      835972 835980    128 27866 27866    1
dentry_cache      715148 715170    128 23839 23839    1

...afterward, I don't see leakage.  Only a short test this time, but
long enough to eat all of my ram many times over if it leaked as fast
as your description indicates.  I can't reproduce it. (2.4.4 btw)

> Please tell me about your system and what you are doing on it ?

Generic 128mb PIII/500.  What I was doing on it was beating up ramfs
looking for the leak you reported :)

	-Mike


