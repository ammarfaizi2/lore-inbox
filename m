Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSFKGaE>; Tue, 11 Jun 2002 02:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSFKGaC>; Tue, 11 Jun 2002 02:30:02 -0400
Received: from zok.SGI.COM ([204.94.215.101]:56256 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316851AbSFKGaA>;
	Tue, 11 Jun 2002 02:30:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files 
In-Reply-To: Your message of "Mon, 10 Jun 2002 23:17:27 MST."
             <3D0595F7.A21AE62B@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 16:29:54 +1000
Message-ID: <11043.1023776994@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 23:17:27 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>Keith Owens wrote:
>> 
>> fd = open("foo", O_RDWR);
>> map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> ... modify the mapped pages ...
>> munmap(map, size);
>> close(fd);
>> 
>> The timestamp on foo is not updated, even though the contents have
>> changed.  Adding msync(map, size, MS_[A]SYNC) before munmap makes no
>> difference.  2.4.19-pre10 has no obvious fixes for this problem.

>What do the standards say?
>
>http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html
>
>     The st_ctime and st_mtime fields of a file that is mapped with MAP_SHARED
>     and PROT_WRITE shall be marked for update at some point in the interval
>     between a write reference to the mapped region and the next call to msync() with
>     MS_ASYNC or MS_SYNC for that portion of the file by any process. If there is
>     no such call and if the underlying file is modified as a result of a write reference,
>     then these fields shall be marked for update at some time after the write reference.

That says nothing about a file where the only updates are via mmap.  My
file had grown to its final size so there were no more writes, only
pages being dirtied via mmap.

