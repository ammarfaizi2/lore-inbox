Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRKTB4V>; Mon, 19 Nov 2001 20:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKTB4L>; Mon, 19 Nov 2001 20:56:11 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:50329 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280825AbRKTB4G>;
	Mon, 19 Nov 2001 20:56:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Tommi Kyntola <kynde@ts.ray.fi>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Date: Mon, 19 Nov 2001 17:55:51 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111200328550.842-100000@behemoth.ts.ray.fi>
In-Reply-To: <Pine.LNX.4.33.0111200328550.842-100000@behemoth.ts.ray.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16608e-0001CL-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 17:37, you wrote:
> Even so, I'm wondering wether this removal is standardad
> procedure for hiding it once and for all or not?
On my system, the journal appears to have a perfectly normal inode number for 
a root entry (#22), which makes me think that it's just a normal file as far 
as the core filesystem code is concerned. So, when the file is deleted, its 
blocks are freed, and new allocations are free to walk all over the journal. 
That is if the filesystem doesn't barf because the superblock references a 
deleted inode for its journal. Just a theory, though.

Now, I heard (from the same source I vaugely remember reading about hidden 
journals, so take this with a grain of salt) that tune2fs would try to use 
reserved inode #8 for the .journal if possible, and the filesystem could 
handle deletion in that case just fine. So, hopefully the partition of yours 
was using the reserved inode number. Seeing deletion is no longer dangerous, 
tune2fs may have decidedly not set the immutable flag so that you're free to 
'hide' it using rm.

I think this is the part where the ext3 gods step in and free us from our 
ignorance-inspired conjecture.

> Since what's there to stop you from 'chattr -i .journal ; rm .journal'.
I think that's a case of "don't do that, then". I took the immutable flag 
being set as a pretty clear indiction that if I cleared the flag and started 
to play with the file, I pretty much deserve whatever I get. ;)

-Ryan
