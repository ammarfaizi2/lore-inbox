Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281166AbRKOXTl>; Thu, 15 Nov 2001 18:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281168AbRKOXTd>; Thu, 15 Nov 2001 18:19:33 -0500
Received: from rj.sgi.com ([204.94.215.100]:7102 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281162AbRKOXTZ>;
	Thu, 15 Nov 2001 18:19:25 -0500
Date: Fri, 16 Nov 2001 10:18:00 +1100
From: Nathan Scott <nathans@sgi.com>
To: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011116101800.A632931@wobbly.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu> <20011113062711.A1912@wotan.suse.de> <20011115160853.N588010@wobbly.melbourne.sgi.com> <20011114230134.A5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114230134.A5739@lynx.no>; from adilger@turbolabs.com on Wed, Nov 14, 2001 at 11:01:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Andreas,

On Wed, Nov 14, 2001 at 11:01:34PM -0700, Andreas Dilger wrote:
> On Nov 15, 2001  16:08 +1100, Nathan Scott wrote:
> 
> > +	int (*create) (struct inode *, char *, void *, size_t);
> > +	int (*replace) (struct inode *, char *, void *, size_t);
> > +	int (*set) (struct inode *, char *, void *, size_t);
> 
> What is the distinction between "set" and "replace" or "set" and "create"?
> 

+#define EA_CREATE   0x0001  /* Set the value: fail if attr already exists */
+#define EA_REPLACE  0x0002  /* Set the value: fail if attr does not exist */

Whereas "set" is simply set the named attribute value, creating the
attribute if need be, replacing the value if the attribute exists,
and then return success.

The man pages on AndreasG's site go into more detail, but decribe
the original interface which Al didn't like.  I haven't created an
updated man page yet, because I'm still not sure if this interface
is quite what Al was looking for either... (Al?)

> ... why are there not just
> flags to distinguish the two, but also separate VFS operations?

A VFS flags parameter could allow an individual filesystem to extend
the semantics of the set operation in new ways by adding new flags -
I think Al wanted to avoid the possibility of that ever happening,
which seems fair enough.

cheers.

-- 
Nathan
