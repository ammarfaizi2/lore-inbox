Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSFNWaC>; Fri, 14 Jun 2002 18:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSFNWaB>; Fri, 14 Jun 2002 18:30:01 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:36364 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S314551AbSFNWaB>;
	Fri, 14 Jun 2002 18:30:01 -0400
Date: Fri, 14 Jun 2002 17:30:01 -0500 (CDT)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@abbey.hauschen
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: File permission problem with NFSv3 and 2.5.20-dj4
In-Reply-To: <Pine.LNX.4.33.0202072243560.26015-100000@Appserv.suse.de>
Message-ID: <20020614171820.A13031-100000@abbey.hauschen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Looks like there is a problem with NFSv3 and file permissions in the DJ
kernels.

A file that is marked as executable will lose its executable flag whenever
it is written to. I suspect the proble lies in the changes to the NFS file
info cacheing in the DJ kernels at least since 2.5.20-dj1 (I was unable
to find where this change occured in the changelog).

Here is one example:

 Enter NFS mount (in this case, the NFS server is a FreeBSD 4.6 machine)
 Compile a simple program; gcc hello.c -o hello
 Result: hello has the following permissions: -rw-r--r--
 Modify the permissions manually; chmod 755 hello
 Result: hello has the following permissions: -rwxr-xr-x

Here is another:

 Enter NFS mount
 Compile a simple program; gcc hello.c -o hello
 Result: hello has the following permissions: -rw-r--r--
 Unmount the NFS mount; umount /home
 Remount the NFS mount; mount server:/home /home
 Result: hello has the following permissions: -rwxr-xr-x

Here is the final one:

 Enter NFS mount, find a file with executable permissions;
 Edit a file; vi whahoo.sh
 Save and close the file
 Results: file has the following permissions: -rw-r--r--

So, in the process of writing a file, its executable bits are lost. Can
someone help? The problem is not present with vanilla Linux-2.5.20.

Regards,
 - Brent Cook

