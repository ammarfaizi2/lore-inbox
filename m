Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVHVUO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVHVUO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVHVUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:14:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54751 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750902AbVHVUOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:14:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=uapcXsizkAN05ahiS9Am5oJUp1QAbPZkld9J4KLFXbgVBJa8ic2Vd1f15dIt5JfzJ7U2IOaqJ/8mZQghOwAOsLvRZwJcp1cNK7J6Pko6GByi40ltIz9Ra9Sp51SaUhJsyo8nXN6p7elTGt+ddyDJ3z/wOwgOBbHJMCsOfQE9Jro=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [patch 0/39] remap_file_pages protection support, try 2
Date: Mon, 22 Aug 2005 19:08:02 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Dike <jdike@addtoit.com>
References: <200508122033.06385.blaisorblade@yahoo.it.suse.lists.linux.kernel> <p733bpe3mk3.fsf@verdi.suse.de>
In-Reply-To: <p733bpe3mk3.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221908.03029.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 22:52, Andi Kleen wrote:
> Blaisorblade <blaisorblade@yahoo.it> writes:
> > Ok, I've been working for the past two weeks learning well the Linux VM,
> > understanding the Ingo's remap_file_pages protection support and its
> > various weakness (due to lack of time on his part), and splitting and
> > finishing it.

> I'm not sure remap_file_pages was ever intended to be more integrated.
> It pretty much always was a Oracle specific performance hack. The problem
> with making it more powerful is that it will become more invasive then
> (like your patchbomb shows)

(Note that it's probably even *too* subtly splitout).

> and that will make it a bigger maintenance 
> issue longer term and complicate all of VM. And it's probably not
> worth doing all that.

The reason for this work, this time, is for UML (it's not casual I'm working 
on it). However, it's true that what I implemented is actually more powerful 
than what's needed by UML.

It only needs (IIRC) to do void (i.e. PROT_NONE) mmaps, and then to remap from 
them changing both protections and file offset. And such mappings must 
support swapout.

This will replace the current use of mmap()/mprotect() done one page at a time 
(when the guest has more than 256 M we easily hit 
the /proc/sys/vm/max_map_count and must increase it).

I've gone implementing and fixing the general thing, including mappings where 
only the protections are changed but which are still linear.

Still, even without all this the patch will still be bigger than when it was 
in -mm last time (i.e. until 2.6.5-mm1), since that didn't handle swapout.

However, in terms of invasiveness, the changes needed to support the nonlinear 
mappings are way bigger than what's needed for protections, especially for 
nonlinear truncation.

> So in short I think it's better to keep it into its corner with minimum
> functionality and let it not expand to other parts.
Ok, I think this may be reasonable. However, for now I'm still finishing the 
full implementation, I'll start dropping pieces when we've decided what's 
needed.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
