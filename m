Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRBVXyS>; Thu, 22 Feb 2001 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRBVXyI>; Thu, 22 Feb 2001 18:54:08 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:42703 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S129290AbRBVXxz>; Thu, 22 Feb 2001 18:53:55 -0500
Message-ID: <3A95A6A0.6E191F2C@netcomuk.co.uk>
Date: Thu, 22 Feb 2001 23:54:08 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hashing and directories
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk> <3A959F35.A99CEEEC@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> Bill Crawford wrote:
...
> > We use Solaris and NFS a lot, too, so large directories are a bad
> > thing in general for us, so we tend to subdivide things using a
> > very simple scheme: taking the first letter and then sometimes
> > the second letter or a pair of letters from the filename.  This
> > actually works extremely well in practice, and as mentioned above
> > provides some positive side-effects.

> This is sometimes feasible, but sometimes it is a hack with painful
> consequences in the form of software incompatibilites.

 *grin*

 We did change the scheme between different versions of our local
software, and that caused one or two small nightmares for me and a
couple other guys who were developing/maintaining systems here.

 ...

 I don't mind improving performance on big directories -- Solaris
sucks when listing a large directory, for example, but is is rock
solid, which is important where we use it.

 My worry is that old thing about giving people enough rope to hang
themselves; I'm humanitarian enough that I don't like doing that.

 In other words, if we go out and tell people they can put millions
of files in a directory on Linux+ext2, they'll do it, and then they
are going to be upset because 'ls -l' takes a few minutes :)

> >  I guess what I really mean is that I think Linus' strategy of
> > generally optimizing for the "usual case" is a good thing.  It
> > is actually quite annoying in general to have that many files in
> > a single directory (think \winnt\... here).  So maybe it would
> > be better to focus on the normal situation of, say, a few hundred
> > files in a directory rather than thousands ...

> Linus' strategy is to not let optimizations for uncommon cases inflict
> the common case.  However, I think we can make an improvement here that
> will work well even on moderate-sized directories.

 That's a good point ... I have mis-stated Linus' intention.
I guess he may be along to tick me off in a minute :)

 I have no quibbles with that at all ... improvements to the
general case never hurt, even if the greater gain is elsewhere ...

> My main problem with the fixed-depth tree proposal is that is seems to
> work well for a certain range of directory sizes, but the range seems a
> bit arbitrary.  The case of very small directories is also quite
> important, too.

 Yup.

 Sounds like a pretty good idea, however I would be concerned about
the side-effects of, say, getting a lot of hash collisions from a
pathological data set.  Very concerned.

 I prefer the idea of a real tree-structure ... ReiserFS already
gives very good performance for searching using find, and "rm -rf"
truly is very fast, and I would actually like the benefits of the
structure without the journalling overhead for some filesystems.
I'm thinking especially of /usr and /usr/src here ...

>         -hpa

> "Unix gives you enough rope to shoot yourself in the foot."

 Doesn't it just?  That was my fear ...

 Anyway, 'nuff said, just wanted to comment from my experiences.

> http://www.zytor.com/~hpa/puzzle.txt

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
