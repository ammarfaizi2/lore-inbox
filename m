Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUCZVEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUCZVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:04:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20750 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261252AbUCZVED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:04:03 -0500
Date: Fri, 26 Mar 2004 21:03:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/22] Add __early_param for all arches
Message-ID: <20040326210355.D17638@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>, trini@kernel.crashing.org,
	linux-kernel@vger.kernel.org
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain> <20040324195502.00a5b148.akpm@osdl.org> <1080210253.29835.37.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1080210253.29835.37.camel@hades.cambridge.redhat.com>; from dwmw2@infradead.org on Fri, Mar 26, 2004 at 11:29:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 11:29:35AM +0000, David Woodhouse wrote:
> Drivers may require allocation (bootmem not slab). We want to run before
> that's feasible -- before 'mem=', by definition :)

It definitely wants to be after mem= since mem= modifies the memory
layout before bootmem is initialised (and its required to be parsed
before bootmem is initialised, so bootmem knows where the memory is.)

So we require, in order:

- mem= to be parsed
- bootmem to be initialised
- drivers which want to allocate from bootmem to then be
  initialised
- setup rest of the kernel
- final command line parsing

which gives us three stages of command line parsing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
