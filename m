Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUETTfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUETTfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUETTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:35:45 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:18703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265219AbUETTfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:35:39 -0400
Date: Thu, 20 May 2004 20:35:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Message-ID: <20040520203532.A11902@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de> <16556.19979.951743.994128@napali.hpl.hp.com> <20040519234106.52b6db78.davem@redhat.com> <16556.65456.624986.552865@napali.hpl.hp.com> <20040520120645.3accf048.akpm@osdl.org> <16557.1651.307484.282000@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16557.1651.307484.282000@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Thu, May 20, 2004 at 12:26:43PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 12:26:43PM -0700, David Mosberger wrote:
> Andrew,
> 
> Below is a patch that tries to sanitize the dropping of unneeded
> system-call stubs in generic code.  In some instances, it would be
> possible to move the optional system-call stubs into a library routine
> which would avoid the need for #ifdefs, but in many cases, doing so
> would require making several functions global (and possibly exporting
> additional data-structures in header-files).  Furthermore, it would
> inhibit (automatic) inlining in the cases in the cases where the stubs
> are needed.  For these reasons, the patch keeps the #ifdef-approach.
> 
> This has been tested on ia64 and there were no objections from the
> arch-maintainers (and one positive response).  The patch should be
> safe but arch-maintainers may want to take a second look to see if
> additional __ARCH_OMIT_foo macros should be turned on for their
> architecture (I'm quite sure that's the case, but I wanted to play it
> safe and only preserved the status-quo in that regard).

IMHO this is exactly the wrong way around.  It should be __ARCH_WANT_*
or something like that so new architectures don't carry the old garbage
around by default.  There's far too many new architectures keeping old
syscalls by accident.

