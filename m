Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268078AbUH1U1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268078AbUH1U1D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268041AbUH1UYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:24:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15820 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266512AbUH1UWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:22:41 -0400
Date: Sat, 28 Aug 2004 22:22:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-ID: <20040828202232.GL12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151544.GB12772@fs.tum.de> <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com> <20040828162633.GG12772@fs.tum.de> <20040828125816.206ef7fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828125816.206ef7fa.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:58:16PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> >  > Anything you put in BUG_ON() must *NOT* have side effects.
> >  >...
> > 
> >  I'd have said exactly the same some time ago, but I was convinced by 
> >  Arjan that if done correctly, a BUG_ON() with side effects is possible  
> >  with no extra cost even if you want to make BUG configurably do nothing.
> 
> Nevertheless, I think I'd prefer that we not move code which has
> side-effects into BUG_ONs.  For some reason it seems neater that way.
> 
> Plus one would like to be able to do
> 
> 	BUG_ON(strlen(str) > 22);
> 
> and have strlen() not be evaluated if BUG_ON is disabled.
> 
> A minor distinction, but one which it would be nice to preserve.

OTOH, only very few people use the disabled BUG_ON, and a statement 
with a side effect might stay there unnoticed for some time.

If it's a
  #define BUG_ON(x)
and in one place something with a side effect slipped into the BUG_ON, 
you have a classical example for a heisenbug...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

