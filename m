Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbULFMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbULFMVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULFMVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:21:45 -0500
Received: from lakermmtao08.cox.net ([68.230.240.31]:25291 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261506AbULFMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:21:42 -0500
In-Reply-To: <1102310049.6052.123.camel@localhost>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org> <CED75073-4743-11D9-9115-000393ACC76E@mac.com> <1102310049.6052.123.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <62852042-4781-11D9-9115-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Con Kolivas <kernel@kolivas.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Time sliced CFQ #2
Date: Mon, 6 Dec 2004 07:21:41 -0500
To: Robert Love <rml@novell.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 06, 2004, at 00:14, Robert Love wrote:
> I think the complication of all of this demonstrates the 
> overcomplexity.
> I think we need to either
>
> 	(1) separate the two values.  we have a scheduling
> 	    priority (distributing the finite resource of
> 	    processor time) and an I/O priority (distributing
> 	    the finite resource of disk bandwidth).
> 	(2) just have a single value.
>
> Personally, I prefer (1).  But (2) is fine.
>
> What we want to do either way is cleanly separate the concepts in the
> kernel.  That way we can decide what we actually expose to user-space.

The reason I proposed my ideas for tying the two values together is 
that I am
concerned about breaking existing code.  I have several binaries to 
which the
source has been lost but I would like to have them continue to properly 
adjust
their priorities internally.  On the other hand, I have other programs 
that I am
currently writing where I would like to be able to have separate IO and 
CPU
priorities.  I believe that we could have two values yet preserve 
backwards
compatibility if we derive the effective IO priority from the sum or 
the provided
IO and CPU priority values, or something along those lines.  That way 
any
program not knowing about the new syscall could just nice() and get both
values adjusted.  If a parent program ran "ioprio()" beforehand to 
adjust the
ioprio with respect to the nice value, then that balance would be 
maintained.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


