Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRB1IeT>; Wed, 28 Feb 2001 03:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbRB1IeK>; Wed, 28 Feb 2001 03:34:10 -0500
Received: from fungus.teststation.com ([212.32.186.211]:5305 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130105AbRB1IeA>; Wed, 28 Feb 2001 03:34:00 -0500
Date: Wed, 28 Feb 2001 09:33:31 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Rainer Mager <rmager@vgkk.com>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Building autofs
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGGENDDCAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.30.0102280915340.8425-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Rainer Mager wrote:

> Hi all,
> 
> 	I'm trying to use autofs for the first time and am running into some
> problems. First,  the documentation seems quite weak, that is, I'm not sure

I am sure the maintainer would appreciate if you wrote down what you found
difficult/missing from the docs (in the form of a patch to the existing
docs perhaps).

> if what I have is what I should have. I managed to find an autofs version 4
> pre 9 tarball on the kernel mirrors. This seem the latest but is still a bit
> old and the referenced home page doesn't seem any newer. My real problem,
> however, is that when I try to build it I get this error:
> 
> lookup_program.c:147: `OPEN_MAX' undeclared (first use in this function)

#include <linux/limits.h> gives:
#define OPEN_MAX         256    /* # open files a process may have */

But autofs is well behaved and doesn't use kernel headers but that makes
it fails on newer glibcs (at least I think that was it).

Just define it. If autofs4 is doing the same as autofs3 then it is only
used for program lookups (where a program generates the map to use) and
unless you are going to use those it won't matter at all.


There is also some info here, including how to find the autofs
mailinglist.
http://www.linux-consulting.com/Amd_AutoFS/autofs.html

Or google for "autofs OPEN_MAX", "autofs mailinglist archive", ...
There appears to be a autofs-open_max.patch somewhere.

/Urban

