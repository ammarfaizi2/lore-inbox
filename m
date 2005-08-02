Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVHBEgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVHBEgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 00:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVHBEgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 00:36:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261364AbVHBEgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 00:36:20 -0400
Date: Mon, 1 Aug 2005 21:35:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <1122956713.6338.19.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0508012134050.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> 
 <42EDDB82.1040900@yahoo.com.au>  <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
  <42EECC1F.9000902@yahoo.com.au>  <Pine.LNX.4.58.0508012039120.3341@g5.osdl.org>
 <1122956713.6338.19.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Nick Piggin wrote:
> 
> Any chance you can change the __follow_page test to account for
> writeable clean ptes? Something like
> 
> 	if (write && !pte_dirty(pte) && !pte_write(pte))
> 		goto out;
> 
> And then you would re-add the set_page_dirty logic further on.

Hmm.. That should be possible. I wanted to do the simplest possible code 
sequence, but yeah, I guess there's nothing wrong with allowing the code 
to dirty the page.

Somebody want to send me a proper patch? Also, I haven't actually heard 
from whoever actually noticed the problem in the first place (Robin?) 
whether the fix does fix it. It "obviously does", but testing is always 
good ;)

		Linus
