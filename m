Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVIUUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVIUUTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVIUUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:19:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964809AbVIUUTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:19:04 -0400
Date: Wed, 21 Sep 2005 13:17:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: raybry@mpdtxmail.amd.com, dan@debian.org, johnstul@us.ibm.com, ak@suse.de,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore
 cpus have synced TSCs
Message-Id: <20050921131713.06787aa1.akpm@osdl.org>
In-Reply-To: <20050921150404.GD12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
	<1127242785.11080.20.camel@cog.beaverton.ibm.com>
	<20050921040342.GA7175@nevyn.them.org>
	<200509211015.09356.raybry@mpdtxmail.amd.com>
	<20050921150404.GD12810@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wed, Sep 21, 2005 at 10:15:08AM -0500, Ray Bryant wrote:
> > On Tuesday 20 September 2005 23:03, Daniel Jacobowitz wrote:
> > 
> > >
> > > FYI, at least I have reproduced this without powernow loaded.
> > 
> > There are cases that we are aware of where the TSC will count slower while the 
> > processor is halted.    This can make TSC's get out of sync on dual cores.

You mean a single `hlt' instruction?   I guess that rules out resyncing them.

> Ok thanks for the confirmation. I guess John's patch is ok then.
> Drawback is much slower to extremly slow gettimeofday  (depending
> if the chipset/BIOS has usable HPET, most seem not to) 

That's a really big drawback.   Will this affect many CPU types?

If the user was prepared to use `idle=poll' then they could get their fast
gettimeofday() back, perhaps.

