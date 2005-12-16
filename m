Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVLPArk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVLPArk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLPArk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:47:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751222AbVLPArj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:47:39 -0500
Date: Fri, 16 Dec 2005 01:47:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216004740.GV23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215231538.GF3419@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:15:38PM -0500, Dave Jones wrote:
> On Thu, Dec 15, 2005 at 11:30:00PM +0100, Adrian Bunk wrote:
> 
>  > An how many weird crashes with _different_ causes have you seen?
>  > It could be that there are only _very_ few problems that noone really 
>  > debugs brcause disabling 4k stacks fixes the issue.
> 
> the block layer issue that Neil had patches for was the only one
> that rings any bells for me[*] (and the only one in Fedora bugzilla
> that anyone has actually hit -- and that's 2-3 people out of
> a *lot* of users).

Neil's patch is required, and since it's not in 2.6.15-rc we might still 
get bug reports with 4k stacks that are fixed by his patch.

Do we have any bug reports due to 4k stacks against -mm since Neil's 
patch was included?

People were able to convince me in the past to delay my patch to always 
use 4k stacks by pointing to unsolved problems (or I pointed them like 
in the reiser4 case) - and these were constructive delays since the code 
was fixed. So if someone wants to convince me that it's too early for my 
patch, simply send me some pointers to 4k stack issues still present in 
a recent -mm.  :-)

Hm, I just found two serious stack usage regressions in 2.6.15-rc (bug 
report will be in a separate email), but allocating arrays with more 
than 2000 elements on the stack is always wrong in the kernel 
independent of the stack size...

> 		Dave
> 
> [*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
> for a long time -- people were reporting overflows there before we
> enabled 4K stacks.

I remember someone from the XFS maintainers (Nathan?) saying they 
believe having solved all XFS stack issues.

If there are any XFS issues left, do you have a pointer to them?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

