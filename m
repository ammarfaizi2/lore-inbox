Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280774AbRKSXqb>; Mon, 19 Nov 2001 18:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280777AbRKSXqY>; Mon, 19 Nov 2001 18:46:24 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:58008 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280774AbRKSXpd>;
	Mon, 19 Nov 2001 18:45:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Rock Gordon <rockgordon@yahoo.com>
Subject: Re: Executing binaries on new filesystem
Date: Mon, 19 Nov 2001 15:45:20 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165y6K-00012D-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 08:34, Rock Gordon wrote:
> I don't think mmap is the problem; you don't need it
> in order to run binaries ...

Er... and what brings you to that assertion? Try cat'ing /proc/<pid>/maps on 
any program, and you'll see the program's binary in the maps list multiple 
times, including one executable map of the .code section. To use my current 
mail client as an example:

bodnar42:~$ pidof kmail
3905
bodnar42:~$ cat /proc/3905/maps
08048000-081b0000 r-xp 00000000 03:05 1209118    /usr/bin/kmail
081b0000-081bb000 rw-p 00167000 03:05 1209118    /usr/bin/kmail
081bb000-0863a000 rwxp 00000000 00:00 0
40000000-40014000 r-xp 00000000 03:05 1154       /lib/ld-2.2.4.so
40014000-40015000 rw-p 00013000 03:05 1154       /lib/ld-2.2.4.so
40015000-40016000 rwxp 00000000 00:00 0
40016000-4001c000 rw-p 00000000 00:00 0
4001d000-4001e000 rw-p 00007000 00:00 0
40022000-40203000 r-xp 00000000 03:05 442168     /usr/lib/libkhtml.so.3.0.0
40203000-40235000 rw-p 001e0000 03:05 442168     /usr/lib/libkhtml.so.3.0.0
...

Any sane ELF loader will use mmap() to both execute binaries and load shared 
libraries, and Linux's ELF loader is certainly no exception. I remember users 
not being able to run binaries (both Win32 and Linux/ELF) off of NTFS 
partitions, because the Linux NTFS driver did not implement mmap(). You'll 
probably have much better luck once you implement it on yours.

-Ryan
