Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282386AbRKXHMV>; Sat, 24 Nov 2001 02:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282387AbRKXHML>; Sat, 24 Nov 2001 02:12:11 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27440 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282386AbRKXHL7>; Sat, 24 Nov 2001 02:11:59 -0500
Date: Sat, 24 Nov 2001 08:12:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124081217.A1419@athlon.random>
In-Reply-To: <20011124080113.A1316@athlon.random> <Pine.GSO.4.21.0111240203520.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240203520.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 02:06:32AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:06:32AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > this one looks even better (and it doesn't need to propagate the fix to
> > the lowlevel):
> > 
> > --- 2.4.15aa1/fs/super.c.~1~	Fri Nov 23 08:21:01 2001
> > +++ 2.4.15aa1/fs/super.c	Sat Nov 24 07:58:37 2001
> > @@ -470,6 +470,7 @@
> >  	return s;
> >  
> >  out_fail:
> > +	invalidate_inodes(s);
> 
> Sigh...
> 	a) grep, please.
> 	b) you are triggering method calls for a superblock after failed
> ->read_super().  Blindly.  Care to audit all filesystems and check that
> it is legitimate?

if the method or the s_op isn't defined it will do nothing, if it is
defined it'd better do something not wrong because the fs just did an
iget within read_super. I don't see obvious troubles and the above looks
better than making iput more complex (and nitpicking slower 8).

Andrea
