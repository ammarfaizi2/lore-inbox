Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136808AbREISWn>; Wed, 9 May 2001 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136810AbREISWd>; Wed, 9 May 2001 14:22:33 -0400
Received: from idiom.com ([216.240.32.1]:11012 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S136808AbREISWZ>;
	Wed, 9 May 2001 14:22:25 -0400
Message-ID: <3AF92849.D4C621D5@namesys.com>
Date: Wed, 09 May 2001 04:21:45 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?iso-8859-1?Q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>,
        linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <E14xVHE-0002VB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > that reiserfs has had lots of bugs, and is marked as experimental in kernel
> > 2.4.4. Not to mention that the people of RH discourage there users from using
> > it.
>
> At the time Red Hat 7.1 was mastered Reiserfs was not stable. The reiserfs in
> the RH kernel has some of the tail fixes but newer ones are not present. Also
> it had other problems then: the fsck tool was useless, it didnt work on
> big endian machines (eg PPC, S/390).
>
> If Hans sent me a patch removing the experimental tag from Reiserfs the only
> thing that would make me hesitate the slightest from applying it would be the
> endianness thing, and thats not enough to stop it being applied.

Jeff Mahoney has a patch in progress for this, he currently has the kernel code
working, but needs to do the utilities.  I would hesitate to put the endianness
fixes in before 2.5.1 just because I am conservative about disturbing stable code.

There exists one known bug which one user has hit which required a major code
change to fix.  We are now testing the code, and are in the ironic situation
of hesitating to merge in a bug fix out of fear that the bugfix code is large and
untested, and it might have bugs that more than one user will hit.:-/
I think we are going to make the new code an option until it has been
extensively tested.

I think that 2.4.4 is stable, and I say this based upon us getting lots of users
with
hardware bugs and none with bugs not fixed in 2.4.4 in the entire time since 2.4.4
was released.


>
>
> > There has also been lots of talks about reiserfs being the cause of some data
> > lose and performance lose (not sure about this last one).
>
> If you are running 2.4.4/2.4.4-ac/2.4.5pre I believe all the relevant reiserfs
> patches are applied. The new fsck seems to work a lot better too. The limiters
> right now are:
>         -       You need a patch for NFS (its on their site no big deal)
>         -       You can only use little endian boxes (x86 for you so ok)

you also need a patch for quotas.

>
> > I think that the data lose is not significant in a proxy cache, if the FS is
> > really fast, as is said reiserfs is.

you can ask nikita for a copy of reiserfs_raw, a version of reiserfs designed for
squid.  It is substantially faster.

Hans

