Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUGBMRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUGBMRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGBMRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:17:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21431 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264265AbUGBMR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:17:29 -0400
Date: Fri, 2 Jul 2004 09:15:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040702071512.GA11709@elte.hu>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu> <20040630143850.GF29285@mail.shareable.org> <20040701014818.GE32560@mail.shareable.org> <20040701063237.GA16166@elte.hu> <20040701150430.GB5114@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701150430.GB5114@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> > -			if (pmd_val(*pmd) & _PAGE_NX)
> > -				printk(KERN_CRIT "kernel tried to access NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
> > -		}
> > -	}
> > -#endif
> > +	if (nx_enabled && (error_code & 16))
> > +		printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
> 
> According to AMD's manual, bit 4 of error_code means the fault was due
> to an instruction fetch.  It doesn't imply that it's an NX-protected
> page: it might be a page not present fault instead.  (The manual
> doesn't spell that out, it just says the bit is set when it's an
> instruction fetch).

you are right, it doesnt say it's an NX related fault.

I'll test this out and send a delta patch.

	Ingo
