Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSEVOXT>; Wed, 22 May 2002 10:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSEVOXS>; Wed, 22 May 2002 10:23:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22725 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314504AbSEVOXR>;
	Wed, 22 May 2002 10:23:17 -0400
Date: Wed, 22 May 2002 09:19:34 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] POSIX personality
Message-ID: <13860000.1022077174@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0205211603340.15094-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 21, 2002 04:08:52 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

>> 
>> One reason for it would be that it would be more efficient. All the
>> various shared state needed for POSIX thread group emulation could be
>> put into a  single structure with a single reference count.
> 
> Now, that's a separate issue - the issue of the exact _granularity_ of
> the  bits, and how you group things together.
> 
> On that front, I don't have any strong feelings - but I suspect that it 
> almost always ends up being fairly obvious when it is "right" to group 
> things together, and when it isn't.
> 
> For example, we probably could have had just one bit for (FS | FILES),
> and  the same is probably true of (SIGHAND | THREAD), but on the whole we 
> haven't really had any gray areas when it comes to the grouping. And I 
> don't see any coming up.
> 
> Does that mean that we might have a CLONE_POSIXDAMAGE that just covers all
> the strange POSIX stuff that make no sense anywhere else? Maybe. But I'd
> want that to be just another bit with the same semantic behaviour as the
> existing ones, _not_ be some external "POSIX personality".

I've been thinking along those lines myself.  At this point I'd suggest we
implement them as separate, then if in the future no one ever uses them
separately we can consider combining them.  I know this can raise some
backward compatibility issues but in theory if anyone cares we wouldn't do
it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

