Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWBYOdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWBYOdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWBYOdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:33:24 -0500
Received: from kanga.kvack.org ([66.96.29.28]:1979 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1161002AbWBYOdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:33:23 -0500
Date: Sat, 25 Feb 2006 09:28:14 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060225142814.GB17844@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140841250.2587.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 08:20:50PM -0800, Bryan O'Sullivan wrote:
> On some platforms, a regular wmb() is not sufficient to guarantee that
> PCI writes have been flushed to the bus if write combining is in effect.
> 
> This change introduces a new macro, wc_wmb(), that makes this guarantee.
> 
> It does so by way of a new header file, <linux/system.h>.  This header
> can be a site for oft-replicated code from <asm-*/system.h>, but isn't
> just yet.
> 
> We also define a version of wc_wmb() with the required semantics
> on x86_64.

This does not do what you're trying to accomplish.  sfence has no impact 
on the flushing of the write combining buffers -- they're normally flushed 
after a few cycles of no subsequent merges.  If it is really necessary to 
flush such a write, you will have to do a read from the target PCI device 
(well, bus would do).

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
