Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVBWSpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVBWSpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBWSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:45:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261531AbVBWSpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:45:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050223162225.GB10256@austin.ibm.com> 
References: <20050223162225.GB10256@austin.ibm.com>  <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <5316.1109158748@redhat.com> 
To: olof@austin.ibm.com (Olof Johansson)
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Feb 2005 18:44:56 +0000
Message-ID: <2036.1109184296@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@austin.ibm.com> wrote:

> > Alternately, you could just have do_page_fault() do:
> > 
> > 	while (!down_read_trylock(&current->mm->mmap_sem))
> > 		continue;
> > 
> > However, note that this can suffer from starvation due to a never ending
> > flow of mixed write-locks and read-locks on other CPUs. Unlikely, true,
> > but not impossible.
> 
> How can this help? 
> 
> The semaphore is held for reading by the thread that faulted in
> futex_wait() -> get_user(), so no writers will be let through. Until the
> writer has been let through, the down_read_trylock will never succeed
> either. No forward progress can be made even with the above loop.

You're right. The "writers" would have to spin instead.

David
