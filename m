Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVERWkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVERWkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVERWkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:40:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:27559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262342AbVERWkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:40:00 -0400
Date: Wed, 18 May 2005 15:41:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
In-Reply-To: <Pine.LNX.4.61.0505181714330.3645@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0505181540060.18337@ppc970.osdl.org>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
 <1116448683.6572.43.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0505181714330.3645@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 May 2005, Rik van Riel wrote:
>
> On Wed, 18 May 2005, Arjan van de Ven wrote:
> > On Wed, 2005-05-18 at 15:57 -0400, Rik van Riel wrote:
> > > This (trivial) patch prevents the topdown allocator from allocating
> > > mmap areas all the way down to address zero.  It's not the prettiest
> > > patch, so suggestions for improvement are welcome ;)
> > 
> > it looks like you stop at brk() time.. isn't it better to just stop just 
> > above NULL instead?? Gives you more space and is less of an artificial 
> > barrier..
> 
> Firstly, there isn't much below brk() at all.

Guaranteed? What about executables that have fixed code addresses?

Sounds like a dubious approach, in other words.

If you want to, you could make the "how low do you go" thing be an
rlimit-like thing, but I really doubt "brk" makes much sense as the limit.

		Linus
