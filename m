Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUF1Qxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUF1Qxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUF1Qxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:53:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9990 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265080AbUF1Qxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:53:30 -0400
Date: Mon, 28 Jun 2004 17:53:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG FIX] [PATCH] fork_init() max_low_pfn fixes potential OOM bug on big highmem machine
Message-ID: <20040628175325.B9214@flint.arm.linux.org.uk>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <40E03F71.8010902@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40E03F71.8010902@greatcn.org>; from coywolf@greatcn.org on Mon, Jun 28, 2004 at 11:55:29PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 11:55:29PM +0800, Coywolf Qi Hunt wrote:
> <http://localhost/lxr/ident?i=start_kernel>Hello all,
> 
> On machine with 16G(or 8G if 4k stacks) or more memory, high max_threads 
> could let system run out of low memory.
> This patch decides max_threads by the amount of low memory instead of 
> the total physical memory.
> Systems without high memory would not be affected.

This is wrong - max_low_pfn can be high on systems where physical RAM
doesn't start at address 0.  Such is very common on ARM platforms,
where RAM is located at 0xa0000000 or 0xc0000000 physical, which
leads to any calculation based upon max_low_pfn to believe we have
more than 3GB of RAM when we may only have 64MB or so.

I think we may need a num_lowpages for this...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
