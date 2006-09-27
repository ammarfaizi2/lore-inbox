Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030906AbWI0Vit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030906AbWI0Vit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030905AbWI0Vit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:38:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030903AbWI0Vis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:38:48 -0400
Date: Wed, 27 Sep 2006 14:38:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, akpm@osdl.org, jbeulich@novell.com
Subject: Re: [BUG] Oops on boot (probably ACPI related)
In-Reply-To: <200609272250.21925.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609271436310.3952@g5.osdl.org>
References: <200609271424.47824.eike-kernel@sf-tec.de>
 <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org> <Pine.LNX.4.64.0609271329080.3952@g5.osdl.org>
 <200609272250.21925.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Andi Kleen wrote:
> 
> It doesn't matter much because these days this stuff is all out of lined
> anyways and in a single function. And the dynamic branch predictor
> in all modern CPUs will usually cache the decision (unlocked) there.

Ahh, good point. Once there's only one copy, the branch predictor will get 
it right (and the code size won't much matter)

> > Are there any _real_ advantages to this broken unwinding code that has had 
> > more bugs that Windows XP?
> 
> I thought for a long time we didn't need it either, but these days with all 
> these callbacks in some parts of the kernel (driver model, others) and you 
> get a oops with 60+ entries it is just too much trouble to figure it out manually.

Ok, fair enough. I'll apply your fix (which in itself is obviously 
correct).

I just wanted to bring up the possibility that we should just remove the 
(fragile) unwinder.

But let's leave it for another day, if it keeps being problematic.

		Linus
