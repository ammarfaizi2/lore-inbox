Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283964AbRLAHBr>; Sat, 1 Dec 2001 02:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283963AbRLAHBh>; Sat, 1 Dec 2001 02:01:37 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:55740 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283961AbRLAHBa>; Sat, 1 Dec 2001 02:01:30 -0500
Date: Sat, 1 Dec 2001 00:01:23 -0700
Message-Id: <200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org, pierre.rousselet@wanadoo.fr
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <9u9qas$1eo$1@penguin.transmeta.com>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
	<9u9qas$1eo$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> In article <3C085FF3.813BAA57@wanadoo.fr>,
> Pierre Rousselet  <pierre.rousselet@wanadoo.fr> wrote:
> >As far as I can see,
> >
> >when CONFIG_DEBUG_KERNEL is set
> >  and 
> >when devfsd is started at boot time
> >I get an Oops when remounting, rw the root fs :
> >
> >Unable to handle kernel request at va 5a5a5a5e
> 
> POISON_BYTE is 0x5a. Something in devfs is using a pointer from a data
> structure that was already free'd, and was thus corrupted by poisoning.
> 
> (the above is almost certainly just a pointer dereference off 0x5a5a5a5a
> with an offset of 4 for some entry at the beginning of a structure,
> which is why you get the final "5e" in the page fault address). 
> 
> >It boots OK with devfsd when CONFIG_DEBUG_KERNEL is not set.
> >It boots OK without devfsd when CONFIG_DEBUG_KERNEL is set (then devfsd
> >can be started after login).
> 
> Well, not poisoning the free'd memory makes it "work" only in the sense
> that usually the free'd memory hasn't been re-allocated yet, so you
> don't see the bug even if it is still there.
> 
> Richard Gooch probably wants a full stack trace, with symbols. Which
> should show it fairly clearly. At least EIP and the first few "stack
> trace" entries..

Indeed I do. Please Cc: me on devfs related stuff. And please apply
devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
knowing the behaviour with 2.4.17-pre1.

I also need your full .config and boot messages. And booting with
"devfs=dall" is required as well.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
