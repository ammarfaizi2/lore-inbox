Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTGOG5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTGOG5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:57:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:7950 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264067AbTGOG5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:57:16 -0400
Date: Tue, 15 Jul 2003 03:00:43 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       efault@gmx.de, felipe_alfaro@linuxmail.org
Subject: Re: [PATCH] N1int for interactivity
In-Reply-To: <20030714205915.5a4c8d16.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0307150254390.32541@montezuma.mastecende.com>
References: <200307151355.23586.kernel@kolivas.org> <20030714205915.5a4c8d16.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Andrew Morton wrote:

> >  	base = monotonic_base;
> > -	read_unlock_irq(&monotonic_lock);
> > +	read_unlock_irqrestore(&monotonic_lock, flags);
> >  
> >  	/* Read the Time Stamp Counter */
> 
> Why do we need to take a global lock here?  Can't we use
> get_cycles() or something?

I think that'll break even on some x86 boxes if we used get_cycles. I do 
wonder however why we need that lock, i see x86/64 uses seqlock at least. 
Although i can't vouch for whether that would have an adverse affect here. 
I presume Stultz would know.

> Have all the other architectures been reviewed to see if they need this
> change?

No one else appears to have monotonic_clock, this would break every other 
arch out there.

-- 
function.linuxpower.ca
