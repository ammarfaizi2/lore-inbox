Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWCYGs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCYGs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWCYGs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:48:28 -0500
Received: from smtpout.mac.com ([17.250.248.87]:11721 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750797AbWCYGs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:48:28 -0500
In-Reply-To: <20060324150100.ec96dc15.rdunlap@xenotime.net>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060324150100.ec96dc15.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6A4D94A-64AF-46C5-804C-91D661C8C7FE@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Sat, 25 Mar 2006 01:48:13 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006, at 18:01:00, Randy.Dunlap wrote:
> Kyle,
> Do you have (recorded) or recall any constraints or requirements on  
> this $subject from Linus or Andrew or others?  I mean just basic  
> big items, like "thou shalt not mix foo and bar".
>
> I'm just looking for the basic parameters of this task.

Well, to a large extent he's actually wisely kind of stayed out of  
the flamewars :-D  I'm guessing he's hoping that we'll figure  
something acceptable out on our own and send him patches without him  
having to think about it much.  He has said this, though:
> On the bigger question of what to do with kernel headers in  
> general, let's just make one thing clear: the kernel headers are  
> for the kernel, and big and painful re-organizations that don't  
> help _existing_ user space are not going to happen.

He's also said this:
> On Tue, 30 Nov 2004, Alexandre Oliva wrote:
>> Then maybe this is the fundamental problem. As long as the kernel  
>> doesn't recognize that an ABI is a contract, rather than an  
>> imposition, kernel developers won't care.
>
> That's a silly analogy. Worse, it's a very flawed analogy.
>
> If you want to use a legal analogy, the ABI is not a contract, it's  
> a public _license_.
>
> Why? A contract is something that you cannot change unilaterally.  
> Clearly the kernel _can_ and will change the ABI without asking  
> every existing program for permission.
>
> In a license, you can always just _expand_ the license eventually.  
> Maybe you originally licensed for "fly-fishing for trout", and  
> later you can expand that license to say "you can also catch  
> crawfish" without impacting your existing licensees.
>
> And exactly as with an ABI, the only thing you can't do is _remove_  
> rights without getting into trouble.
>
> So get your analogies straight. The kernel ABI is _not_ a contract.

My hope for this is that we can start doing _little_ and clearly  
obvious changes that clean up header files.  Basically a lot of the  
__KERNEL__ definitions need janitorial work.  Either they need to be  
removed or they need to be put in the right places.  Also it seems  
like there's a lot of duplication between architectures; for one  
example look at all the varieties of FD_SET code in the different  
linux/include/asm-*/posix_types.h files.  That's one of the areas I'm  
trying to clean up into a single linux/fdset.h included from the  
pertinent files.  Notice how the file forcibly overrides GLIBC; I  
think if we can define it as __KABI_FD* and only define the non- 
prefixed version in __KERNEL__, then we can provide something that  
GLIBC and klibc can get for free, without having to figure out their  
own bitmaps.  Likewise some of the user-accessible types are uniform  
across architectures, and others are haphazardly arrayed, some to be  
compatible with other OSes on that architecture, others just because  
that's what the arch they copied from used.  I'm hoping if I can get  
enough small patches flowing, others will join in too and the process  
will go easier.

Cheers,
Kyle Moffett

