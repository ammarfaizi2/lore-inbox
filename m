Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318888AbSHEV7I>; Mon, 5 Aug 2002 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318890AbSHEV7I>; Mon, 5 Aug 2002 17:59:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318888AbSHEV7I>; Mon, 5 Aug 2002 17:59:08 -0400
Date: Mon, 5 Aug 2002 23:02:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mporter@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Message-ID: <20020805230241.D16793@flint.arm.linux.org.uk>
References: <20020805131740.A2433@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020805131740.A2433@baldur.yggdrasil.com>; from adam@yggdrasil.com on Mon, Aug 05, 2002 at 01:17:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 01:17:40PM -0700, Adam J. Richter wrote:
> 	I want to replace all statements in the kernel of the form
> BUG_ON(condition1 || condition2) with:
> 
> 			BUG_ON(condition1);
> 			BUG_ON(condition2);

Why?  In the case below, its one logical error (value out of range).
The register dump tells you more information.  In fact, I don't care
which side of less than 1 or greater than 4 pin actually is.  It's
indicating a bug in the PCI subsystem either way, and the analysis
is the same in either case.

> 	I was recently bitten by a very sporadic BUG_ON(cond1 || cond2)
> statement and was quite annoyed at the greatly reduced opportunity to
> debug the problem.  Make these changes and someone who experiences
> the problem may be able to provide slightly more useful information.

This would make sense of the two conditions were unrelated to each
other.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

