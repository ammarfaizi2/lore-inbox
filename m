Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBWQ0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBWQ0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBWQ0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:26:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28141 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261230AbVBWQ0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:26:30 -0500
Date: Wed, 23 Feb 2005 10:22:26 -0600
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223162225.GB10256@austin.ibm.com>
References: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <5316.1109158748@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5316.1109158748@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:39:08AM +0000, David Howells wrote:
> Alternately, you could just have do_page_fault() do:
> 
> 	while (!down_read_trylock(&current->mm->mmap_sem))
> 		continue;
> 
> However, note that this can suffer from starvation due to a never ending flow
> of mixed write-locks and read-locks on other CPUs. Unlikely, true, but not
> impossible.

How can this help? 

The semaphore is held for reading by the thread that faulted in
futex_wait() -> get_user(), so no writers will be let through. Until the
writer has been let through, the down_read_trylock will never succeed
either. No forward progress can be made even with the above loop.


-Olof
