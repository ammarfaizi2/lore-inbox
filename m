Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWI3WZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWI3WZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWI3WZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:25:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59372 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751464AbWI3WZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:25:00 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sun, 1 Oct 2006 00:23:23 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200610010002.46634.ak@suse.de> <20060930221005.GA20839@elte.hu>
In-Reply-To: <20060930221005.GA20839@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010023.23479.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 00:10, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > Why not just add the simple validation?
> > > 
> > > A kernel stack is one page in size. If you move to another page, you 
> > > terminate. It's that simple.
> > 
> > No, it's not. On x86-64 it can be three or more stacks nested in 
> > complicated ways (process stack, interrupt stack, exception stack) The 
> > exception stack can happen multiple times.
> 
> it could be cleanly handled though: in June i suggested to use the 
> next-stack pointers at the end of exception pages. 

Yes, but then you couldn't validate it like Linus asked for.
Also we've had cases where this information was corrupted

(e.g. when RSP starts somewhere completely bogus) 

> The only current  
> complexity here is that the 'linking' of exception pages is non-uniform, 
> it depends on the type of page. That's largely why that complex 
> statemachine had to be implemented, to match up the type of the page. 
> Since those pointers are put there by us, there's no real reason why we 
> couldnt standardize them.

Also how would you know in what kind of stack you are to select the right
check mask (since exception  stacks are larger than 8K)?  You would also need make 
unvalidated assumptions again.

The unwinder already does stronger validation than any of this.

That particularly case here was a hole in the fallback logic that got
actually fixed before 2.6.18 (not it was a -rc3 or so) 

-Andi

