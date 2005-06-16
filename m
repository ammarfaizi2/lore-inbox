Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVFPVv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVFPVv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVFPVv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:51:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55497 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261723AbVFPVv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:51:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
Date: Thu, 16 Jun 2005 23:48:37 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost> <20050616134126.264d6bd5.akpm@osdl.org> <Pine.LNX.4.62.0506162254480.2477@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506162254480.2477@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506162348.38423.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 16 Juni 2005 23:02, Jesper Juhl wrote:
> On Thu, 16 Jun 2005, Andrew Morton wrote:
> > There are surely many warnings in the tree, hence I'm not really interested
> > in patches which only fix `gcc -W' warnings.
> > 
> 
> Ok, in that case I won't bother you directly with such patches any more 
> but instead let them trickle into maintainers trees when they will take 
> them.
> 
> And yes, I know it's very trivial stuff and it doesn't make much of a 
> difference to the "big picture", but my attitude towards that is that no 
> issue is too small to be addressed, and since I'm not able to adress many 
> of the larger issues I try to address the smaller ones that I'm able to 
> handle, and when I run out of those I start nitpicking with the really 
> trivial stuff (like gcc -W warnings) - all with the purpose of helping our 
> kernel be the very best it can, even if my contribution might be very 
> minor in some cases.

I have a patch that optionally enables some of the interesting warnings
that gcc supports (e.g. -Wmissing-format-attribute -Wmissing-declarations
-Wundef -Wwrite-strings).

It has four different levels:

- quiet (current warnings minus -Wdeprecated-declarations)
- normal (some interesting ones added that are not too noisy)
- more (all interesting ones, including some noisier ones like 
  -Wmissing-declarations)
- overkill (-W and some more that only make sense for statistic
  analysis)

I have the base patch and some more patches that fix the most annoying 
warnings. I find them more useful than the signed vs unsigned comparison
fixes you are doing right now, but don't have the time to split my
patches up into obvious chunks.

Jesper, are you interested in my stuff and willing to continue that work?
I'd suggest to fix the warnings at 'normal' level first and then
integrate the patch for configurable warning levels into -mm.

	Arnd <><
