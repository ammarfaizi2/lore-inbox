Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUCLS3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbUCLS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:29:19 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:16025 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262391AbUCLS3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:29:13 -0500
Date: Fri, 12 Mar 2004 19:29:12 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040312182912.GB7087@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403121849.03505.s.b.wielinga@student.utwente.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is assuming we keep current design.

On Fri, 12 March 2004 18:48:57 +0100, Sytse Wielinga wrote:
> 
> I have made some pretty thorough changes to your patch though. You can find 
> the patch attached to this email.
> Things I've changed:
> 
>  - moved break_cow_link from dentry_open in open.c to get_write_access in 
> namei.c. Putting it in dentry_open thoroughly breaks things, as it's too late 
> to save files from being truncated, for example.

True, good catch.

>  - made something from the mess you made of ext2/ext3 inode flags :-P

Good.  Both variants of my mess worked, so I left it for the moment.

>  - removed inheritance, as it's not useful in any way, not expected and breaks
> linking of files with S_COWLINK set.

Not useful?  Without inheritance, I have to manually add the flag for
every file/directory I add.  Each time I forget, writes go to both
files and I notice the mess weeks later.  Naa, that's where we're now
and why I created the patch in the first place.

What we do need, though, is a new errno.  -EMLINK is close, but still
wrong.

>  - made a go at supporting reiserfs, but failed... my changes are in the 
> patch, could somebody please have a look and tell me what I've missed?

No clue, don't care. :)

>  - fcntl_setcow now spins a spinlock

Not the only lock I missed.  Good.


Jörn

-- 
He who knows that enough is enough will always have enough.
-- Lao Tsu
