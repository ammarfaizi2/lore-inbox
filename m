Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277097AbRJ0VHG>; Sat, 27 Oct 2001 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277123AbRJ0VG4>; Sat, 27 Oct 2001 17:06:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26032 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277097AbRJ0VGo>;
	Sat, 27 Oct 2001 17:06:44 -0400
Date: Sat, 27 Oct 2001 17:01:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110271657210.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Oct 2001, Alexander Viro wrote:

> devfs_rmdir() checks that directory is empty.  Then it calls
> devfsd_notify_one(), which can block.  Then it marks the entry
> unregistered and reports success.
> 
> Guess what will happen if devfs_register() will happen at that
> moment...

Ugh... My apologies - race here is a bit different.  Namely,
devfs_register() find a directory, starts creating a child,
blocks in kmalloc(), _then_ entire devfs_rmdir() happens and
devfs_register() merrily inserts a new child into dead directory.

