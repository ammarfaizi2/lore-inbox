Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSKCB45>; Sat, 2 Nov 2002 20:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSKCB44>; Sat, 2 Nov 2002 20:56:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16391 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261555AbSKCB44>; Sat, 2 Nov 2002 20:56:56 -0500
Date: Sat, 2 Nov 2002 18:03:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <87y98bxygd.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002, Olaf Dietsche wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> >  - Make a new file type, and put just that information in the directory
> >    (so that it shows up in d_type on a readdir()).  Put the real data in
> >    the file, ie make it largely look like an "extended symlink".
> 
> How would you go from a regular file to the new extended symlink?

I don't understand the question.

Let's say that you have a binary like /usr/bin/sendmail, and you want to
give it a certain set of capabilities (ie you want to _avoid_ making it
suid root - you only want to give it the specific capability of being able
to chown files to others and whatever else it is sendmail really wants to
do).

So I'd suggest _not_ attaching that capability to the sendmail binary
itself, or to any inode number of that binary. A binary is a binary is a
binary - it's just the data. Instead, I'd attach the information to the
directory entry, either directly (ie the directory entry really has an
extra field that lists the capabilities) or indirectly (ie the directory
entry is really just an "extended symlink" that contains not just the path
to the binary, but also the capabilities associated with it).

The reason I like directory entries as opposed to inodes is that if you
work this way, you can actually give different people _different_
capabilities for the same program.  You don't need to have two different
installs, you can have one install and two different links to it.

		Linus

