Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVG1Txk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVG1Txk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVG1Tx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:53:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22029 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261468AbVG1TwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:52:20 -0400
Date: Thu, 28 Jul 2005 20:52:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050728205215.A10867@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <christoph@lameter.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050728025840.0596b9cb.akpm@osdl.org> <Pine.LNX.4.62.0507281006320.1262@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.62.0507281006320.1262@graphe.net>; from christoph@lameter.com on Thu, Jul 28, 2005 at 10:11:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 10:11:18AM -0700, Christoph Lameter wrote:
> On Thu, 28 Jul 2005, Andrew Morton wrote:
> >   The patches at present spit warnings or don't compile on lots of
> >   architectures.  x86, x86_64, ppc64 and ia64 are OK.
> 
> I have just sent a fix to you this morning when I got your messages. 
> Sadly I do not have access to the architectures that failed (arm, alpha 
> and ppc32) but the fix simply removes code that is not used for these 
> arches.

ARM can't support atomic page table operations as such - the Linux view
of the page table is separate from the hardware view, and there's some
CPU specific code which translates from the Linux view to the hardware
view.

Looking at the actual patches, particularly pte_xchg-and-pte_cmpxchg.patch
combined with the above, the ARM solution would be to go back to using
non-atomic operations here (since we can't do this atomically.)  Also,
since the MMU will only ever read from the page tables, I don't think
we need to play any games with clearing out ptes before we replace the
value.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
