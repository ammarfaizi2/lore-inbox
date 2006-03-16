Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752333AbWCPKqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbWCPKqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbWCPKqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:46:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39320 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752333AbWCPKqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:46:31 -0500
Date: Thu, 16 Mar 2006 11:46:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: does swsusp suck after resume for you?
Message-ID: <20060316104630.GA9399@atrey.karlin.mff.cuni.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz> <200603162133.26771.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603162133.26771.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 16 March 2006 04:59, Pavel Machek wrote:
> > (It will probably suck. In such case, testing Con's patch would be
> > nice -- after trivial fix rafael pointed out).
> 
> Ok here's a patch I've booted and tested with a modification to swap prefetch
>  that others might find useful, not just swsusp.
> 
> The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
> 1	= Normal background swap prefetching when load is light
> 2	= Aggressively swap prefetch as much as possible
> 
> And once the "aggressive" bit is set it will prefetch as much as it can and
>  then disable the aggressive bit. Thus if you set this value to 3 it will
>  prefetch aggressively and then drop back to the default of 1. This makes it
>  easy to simply set the aggressive flag once and forget about it. I've booted
>  and tested this feature and it's working nicely. Where exactly you'd set this
>  in your resume scripts I'm not sure. A rolled up patch against 2.6.16-rc6-mm1
>  is here for simplicity:
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_suspend_test.patch
> 
> and the incremental on top of the 4 patches pending for the next -mm is below.
> 
> Comments and testers most welcome.

Looks okay, but... what happens if I set /proc/sys/vm/swap_prefetch to
"2"? Do nothing but do it agresively?

Maybe having 0 = off, 1 = normal, 2 = aggressive would be less error
prone for the users.

									Pavel

-- 
Thanks, Sharp!
