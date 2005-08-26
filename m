Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVHZD5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVHZD5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 23:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVHZD5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 23:57:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751485AbVHZD5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 23:57:00 -0400
Date: Thu, 25 Aug 2005 20:56:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Rik van Riel <riel@redhat.com>, Ray Fucillo <fucillo@intersystems.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <430E6FD4.9060102@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Aug 2005, Nick Piggin wrote:
> 
> > Skipping MAP_SHARED in fork() sounds like a good idea to me...
> > 
> 
> Indeed. Linus, can you remember why we haven't done this before?

Hmm. Historical reasons. Also, if the child ends up needing it, it will 
now have to fault them in.

That said, I think it's a valid optimization. Especially as the child 
_probably_ doesn't need it (ie there's at least some likelihood of an 
execve() or similar).

		Linus
