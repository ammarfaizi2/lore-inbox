Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVAJAoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVAJAoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAJAoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:44:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261839AbVAJAnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:43:20 -0500
Date: Mon, 10 Jan 2005 01:43:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050110004313.GB1483@stusta.de>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:19:09PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 9 Jan 2005, Arjan van de Ven wrote:
> >
> > Instead of fixing this inconsistency, I decided to remove it entirely,
> > explicit memcpy() and memmove() are prefered anyway (welcome to the 1990's)
> > and nothing in the kernel is using these functions, so this saves code size
> > as well for everyone.
> 
> The problem is that at least some gcc versions would historically generate
> calls to "bcopy" on alpha for structure assignments. Maybe it doesn't any
> more, and no such old gcc versions exist any more, but who knows?
>...

include/asm-alpha/string.h says:

  /*
   * GCC of any recent vintage doesn't do stupid things with bcopy.
   * EGCS 1.1 knows all about expanding memcpy inline, others don't.
   *
   * Similarly for a memset with data = 0.
   */


And Arjan's patch is pretty low-risk:

If it breaks on any architecture with any supported compiler (>= 2.95), 
it will break at compile time and there will pretty fast be reports of 
this breakage in which case it would be easy to revert his patch.


> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

