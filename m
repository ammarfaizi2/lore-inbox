Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283501AbRLHSR1>; Sat, 8 Dec 2001 13:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283516AbRLHSRQ>; Sat, 8 Dec 2001 13:17:16 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:3017 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S283501AbRLHSRG>; Sat, 8 Dec 2001 13:17:06 -0500
Date: Sat, 8 Dec 2001 13:17:04 -0500
From: James Moss <moss@brutesquad.org>
To: linux-kernel@vger.kernel.org
Subject: fstat issues
Message-ID: <20011208181704.GA25104@acmeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed recently that the following no longer works.  I was wondering if
this is internal to the kernel or if perhaps this is a glibc issue.  Also
wondering if this was an intential change.  It did 'used to work' but I
realize that may hold little to no ground since it does seem to be on a per
implementation basis.  Anyway looking forward to hearing back, feel free to
show a better way to go about doing what I'm attempting to do.
     -James Moss

-------foo.c------------
#include <stdio.h>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <sys/errno.h>
#include <fcntl.h>

main(argc, argv)
int argc;
char **argv;
{
    struct stat sb;
    if (0 == fstat( fileno(stdin), &sb )) {
        printf( "size %d\n", sb.st_size );
    } else {
        printf( "size %d\n", sb.st_size );
    }
    exit( 0 );
}

-------------------
				    
On HP, Solaris, etc...
cc foo.c
echo "abc" > ftext.txt
./a.out < ftext.txt
size 4
cat ftext.txt | ./a.out
size 4
			    
On Debian Unstable, latest release of Suse, and latest release of Redhat...
gcc foo.c
echo "abc" > ftext.txt
./a.out < ftext.txt
size 4
cat ftext.txt | ./a.out
size 0

Page 90, 4.12 "File Size"
Advanced Programming in the UNIX Environment states that it's posix compliant
in SVR4 to have the ability to read file size from a pipe and the st_size of
the sb struct is defined.... does Linux break SVR4 compliance?  Is there a
better or new way to do this?

SVID Vol: 1a Version 4

Since a pipe is bi-directional, there are two separate flows of data.
Therefore, the size (st_size) returned by a call to fstat with argument
fildes[0] or fildes[1] is the number of bytes available for reading from
fildes[0] or fildes[1] respectively.

FINAL COPY
June 15, 1995
File: ba_os/pipe
svid
Page: 219
