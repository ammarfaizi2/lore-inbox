Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbTIDSms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTIDSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:42:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265492AbTIDSmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:42:17 -0400
Date: Thu, 4 Sep 2003 11:42:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309041025470.6676-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309041139130.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Linus Torvalds wrote:
> 
> Oh. I see. Yes - it's accessing "vm_flags" with "MAP_SEM". That's really 
> wrong, since it's not even the same _domain_. 

How about something like this that at least gets it closer? It fixes the
fact that incorrect usage of PROT_SEM would allow users to set the
VM_SHARED bit behind the back of the OS, which sounds like a total
disaster and which can potentially confuse other parts of the VM.

It's not a very _pretty_ fix, but there really is no excuse for PROT_xxx
to not match VM_xxx for the three standard protection flags, so in that
sense it is the technically "sane" approach. We might want to just
simplify the mmap() code too..

		Linus

