Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCWOrU>; Fri, 23 Mar 2001 09:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRCWOrK>; Fri, 23 Mar 2001 09:47:10 -0500
Received: from [166.70.28.69] ([166.70.28.69]:61496 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S131056AbRCWOq5>;
	Fri, 23 Mar 2001 09:46:57 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
In-Reply-To: <Pine.GSO.4.21.0103221720250.5619-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2001 07:45:16 -0700
In-Reply-To: Alexander Viro's message of "Thu, 22 Mar 2001 18:07:44 -0500 (EST)"
Message-ID: <m1lmpw1r43.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> IOW, you can get normal filesystem view (meaning that you have all usual
> UNIX toolkit available) for per-fs control stuff. And keep the ability to
> do proper locking - it's the same driver that handles the main fs and you
> have access to superblock. No need to change the API - everything is already
> there...
> 	I'll post an example patch for ext2 (safe access to superblock,
> group descriptors, inode table and bitmaps on a live fs) after this weekend
> (== when misc shit will somewhat settle down).
> 						Cheers,
> 							Al
> 
> PS: Folks[1], I hope it explains why I'm very sceptical about "let's add new
> A{B,P}I" sort of ideas - approach above can be used for almost all stuff
> I've seen proposed. You can have multiple views of the same object. And
> have all of them available via normal API.


This is a cool idea.  But I couple of places where this might fall down.
1) If a filesystem has multiple name spaces and we use different mounts
   to handle them, will this break anything?  Fat32 with it's short and long
   names, and the Novell filesystem are the examples I can think of.

2) An API is still being developed it just uses the existing infrastructure
   which is good, but we still need to standardize what is exported.  It's
   a cleaner way to build a new API but a new API is being built.

3) What is a safe way to do this so a non-root user can call mount?

4) What is appropriate way using open,read,write,close,mount to handle stat data
   and extended attributes.  The stat data is the big one because it is used
   so frequently.  Possibly a mount&open&read/write&close&umount syscall is needed.
   
   I keep thinking open("/path/to/file/stat_data") but that feels excessively heavy
   at the API level.   But if we involve mount (at least semantically)
   that could work for directories as well. 

The goal here is to push your ideas to the limits so we can where
using ioctl or new a syscall is appropriate.  If indeed there is such
a case.

Eric
