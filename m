Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSD1WKJ>; Sun, 28 Apr 2002 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314527AbSD1WKJ>; Sun, 28 Apr 2002 18:10:09 -0400
Received: from dsl-213-023-040-044.arcor-ip.net ([213.23.40.44]:36749 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314514AbSD1WKI>;
	Sun, 28 Apr 2002 18:10:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Sun, 28 Apr 2002 00:10:20 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E171aOa-0001Q6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 April 2002 20:27, Russell King wrote:
> Hi,
> 
> I've been looking at some of the ARM discontigmem implementations, and
> have come across a nasty bug.  To illustrate this, I'm going to take
> part of the generic kernel, and use the Alpha implementation to
> illustrate the problem we're facing on ARM.
> 
> I'm going to argue here that virt_to_page() can, in the discontigmem
> case, produce rather a nasty bug when used with non-direct mapped
> kernel memory arguments.

It's tough to follow, even when you know the code.  While cooking my
config_nonlinear patch I noticed the line you're concerned about and
regarded it with deep suspicion.  My patch does this:

-               page = virt_to_page(__va(phys_addr));
+               page = phys_to_page(phys_addr);

And of course took care that phys_to_page does the right thing in all
cases.

<plug>
The new config_nonlinear was designed as a cleaner, more powerful
replacement for all non-numa uses of config_discontigmem.
</plug>

-- 
Daniel
