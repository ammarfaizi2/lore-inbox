Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUH1Vqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUH1Vqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUH1Vpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:45:54 -0400
Received: from waste.org ([209.173.204.2]:43406 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268113AbUH1VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:44:10 -0400
Date: Sat, 28 Aug 2004 16:43:57 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-ID: <20040828214357.GN5414@waste.org>
References: <20040828151137.GA12772@fs.tum.de> <20040828151544.GB12772@fs.tum.de> <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com> <20040828162633.GG12772@fs.tum.de> <20040828125816.206ef7fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828125816.206ef7fa.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
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

Well, strlen doesn't actually have a side effect, so it could be
marked pure and then be optimized away.

I'll push configurable BUG_ON support from -tiny to you shortly so
this will stop being theoretical.

-- 
Mathematics is the supreme nostalgia of our time.
