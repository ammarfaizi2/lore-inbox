Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUKBWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUKBWMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUKBWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:12:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:57489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262224AbUKBWLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:11:14 -0500
Date: Tue, 2 Nov 2004 14:10:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
In-Reply-To: <1099432625.23845.93.camel@pants.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0411021406010.2187@ppc970.osdl.org>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com> 
 <20041101221336.5f6d8534.akpm@osdl.org> <1099432625.23845.93.camel@pants.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Nov 2004, Nathan Lynch wrote:
> 
> Using idr_get_new_above in init_new_context lets us get rid of an
> awkward init function which wasn't running early enough in boot
> anyway.

Ok, call me stupid, but what's the difference between

	idr_get_new(&mmu_context_idr, NULL, &index);

and

	idr_get_new_above(&mmu_context_idr, NULL, 0, &index);

because as far as I can tell, they are exactly the same.

They both just do a "idr_get_new_above_int(idp, ptr, 0)".

So I don't see why one would need an awkward init function, and the other
wouldn't..

That said, maybe the problem is that we shouldn't even get far enough into 
the fork() logic to ever get into a new MMU context if driver_init ends up 
being called before we're ready. 

		Linus
