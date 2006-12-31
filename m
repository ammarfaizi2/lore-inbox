Return-Path: <linux-kernel-owner+w=401wt.eu-S933109AbWLaKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbWLaKAU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 05:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933110AbWLaKAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 05:00:20 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2813 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933109AbWLaKAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 05:00:19 -0500
Date: Sun, 31 Dec 2006 10:00:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: arjan@infradead.org, torvalds@osdl.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061231100007.GC1702@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>, arjan@infradead.org,
	torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, akpm@osdl.org
References: <20061230.212338.92583434.davem@davemloft.net> <20061231092318.GA1702@flint.arm.linux.org.uk> <1167557242.20929.647.camel@laptopd505.fenrus.org> <20061231.014756.112264804.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061231.014756.112264804.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 01:47:56AM -0800, David Miller wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> Date: Sun, 31 Dec 2006 10:27:22 +0100
> > > However, it's not only FUSE which is suffering - direct-IO also doesn't
> > > work. 
> > 
> > for direct-IO the kernel won't touch the data *at all*... (that's the
> > point ;) 
> > 
> > is it still an issue then?
> 
> It can be an issue with virtual caches if the "I/O" is done
> using cpu loads and stores, but we should be handling that
> with explicit flushing anyways.
> 
> The core of the problem is that ARM doesn't look for the user
> mappings for anonymous pages when flush_dcache_page() is invoked.
> I think as a temporary fix it could walk the RMAP list and
> use that to find the user virtual mappings.  Would that work
> Russel?

I'm willing to do that - and I guess this means we can probably do this
instead of walking the list of VMAs for the shared mapping, thereby
hitting both anonymous and shared mappings with the same code?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
