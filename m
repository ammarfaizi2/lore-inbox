Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSBFKwI>; Wed, 6 Feb 2002 05:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290417AbSBFKvr>; Wed, 6 Feb 2002 05:51:47 -0500
Received: from dsl-213-023-043-188.arcor-ip.net ([213.23.43.188]:30642 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290370AbSBFKvn>;
	Wed, 6 Feb 2002 05:51:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: VFS EA interface patch (was: A modest proposal...)
Date: Wed, 6 Feb 2002 11:52:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <ag@bestbits.at>
In-Reply-To: <20020130104004.C81308@wobbly.melbourne.sgi.com> <5.1.0.14.2.20020206094947.04d4a2d0@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020206094947.04d4a2d0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YPgs-0002NU-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 6, 2002 11:35 am, Anton Altaparmakov wrote:
> At 04:08 06/02/02, Daniel Phillips wrote:
> [snip]
> >My main problem with the EA interface patch itself is that there is no
> >way to specify the class of the EA, currenly 'system' or 'user'.
> >Instead, individual filesystems are expected to parse the attribute
> >name to determine the class.  I think this is inadequate, and has not
> >been discussed sufficiently.
> 
> Have you read those:
>          http://acl.bestbits.at/man/extattr.5.html
>          http://acl.bestbits.at/man/extattr.2.html
> 
> Why is this inadequate? The above specify perfectly well what the current 
> defined EA namespaces are, and the API is extensible in that should people 
> come up with other useful namespaces (I can't think of any) they can just 
> be added without any modification to the generic EA interface in the kernel 
> and that is good.

There's always a namespace string and an attribute name string?  That sounds
like two parameters to me, why are they being passed as one.

> >What will happen is, user space utilities will start making assumptions
> >about the syntax of ea names (because the kernel interface provides no
> >other alternative) and the current, arbitrary, EA name syntax will become
> >cast in stone for ever more.
> 
> A binary interface is much worse. While with the current interface it is 
> arbitrary, at least it is defined, so yes, it is set in stone for ever 
> more, and that is a Good Thing, you don't want to be changing that in the 
> future.
>
> However you are missing a very important point and that is that this is the 
> EA API for the kernel. There is nothing to stop glibc (or some EA library) 
> defining whatever different interface they like and exposing that to user 
> space.

I'm did not miss that.  Why do you want glibc, or worse, user tools, doing
extra ascii smashing to build up the ea string in the format the kernel
interface wants.

> >Then attribute classes will start to multiply, we'll get attribute 
> >namespaces, and we'll get more arbitrary hacks added to the attribute name 
> >syntax to accomodate them.  Support for 'new, improved' attribute name 
> >syntax will be variable across filesystems.  This isn't going to be pretty.
> 
> I don't see why any of this should happen. The interface for EAs is well 
> defined in the above referenced documents. And note that we already have 
> attribute namespaces, that is the whole point of the "user.", "system.", 
> etc. That is what is used to distinguish the various classes. Or did I miss 
> your point completely?

Namespaces are good.  I don't like the syntax being built into the name.
This is every bit as wrong as the thing Al complained about, creating more
system calls by passing in a function number.

If there are two strings, pass two strings.

-- 
Daniel
