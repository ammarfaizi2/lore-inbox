Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265109AbSJWRoG>; Wed, 23 Oct 2002 13:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265123AbSJWRoG>; Wed, 23 Oct 2002 13:44:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19089 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265109AbSJWRoC>; Wed, 23 Oct 2002 13:44:02 -0400
To: Andi Kleen <ak@muc.de>
cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of 23 Oct 2002 05:03:38 +0200.
             <m3fzuxq2k5.fsf@averell.firstfloor.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20680.1035395384.1@us.ibm.com>
Date: Wed, 23 Oct 2002 10:49:44 -0700
Message-Id: <E184PdY-0005Nc-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <m3fzuxq2k5.fsf@averell.firstfloor.org>, > : Andi Kleen writes:
> Gerrit Huizenga <gh@us.ibm.com> writes:
> 
> > If the shared pte patch had mmap support, then all shared libraries
> > would benefit.  Might need to align them to 4 MB boundaries for best
> > results, which would also be easy for libraries with unspecified
> > attach addresses (e.g. most shared libraries).
> 
> But only if the shared libraries are a multiple of 2/4MB, otherwise you'll
> waste memory. Or do you propose to link multiple mmap'ed libraries together
> into the same page ? 
 
Hmm.  I didn't propose.  Sounds cool.  But that would have to happen
at the compiler's loader level, not the dynamic linker side of things,
which makes it less likely.  Someone once proposed a mega-library where
the big/key shared objects were linked together which would make this
somewhat more practical.

But even wasting a bit of space for a few key libraries, even if they
are smaller than 4 MB (or 2 MB) on ia32 (ia32 PAE) might be worth a
bit of TLB & general overhead (e.g. like the kernel text pages).  And,
if shared, even a bigger win.

> But I agree it would be nice to have a chattr for files that tells
> mmap() to use large pages for them.

Yep - that would be ideal - like the old sticky flag on binaries.
As a patch, that would make it easy to compare performance diffs as
well.  Probably good for things like Oracle or DB2 as well.

gerrit
