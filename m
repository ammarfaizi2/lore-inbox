Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUKCAXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUKCAXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKCAXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:23:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:26297 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261295AbUKBXnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:43:04 -0500
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411021406010.2187@ppc970.osdl.org>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
	 <20041101221336.5f6d8534.akpm@osdl.org>
	 <1099432625.23845.93.camel@pants.austin.ibm.com>
	 <Pine.LNX.4.58.0411021406010.2187@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 10:35:00 +1100
Message-Id: <1099438500.20295.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That said, maybe the problem is that we shouldn't even get far enough into 
> the fork() logic to ever get into a new MMU context if driver_init ends up 
> being called before we're ready. 

Agreed. I chatted with Andrew about this, and I think we need
call_usermodehelper to be in a "plugged" state during boot, where it
queues up events but doesn't exec's userland. It remains to be decided
at what point during boot (during initcalls ? after initcalls) we can
"unplug" it tho...

I think it's definitely bogus to try to run userland in the middle of
arch_initcall's.... 

We need this plug/unplug logic (as I wrote separately to linux-pm) for
suspend as well, since we can't affort calling userlands once we have
started suspending devices (and frozen userland).

Ben.


