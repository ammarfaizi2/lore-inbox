Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVA2LjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVA2LjS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVA2Lhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:37:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262900AbVA2LhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:37:22 -0500
Date: Sat, 29 Jan 2005 11:37:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Philippe Robin <Philippe.Robin@arm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
Message-ID: <20050129113707.B2233@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Philippe Robin <Philippe.Robin@arm.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk> <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Jan 11, 2005 at 04:07:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:07:09PM -0800, Linus Torvalds wrote:
> On Tue, 11 Jan 2005, Russell King wrote:
> > Any responses on this?  Didn't get any last time I mailed this out.
> 
> I don't have any real objections. I'd like it verified that gcc can
> compile away all the overhead on the architectures that don't use the pfn, 
> since "page_to_pfn()" can be a bit expensive otherwise.. But I don't see 
> anything wrong with the approach.

Thanks for the response.  However, apart from Ralph, Paul and yourself,
it seems none of the other architecture maintainers care about this
patch - the original mail was BCC'd to the architecture list.  Maybe
that's an implicit acceptance of this patch, I don't know.

I do know that page_to_pfn() will generate code on some platforms which
don't require it due to them declaring flush_cache_page() as a function.
However, I assert that if they don't need this overhead, that's for them
to fix up.  I don't know all their quirks so it isn't something I can
tackle.

In other words, unless I actually receive some real help from the other
architecture maintainers on this to address your concerns, ARM version 6
CPUs with aliasing L1 caches (== >16K) will remain a dead dodo with
mainline Linux kernels.

(This mail BCC'd to the architecture list again in the vain hope that
someone will offer assistance.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
