Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282290AbRLEPlL>; Wed, 5 Dec 2001 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRLEPlB>; Wed, 5 Dec 2001 10:41:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:10511 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282290AbRLEPks>; Wed, 5 Dec 2001 10:40:48 -0500
Message-ID: <3C0E3DA4.3AA56904@evision-ventures.com>
Date: Wed, 05 Dec 2001 16:30:44 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deep look into VFS
In-Reply-To: <Pine.GSO.4.21.0112051009290.22944-100000@binet.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 5 Dec 2001, Martin Dalecki wrote:
> 
> > Unless I'm compleatly misguided the lock on the superblock
> > should entierly prevent the race described inside the header comment
> > and we should be able to delete clear_inode from this function.
> 
> Huh?  We drop that lock before the return from this function.  So if you
> move clear_inode() after the return, you lose that protections.
> 
> What's more, you can't more that lock_super()/unlock_super() into iput()
> itself - you need it _not_ taken in the beginning of ext2_delete_inode()
> and you don't want it for quite a few filesystems.
> 
> Nothing VFS-specific here, just a bog-standard "you lose protection of
> semaphore once you call up()"...

Ummmmm... that is well trivially true... of course (I'm 
slapping a hand on my forehead). 

Thank you for answering!
