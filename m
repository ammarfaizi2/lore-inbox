Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVBQIk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVBQIk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVBQIk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:40:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:35488 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262176AbVBQIku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:40:50 -0500
Subject: Re: [PATCH] Fix buf in zeromap_pud_range() losing virtual address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m1zmy31t79.fsf@muc.de>
References: <1108625191.5425.61.camel@gaston>  <m1zmy31t79.fsf@muc.de>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 19:40:10 +1100
Message-Id: <1108629610.5383.71.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 09:33 +0100, Andi Kleen wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >
> > zeromap_pud_range() is one of these page tables walking functions that
> > split the address into a base and an offset. It forgets to add back the
> > "base" when calling the lower level zeromap_pmd_range(), thus passing a
> > bogus virtual address. Most archs won't care, unless they do the above,
> > since the lower level can allocate a PTE page.
> 
> Hmm, there might be even more cases of this. I remember pondering
> it when I did the original 4 level work (sometimes we discard higher level 
> virtual address bits during walking)

I think I went through all of them, but I'll do again just in case ...

> > (Note: We are in _urgent_ need to consolidate all those page table
> > walking functions, they all do things in a subtely different way, with
> > different checks (sometimes redudant) and inconsitent with each other,
> > even within a given set of them. Hopefully, Nick has some work in
> > progress there).
> 
> I have. But it will just make them more similar, not completely consolidate
> them into an iterator, because that's too hard/ugly to do efficiently.

Hrm... I'm pretty sure half of the ones we have now are not fully
efficient, and they all do the exact same thing until they get all the
way down. The only real variation is wether to allocate on the way. Oh
well, nick has some bits too, I'll have a look at what he has already
done.

Ben.


