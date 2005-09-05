Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVIETAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVIETAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIETAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:00:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4880 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932357AbVIETAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:00:15 -0400
Date: Mon, 5 Sep 2005 21:00:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Michael Matz <matz@suse.de>, ak@suse.de, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Message-ID: <20050905190014.GB3776@stusta.de>
References: <20050902203123.GT3657@stusta.de> <Pine.LNX.4.58.0509051047530.27439@wotan.suse.de> <20050905180005.GA3776@stusta.de> <20050905184740.GF7403@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905184740.GF7403@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 02:47:40PM -0400, Jakub Jelinek wrote:
> On Mon, Sep 05, 2005 at 08:00:05PM +0200, Adrian Bunk wrote:
> > It isn't the same, but "static inline" is the correct variant.
> > 
> > "extern inline __attribute__((always_inline))" (which is what
> > "extern inline" is expanded to) doesn't make sense.
> 
> It does make sense and is different from
> static inline __attribute__((always_inline)).
> Try:
> static inline __attribute__((always_inline)) void foo (void) {}
> void (*fn)(void) = foo;
> vs.
> extern inline __attribute__((always_inline)) void foo (void) {}
> void (*fn)(void) = foo;
> In the former case, GCC will emit the out of line static copy of foo
> if you take its address, in the latter case either you provide foo
> function by other means, or you get linker error.

And we need the former case because in the kernel we do not have 
out-of-line variants of the inline functions.

> 	Jakub

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

