Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVDZUkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVDZUkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDZUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:38:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:4799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261660AbVDZUi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:38:29 -0400
Date: Tue, 26 Apr 2005 13:37:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, libor@topspin.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050426133752.37d74805.akpm@osdl.org>
In-Reply-To: <426EA220.6010007@ammasso.com>
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
	<20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com>
	<20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com>
	<20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org>
	<5264y9s3bs.fsf@topspin.com>
	<426EA220.6010007@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Roland Dreier wrote:
> 
>  > Yes, I agree.  If an app wants to register half a page and pass the
>  > other half to a child process, I think the only answer is "don't do
>  > that then."
> 
>  How can the app know that, though?  It would have to allocate I/O buffers with knowledge 
>  of page boundaries.  Today, the apps just malloc() a bunch of memory and pay no attention 
>  to whether the beginning or the end of the buffer shares a page with some other, unrelated 
>  object.  We may as well tell the app that it needs to page-align all I/O buffers.
> 
>  My point is that we can't just simply say, "Don't do that".  Some entity (the kernel, 
>  libraries, whatever) should be able to tell the app that its usage of memory is going to 
>  break in some unpredictable way.

Our point is that contemporary microprocessors cannot electrically do what
you want them to do!

Now, conceeeeeeiveably the kernel could keep track of the state of the
pages down to the byte level, and could keep track of all COWed pages and
could look at faulting addresses at the byte level and could copy sub-page
ranges by hand from one process's address space into another process's
after I/O completion.  I don't think we want to do that.

Methinks your specification is busted.
