Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264695AbSKDOyo>; Mon, 4 Nov 2002 09:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264698AbSKDOyn>; Mon, 4 Nov 2002 09:54:43 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:46277 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264695AbSKDOy1> convert rfc822-to-8bit; Mon, 4 Nov 2002 09:54:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Linus Torvalds <torvalds@transmeta.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 4 Nov 2002 08:58:54 -0600
User-Agent: KMail/1.4.1
Cc: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
References: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211040858.54578.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 November 2002 12:47 pm, Linus Torvalds wrote:
> Clearly inode numbers are a bad way to handle it, but I don't think inode
> attributes are that great either. I would personally prefer directory
> entry attributes, so that the same file can show up with different
> behaviour in different places.

So how would hard links be handled? Ignore the capability specified for
the file?

> I think it was a mistake to have permissions be part of the inode in the
> first place, but that's UNIX for you. A direntry-based approach is _so_
> much more flexible, and doesn't really have any downsides.

That was a conscious decision to ensure that the ownership, and mode
bits remained associated with a file no matter how the file is accessed (full
path, relative path, hard link, or inode number). It also meant that there was
only one place that might need to be updated if the permissions were
changed. If they were in directories then all directories containing a
link to the file would have to be updated (assuming you could find them
efficiently).

Since all accesses HAD to go through the inode, it forced the security
information to be united with the file, and could not be misplaced.

> (Having attributes in the direntry also makes it possible to much more
> efficiently scan directories for types of files without having to look up
> the inode information).

True, but a hard link would bypass whatever capabilities were assigned
to the file. Also, what happens on things like mv or cp. Since mv
only puts a name in the target directory with the inode number it
would appear that any capabilities assigned to the file would be lost.
Although cp should loose the capabilities, I would expect mv to preserve them.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
