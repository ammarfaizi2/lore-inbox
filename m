Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCMWCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCMWCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVCMWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 17:02:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:65229 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261470AbVCMWCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 17:02:03 -0500
Date: Sun, 13 Mar 2005 23:03:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Matthew Wilcox <matthew@wil.cx>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@au.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH][0/10] verify_area cleanup
In-Reply-To: <20050313195611.GE15648@holomorphy.com>
Message-ID: <Pine.LNX.4.62.0503132259260.2501@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503040247220.2801@dragon.hygekrogen.localhost>
 <20050313195611.GE15648@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005, William Lee Irwin III wrote:

> On Fri, Mar 04, 2005 at 03:47:07AM +0100, Jesper Juhl wrote:
> > Now that 2.6.11 is out the door it's time to try and submit this again.
> > The following patches convert all users of verify_area to access_ok and 
> > the final patch then deprecates verify_area acros all archs with the 
> > intention of removing it completely later. These patches get rid of 99+% 
> > of all users, there's still one or two macros left using it and there are 
> > still a few comments left refering to it that could be cleaned up - I'll 
> > get to those, but what remains after these patches is extremely little.
> > The reason for doing this is that verify_area is just a wrapper for 
> > access_ok anyway, so there's no good reason to keep it around - access_ok 
> > also seems more readable anyway with saner return values.
> > Since these patches touch things all over the tree the CC list would be 
> > enormous if I CC'd everyone involved on all patches, so I'll just CC this 
> > initial mail to a few key people I think are relevant (I hope I got that 
> > list right), and the actual patches I'll just send to linux-kernel and 
> > Andrew (or directly to people who ask for that).
> 
> The execution at first glance appears good. 

Thank you - Andrew found a few places where I'd messed up, but corrected 
those silently and merged the patches into -mm, so hopefully they can now 
get some proper testing.


>Out of curiosity, does this
> serve a larger purpose than eliminating a redundant API?
>
No, it's a redundant API and one that seems harder to get right (judging 
from all the comments about fixing up incorrect verify_area use all over 
the place) than acces_ok. That's the only reason for getting rid of it.


-- 
Jesper

