Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbRLFFnc>; Thu, 6 Dec 2001 00:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284999AbRLFFnX>; Thu, 6 Dec 2001 00:43:23 -0500
Received: from zok.sgi.com ([204.94.215.101]:51841 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283938AbRLFFnK>;
	Thu, 6 Dec 2001 00:43:10 -0500
Date: Thu, 6 Dec 2001 16:41:31 +1100
From: Nathan Scott <nathans@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011206164131.F50483@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16Boqr-0000m9-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Boqr-0000m9-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Dec 06, 2001 at 04:05:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 04:05:32AM +0100, Daniel Phillips wrote:
> Hi Nathan,
> 

hey there.

> I still don't like the class parsing inside the kernel, it's hard to see
> what is good about that.

I guess it ultimately comes down to simplicity.  The IRIX interfaces
have this separation of name and namespace - each operation has to
indicate which namespace is to be used.  That becomes very messy when
you wish to work with multiple attribute names and namespaces at once.
Since the namespace is intimately tied to the name anyway, this idea
of specifying the two components together provides very clean APIs.

The term "parsing" is a bit of an overstatement too.  We're talking
strncmp() complexity here, not lex/yacc. ;)  And its not clear that
you can get out of doing that level of parsing in the kernel anyway
(unless you go for a binary namespace representation, and that's a
real can of worms).

> Is there a difference between these two?:
> 
>    long sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
>    long sys_lsetxattr(char *path, char *name, void *value, size_t size, int flags)
> 

Yes, definately.  The easiest reason - there are filesystems which
support extended attributes on symlinks already (XFS does), coming
from other operating systems, and there should be a way to get at
that information too.

cheers.

-- 
Nathan
