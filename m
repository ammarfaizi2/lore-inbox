Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRCBIlI>; Fri, 2 Mar 2001 03:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRCBIk7>; Fri, 2 Mar 2001 03:40:59 -0500
Received: from t2.redhat.com ([199.183.24.243]:42741 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S130355AbRCBIkx>; Fri, 2 Mar 2001 03:40:53 -0500
To: torvalds@transmeta.com, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable 
In-Reply-To: Your message of "01 Mar 2001 11:12:14 PST."
             <97m6ue$7uu$1@penguin.transmeta.com> 
Date: Fri, 02 Mar 2001 08:40:44 +0000
Message-ID: <8165.983522444@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@transmeta.com> wrote:
> Also note that the merging tests were not free, so at least under my set of
> normal load the non-merging code is actually _faster_ than the clever
> optimized merging. That was what clinched it for me: I absolutely hate to
> see complexity that doesn't really buy you anything noticeable.

Surely, doing the merge will always have take longer than not doing the merge,
no matter how finely optimised the algorithm... But merging wouldn't be done
very often... only on memory allocation calls.

Or do you mean that use of the resultant VMA chain/tree is slower? This I find
suprising since after merging the VMA tree should at worst as complex as it
was before merging, and fairly likely simpler.

Perhaps it'd be reasonable to only do VMA merging on mmap calls and not brk
calls, and let brk manually extend an existing VMA if possible.

David
