Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVBVI0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVBVI0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVBVI0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:26:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42196 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262245AbVBVI0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:26:31 -0500
Date: Tue, 22 Feb 2005 09:24:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, mort@wildopensource.com, pj@sgi.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050222082454.GA2401@elte.hu>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com> <20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org> <421A607B.4050606@sgi.com> <20050221144108.40eba4d9.akpm@osdl.org> <20050222075304.GA778@elte.hu> <20050222000710.5ad0d8c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222000710.5ad0d8c1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  . enable users to
> >  specify an 'allocation priority' of some sort, which kicks out the
> >  pagecache on the local node - or something like that.
> 
> Yes, that would be preferable - I don't know what the difficulty is
> with that.  sys_set_mempolicy() should provide a sufficiently good
> hint.

yes. I'm not against some flushing mechanism for debugging or test
purposes (it can be useful to start from a new, clean state - and as
such the sysctl for root only and depending on KERNEL_DEBUG is probably
better than an explicit syscall), but the idea to give a flushing API to
applications is bad i believe.

It is the 'easy and incorrect path' to a number of NUMA (and non-NUMA)
VM problems and i fear that it will destroy the evolution of VM
priority/placement/affinity APIs (NUMAlib, etc.).

At least making it sufficiently painful to use (via the originally
proposed root-only sysctl) could still preserve some of the incentive to
provide a clean solution for applications. 'Time to market' constraints
should not be considered when adding core mechanisms.

	Ingo
