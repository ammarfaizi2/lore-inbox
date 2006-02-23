Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWBWKek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWBWKek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWBWKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:34:40 -0500
Received: from mail.suse.de ([195.135.220.2]:21903 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750798AbWBWKej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:34:39 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: [PATCH] i386 double fault enhancements
References: <200602221159.08969.jbeulich@novell.com>
	<20060222143212.0eea2ab0.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 23 Feb 2006 11:34:36 +0100
In-Reply-To: <20060222143212.0eea2ab0.akpm@osdl.org>
Message-ID: <p73bqwy2wjn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Jan Beulich <jbeulich@novell.com> wrote:
> >
> > Make the double fault handler use CPU-specific stacks. Add some
> > abstraction to simplify future change of other exception handlers to go
> > through task gates. Change the pointer validity checks in the double
> > fault handler to account for the fact that both GDT and TSS aren't in
> > static kernel space anymore. Add a new notification of the event
> > through the die notifier chain, also providing some environmental
> > adjustments so that various infrastructural things work independent of
> > the fact that the fault and the callbacks are running on other then the
> > normal kernel stack.
> 
> Why?

Means that if you have two double faults in parallel they still 
work. Good for robustness under kernel bugs.

-Andi
