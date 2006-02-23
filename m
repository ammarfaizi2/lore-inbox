Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWBWQ7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBWQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWBWQ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:59:49 -0500
Received: from kanga.kvack.org ([66.96.29.28]:21888 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932212AbWBWQ7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:59:48 -0500
Date: Thu, 23 Feb 2006 11:54:44 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Message-ID: <20060223165444.GC27682@kvack.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230843020.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602230843020.3771@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 08:48:43AM -0800, Linus Torvalds wrote:
> For example, on x86(-64), memcpy() is mostly inlined for the interesting 
> cases. That's not always so. Other architectures will have things like the 
> page copying and clearing as _the_ hottest functions. Same goes for 
> architecture-specific things like context switching etc, that have 
> different names on different architectures.

On x86-64 the way gcc inlines memcpy() is rather broken, too.  If the 
kernel is compiled with -Os instead of -O2, gcc seems to always use 
rep ; movs or rep ; stos, which is substantially slower (factor of 10 
or more for some sizes -- a few parallel issued pipelined instructions 
vs tieing up the entire pipeline until the size of the move is known and 
dispatched) for small size data structures.  Each instance fixed was 
worth a few percent on the P4 when looking at lmbench's af_unix component.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
