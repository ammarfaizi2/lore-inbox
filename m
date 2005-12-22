Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVLVRUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVLVRUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVLVRUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:20:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6578 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030221AbVLVRUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:20:23 -0500
Date: Thu, 22 Dec 2005 17:20:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222172019.GB6038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 10:34:18AM -0500, Nicolas Pitre wrote:
> I'm with Christoph here.  Please preserve my 
> arch_mutex_fast_lock/arch_mutex_fast_unlock helpers.  I did it that way 
> because the most important thing they bring is flexibility where it is 
> needed i.e. in architecture specific implementations.  And done that way 
> the architecture specific part is well abstracted with the minimum 
> semantics allowing flexibility in the implementation.
> 
> I insist on that because, even if ARM currently relies on the atomic 
> swap behavior, on ARMv6 at least this can be improved even further, but 
> a special implementation which is neither a fully qualified atomic 
> decrement nor an atomic swap is needed.  That's why I insist that you 
> should keep my arch_mutex_fast_lock and friends (rename them if you 
> wish) and remove __ARCH_WANT_XCHG_BASED_ATOMICS entirely.

I think one of us should so a new version based on that scheme and without
all the new atomic helpers, then we can compare it against the current
version.  I'll try to once I'll get some time.
