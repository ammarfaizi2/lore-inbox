Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWD1O5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWD1O5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWD1O5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:57:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030423AbWD1O5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:57:36 -0400
Date: Fri, 28 Apr 2006 07:54:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zach@vmware.com
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
In-Reply-To: <200604280829.29164.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0604280753290.3701@g5.osdl.org>
References: <200604272001.k3RK1dmX007637@hera.kernel.org> <200604280808.44496.ak@suse.de>
 <20060428062704.GH2909@sorel.sous-sol.org> <200604280829.29164.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Andi Kleen wrote:
> > 
> > I must be confused.  Doesn't that become a barrier() on UP?
> 
> No it was me who was confused sorry. Somehow i thought it was defined
> away for !SMP
> 
> (which would make sense because why would you want a compile barrier
> for a barrier that is only needed on SMP?) 

If the write barrier is needed on SMP, then UP needs a compiler barrier. 
Even UP has interrupts (and preemption) that can expose ordering of the 
interrupted code.

		Linus
