Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVKWQjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVKWQjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVKWQjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:39:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:53995 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932066AbVKWQjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:39:15 -0500
Date: Wed, 23 Nov 2005 17:39:06 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123163906.GF20775@brahms.suse.de>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132764133.7268.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:42:13PM +0000, Alan Cox wrote:
> On Mer, 2005-11-23 at 12:17 -0700, Andi Kleen wrote:
> > > +	/* Paranoia */
> > > +	asm volatile ("jmp 1f\n1:");
> > > +	mb();
> > 
> > That would be totally obsolete 386 era paranoia. If anything then use 
> > a CLFLUSH (but not available on all x86s) 
> 
> If you are patching code another x86 CPU is running you must halt the
> other processors and ensure it executes a serialzing instruction before
> it enters any patched code. 

Yes that is why the original alternative() mechanism always only
runs before the code is ever executed.

> How many kilobytes of tables do you add to the kernel to do this
> pointless stunt btw ?

I much prefer the MSR bit too. Unfortunately it doesn't exist
(or rather I bet it exists somewhere, just undocumented) on Intel 
systems.

-Andi
