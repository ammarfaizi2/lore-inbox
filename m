Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUHFVXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUHFVXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUHFVXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:23:35 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:56192 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268342AbUHFVWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:22:03 -0400
Date: Fri, 6 Aug 2004 23:21:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806212145.GG30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200407311741.12406.david-b@pacbell.net> <1091324075.7389.41.camel@gaston> <200408020938.17593.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408020938.17593.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Maybe a better approach would be to describe the required features to
> > > > the drivers rather than encoding them in a single integer. Rather
> > > > like passing a request that states "lowest power level with device state
> > > > retained, must not do DMA, enable remote wake up"
> > > 
> > > A pointer to some sort of struct could be generic and typesafe;
> > > better than an integer or enum.
> > 
> > Well... if it gets that complicated, drivers will get it wrong...
> 
> It's already broken though!   Type-safe calls might at least
> trigger compiler warning when folk do things like, for example,
> pass a system power policy where a device power policy is
> needed.  So long as the API uses integers (or enums), it falls
> in the category of "oversimplified, impossible to get right".
> 
> But such a massive API change sounds to me like a 2.7
> thing.

Good.. So, for 2.6, can we agree on doing "enum xxx" thing? That at
least serves as a documentation. We could teach sparse to check for
it... (Anything that does 

enum foo x;
enum bar y = x;

is broken. If gcc does not warn about this, we should fix gcc...)

I believe "enum system_state" passed around, even to PCI drivers, and 
enum pci_state to_pci_state(enum system_state) helper is the right
thing to do for 2.6. Can we agree on that? 
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
