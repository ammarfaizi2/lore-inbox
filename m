Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265112AbRFVHeT>; Fri, 22 Jun 2001 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265313AbRFVHeJ>; Fri, 22 Jun 2001 03:34:09 -0400
Received: from ns.suse.de ([213.95.15.193]:21517 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265112AbRFVHeB>;
	Fri, 22 Jun 2001 03:34:01 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <Pine.GSO.4.21.0106211931180.209-100000@weyl.math.psu.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Jun 2001 09:33:54 +0200
In-Reply-To: Alexander Viro's message of "22 Jun 2001 01:41:42 +0200"
Message-ID: <ouppubx6k9p.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Thu, 21 Jun 2001, Rusty Russell wrote:
> 
> > Disagree.  A significant percentage of the netfilter bugs have been
> > SMP only (the whole thing is non-reentrant on UP).
> 
> I really doubt it. <looking through the thing> <raised brows>
> Well, if you use GFP_ATOMIC for everything... grep...
> Erm... AFAICS, you call create_chain() with interrupts disabled
> (under write_lock_irq_save()). Unless I'm _very_ mistaken,
> kmalloc(..., GFP_KERNEL) is a Bad Thing(tm) in that situation.
> And create_chain() leads to it.

That's the old ipchains code; if it's buggy it's likely buggy in 2.2 
too. In fact 2.2 ip_fw.c has exactly the same problem (and also a panic
on OOM) 

iptables is supposed to be somewhat better (that's the new code), with
cleaner locking.

-Andi, wondering why the Stanford Checker didn't catch that.

P.S.: Could you please always change the subject in future when going
from slashdot niveau material to real kernel bugs on l-k. thanks.
