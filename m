Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSAZEeL>; Fri, 25 Jan 2002 23:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289020AbSAZEdz>; Fri, 25 Jan 2002 23:33:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34025 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289017AbSAZEdu>;
	Fri, 25 Jan 2002 23:33:50 -0500
Date: Fri, 25 Jan 2002 23:33:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Dan Maas <dmaas@dcine.com>, Andreas Schwab <schwab@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <20020126034559.G5730@kushida.apsleyroad.org>
Message-ID: <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jan 2002, Jamie Lokier wrote:

> I once wrote a Perl script that needed to know the current directory.
> It did:
> 
>    use POSIX 'getcwd'
>    getcwd(...)
> 
> After a few months, I was annoyed by the slowness of this script
> (compared with other scripts) and decided to try speeding it up.  It
> turns out that the above two lines took about 0.25 of a second, and that
> was the dominant running time of the script.
> 
> I replaced getcwd() with `/bin/pwd`.  Lo!  It took about 0.0075 second.
> 
> Says very good things about Linux' fork, exec and mmap times, and about
> Glibc's dynamic loading time, I think.

Most likely it says very bad things about getcwd() implementation in Perl
compared to sys_getcwd() in the kernel.  The latter just walks the chain
of dentries copying ->d_name.name into the buffer.  The former... my guess
would be stat ".", open "..", readdir from it, stat every damn object in
there until you find one with the right ->st_ino, put its name as the
last component and repeat the whole thing until you reach root...

