Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284795AbRLDAUy>; Mon, 3 Dec 2001 19:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284840AbRLDASE>; Mon, 3 Dec 2001 19:18:04 -0500
Received: from dsl-213-023-038-044.arcor-ip.net ([213.23.38.44]:47376 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284633AbRLCOvd>;
	Mon, 3 Dec 2001 09:51:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Date: Mon, 3 Dec 2001 15:52:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <E16Agdh-0000BS-00@starship.berlin> <20011203115400.F39338@wobbly.melbourne.sgi.com>
In-Reply-To: <20011203115400.F39338@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16AuSr-0000HG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 3, 2001 01:54 am, Nathan Scott wrote:
> ...BTW, we have reworked the interfaces once more and
> will send out the latest revision in the next couple of days -
> it does away with commands and flags completely, except for this
> one instance of flags in the set operation...

OK, well I can see some patterns emerging already:

long sys_getxattr(char *path, char *name, void *value, size_t size, int flags)
long sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
long sys_listxattr(char *path, char *name, void *value, size_t size, int flags)

long sys_fgetxattr(int fd, char *name, void *value, size_t size, int flags)
long sys_fsetxattr(int fd, char *name, void *value, size_t size, int flags)
long sys_flistxattr(int fd, char *name, void *value, size_t size, int flags)

Why don't I see 'delxattr'?

Why is there a need for separate 'path' and 'fd' variants?

<nit>Is there any other kind of 'attr' in the syscall interface?  Why not spell
it 'attr' instead of 'xaddr'?  How about geta, seta, dela, lista?</nit>

The idea of attribute class (namespace) isn't explicitly accomodated.  I presume
the intention is to encode the class as part of the attribute name and have the 
filesystem or vfs parse it out.  Is that such a good idea?  Why not pass the 
class explicitly and worry about the namespace parsing in user space?

As far as listing attributes goes, is there ever a reason to list system and
user attributes at the same time?  IOW, the listxattr call needs a class
parameter too.  It doesn't name a 'name', at least if you accept my argument
that the class should not be parsed inside the kernel.  There's no particular
reason to force all the parameter lists to be the same is there?

--
Daniel
