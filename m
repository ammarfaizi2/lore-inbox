Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286859AbRLWJv5>; Sun, 23 Dec 2001 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286858AbRLWJvr>; Sun, 23 Dec 2001 04:51:47 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:38531 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S286856AbRLWJvh>;
	Sun, 23 Dec 2001 04:51:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
Date: Sun, 23 Dec 2001 01:51:27 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <3C25A06D.7030408@zytor.com>
In-Reply-To: <3C25A06D.7030408@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16I5Hz-0001ZJ-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 23, 2001 01:14, H. Peter Anvin wrote:
> It seems to me that this application doesn't really have a particular
> need for backward compatibility, nor for the I/O blocking stuff of
> tar/cpio.  I would certainly be willing to write a set of portable
> utilities to create an archive in a custom format, if that would be more
> desirable.  We'd still use gzip for compression, of course, and have the
> buffer composed as a combination of ".rfs" and ".rfs.gz" files,
> separated by zero-padding.
>
> What I'm talking about would probably still look a lot like the cpio
> header, but probably would use bigendian binary (bigendian because it
> allows the use of the widely portable htons() and htonl() macros), have
> explicit support for hard links, and not require a trailer block.

What about recycling a big-endian version of cramfs? IIRC, the format is 
really clean, it already does compression, and is terse enough to be efficent 
for booting purposes. However, it might be too terse as it:
1) Doesn't support hard links
2) Doesn't store atime/mtime/ctime

I don't know if that'd be too restrictive for an initrd replacement, but 
having only one compressed-filesystemish filesystem for the kernel would be 
nice.

-Ryan
