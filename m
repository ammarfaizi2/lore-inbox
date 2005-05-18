Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVERVQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVERVQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVERVQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:16:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262382AbVERVQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:16:21 -0400
Date: Wed, 18 May 2005 17:16:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
In-Reply-To: <1116448683.6572.43.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0505181714330.3645@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
 <1116448683.6572.43.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Arjan van de Ven wrote:
> On Wed, 2005-05-18 at 15:57 -0400, Rik van Riel wrote:
> > This (trivial) patch prevents the topdown allocator from allocating
> > mmap areas all the way down to address zero.  It's not the prettiest
> > patch, so suggestions for improvement are welcome ;)
> 
> it looks like you stop at brk() time.. isn't it better to just stop just 
> above NULL instead?? Gives you more space and is less of an artificial 
> barrier..

Firstly, there isn't much below brk() at all.  Secondly, do we
really want to fill the randomized hole between the executable
and the brk area with data ?

Thirdly, we do want to continue detecting NULL pointer dereferences
inside large structs, ie. dereferencing an element 700kB into some
large struct...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
