Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVBFNLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVBFNLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBFNLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:11:34 -0500
Received: from mail.suse.de ([195.135.220.2]:52889 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261209AbVBFNJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:09:35 -0500
Date: Sun, 6 Feb 2005 14:09:29 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206130929.GI30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <1107695097.22680.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107695097.22680.92.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:04:57PM +0100, Arjan van de Ven wrote:
> 
> > Hmm, I got a report that it doesn't work anymore with 
> > 2.6.11rcs on x86-64. I haven't looked  closely yet,
> > but it wouldn't surprise me if this change isn't also involved.
> 
> PT_GNU_STACK change is there since like 2.6.6 (and was put in by a suse person)
> To me that is a strong indication that you are wrong on your
> suspicion...

Nah, the change to break 32bit userland mmap/mprotect like this was only 
put in after 2.6.10. 

64bit userland on the other hand always honored PROT_EXEC, but 
before PT_GNU_STACK it would run by default with executable stack. 

Hmm, I admit that my patch will break this case too, but fixing
that (setting READ_IMPLIES_EXEC only for 32bit) 
would require more complicated changes that may not be appropiate
for 2.6.11. If it's deemed appropiate I could do such a patch too
though.

-Andi
