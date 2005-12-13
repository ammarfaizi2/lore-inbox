Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVLMDS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVLMDS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVLMDS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:18:28 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45707 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932390AbVLMDS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:18:28 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx,
       arjan@infradead.org, hch@infradead.org, akpm@osdl.org,
       torvalds@osdl.org, David Howells <dhowells@redhat.com>
In-Reply-To: <439E38A4.30204@rtr.ca>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <439E38A4.30204@rtr.ca>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 22:17:54 -0500
Message-Id: <1134443874.24145.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 21:57 -0500, Mark Lord wrote:
>  > (5) Redirects the following to apply to the new mutexes rather than the
>  >     traditional semaphores:
>  >
>  >	down()
>  >	down_trylock()
>  >	down_interruptible()
>  >	up()
> 
> This will BREAK a lot of out-of-tree stuff if merged.
> 
> So please figure out some way to hang a HUGE banner out there
> so that the external codebases know they need updating.
> 
> The simplest way would be to NOT re-use the up()/down() symbols,
> but rather to either keep them as-is (counting semaphores),
> or delete them entirely (so that external code *knows* of the change).

Actually, up and down don't imply mutex at all.  So maybe it would be
better to keep up and down as normal semaphores, rename what you want to
mutex_lock / mutex_unlock which makes it obvious what it is, and then
you can go through and find all the semaphores that are being used as
mutexes (or is that mutices?) and make the change more incrementally.

-- Steve


