Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKCC0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKCC0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUKCC0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:26:24 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:40867 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261329AbUKCC0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:26:22 -0500
Date: Wed, 3 Nov 2004 03:26:06 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041103022606.GI3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418837D1.402@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 05:43:45PM -0800, Dave Hansen wrote:
> Oh, crap.  I meant to clear ->mapped when change_attr(__pgprot(0)) was 
> done on it, and set it when it was changed back.  Doing that correctly 
> preserves the symmetry, right?

yes it should. I agree with Andrew a bitflag would be enough. I'd call
it PG_prot_none.

I realized if the page is in the freelist it's like if it's reserved,
since you're guaranteed there's no other pageattr working on it
(assuming every other pageattr is symmetric too, which we always depend
on). So I wonder why it's not symmetric already, despite the lack of
page->mapped. Would be nice to dump_stack when a __pg_prot(0) &&
page->mapped triggers.
