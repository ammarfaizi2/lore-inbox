Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290377AbSBFKjY>; Wed, 6 Feb 2002 05:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290389AbSBFKjR>; Wed, 6 Feb 2002 05:39:17 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:24978 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290377AbSBFKi7>; Wed, 6 Feb 2002 05:38:59 -0500
Message-Id: <5.1.0.14.2.20020206094947.04d4a2d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 06 Feb 2002 10:35:16 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: VFS EA interface patch (was: A modest proposal...)
Cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <ag@bestbits.at>
In-Reply-To: <E16YJNO-0000rY-00@starship.berlin>
In-Reply-To: <20020130104004.C81308@wobbly.melbourne.sgi.com>
 <p73d6zshidj.fsf@oldwotan.suse.de>
 <Pine.LNX.4.33.0201291502460.1747-100000@penguin.transmeta.com>
 <20020130104004.C81308@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:08 06/02/02, Daniel Phillips wrote:
[snip]
>My main problem with the EA interface patch itself is that there is no
>way to specify the class of the EA, currenly 'system' or 'user'.
>Instead, individual filesystems are expected to parse the attribute
>name to determine the class.  I think this is inadequate, and has not
>been discussed sufficiently.

Have you read those:
         http://acl.bestbits.at/man/extattr.5.html
         http://acl.bestbits.at/man/extattr.2.html

Why is this inadequate? The above specify perfectly well what the current 
defined EA namespaces are, and the API is extensible in that should people 
come up with other useful namespaces (I can't think of any) they can just 
be added without any modification to the generic EA interface in the kernel 
and that is good.

NTFS for example has no concept of different EA classes and I am planning 
to only support the "user." namespace and just adding "user." before 
returning an EA and removing it when writing an EA. All other classes will 
just return that such beasts are not supported.

>What will happen is, user space utilities will start making assumptions
>about the syntax of ea names (because the kernel interface provides no
>other alternative) and the current, arbitrary, EA name syntax will become
>cast in stone for ever more.

A binary interface is much worse. While with the current interface it is 
arbitrary, at least it is defined, so yes, it is set in stone for ever 
more, and that is a Good Thing, you don't want to be changing that in the 
future.

However you are missing a very important point and that is that this is the 
EA API for the kernel. There is nothing to stop glibc (or some EA library) 
defining whatever different interface they like and exposing that to user 
space.

>Then attribute classes will start to multiply, we'll get attribute 
>namespaces, and we'll get more arbitrary hacks added to the attribute name 
>syntax to accomodate them.  Support for 'new, improved' attribute name 
>syntax will be variable across filesystems.  This isn't going to be pretty.

I don't see why any of this should happen. The interface for EAs is well 
defined in the above referenced documents. And note that we already have 
attribute namespaces, that is the whole point of the "user.", "system.", 
etc. That is what is used to distinguish the various classes. Or did I miss 
your point completely?

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

