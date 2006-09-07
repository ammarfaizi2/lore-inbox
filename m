Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWIGOZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWIGOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWIGOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:25:56 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:56593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751477AbWIGOZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:25:55 -0400
Date: Thu, 7 Sep 2006 15:25:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907142547.GD29532@flint.arm.linux.org.uk>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <20060907063049.GA15029@flint.arm.linux.org.uk> <20060907102740.GH25473@stusta.de> <20060907114358.GA26551@flint.arm.linux.org.uk> <A93564A8-3F3A-4BA3-9557-F3D75BE59052@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A93564A8-3F3A-4BA3-9557-F3D75BE59052@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 10:03:16AM -0400, Kyle Moffett wrote:
> On Sep 07, 2006, at 07:43:58, Russell King wrote:
> >On Thu, Sep 07, 2006 at 12:27:40PM +0200, Adrian Bunk wrote:
> >>And I'm getting bashed for sendind a patch to revert it "only" to  
> >>linux-kernel...
> >
> >As far as your argument that the kernel is not a hosted  
> >environment, that's debatable (as you're finding out).
> >
> >If we decide that we want the compiler to treat our source as if it  
> >were a hosted environment, and we provide sufficient implementation  
> >of a conforming nature of a hosted environment then that is our  
> >perogative to do so.  That is a decision that we are entirely free  
> >to make.  By doing so, we take on the responsibility to provide  
> >whatever is required for a hosted environment as opposed to the  
> >more limited functionality of a freestanding environment.
> 
> Ick, can anybody be persuaded to post actual effective code changes?   

I've already specified the changes on ARM, and suggested a fix for
them - but that got poo-poo'd.  I said:

On Wed, Aug 30, 2006 at 07:39:05PM +0100, Russell King wrote:
> Looking at the effect of -ffreestanding on ARM, it appears that on one
> hand, the overall image size is reduced by 0.016% but we end up with worse
> code - eg, strlen() of the same string in the same function evaluated
> multiple times vs once without -ffreestanding.
>
> The difference probably comes down to the lack of __attribute__((pure))
> on our string functions in linux/string.h.
>
> If we are going to go for -ffreestanding, we need to fix linux/string.h
> in that respect _first_.

So the effective code changes you ask for are: "multiple calls to
standard library functions that would not otherwise be made without
-ffreestanding".

Hence, for -ffreestanding to be acceptable to me, we need to fix
linux/string.h _first_.  That's really all I'm asking for but apparantly
that's too much to ask for.

It's not realistic to post the actual code changes because virtually every
line is different - due to differences in the register allocation caused
by the variations in code generation.  Hence, to compare it properly it's
a painstaking line by line read of each to understand what's going on and
manual compare.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
