Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVAMRfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVAMRfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVAMRet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:34:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:58555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261335AbVAMReU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:34:20 -0500
Date: Thu, 13 Jan 2005 09:33:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105632757.4624.59.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> 
 <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>
  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
 <1105632757.4624.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Alan Cox wrote:
>
> On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:
> > It wouldn't be a global flag. It's a per-process flag. For example, many 
> > people _do_ need to execute binaries in their home directory. I do it all 
> > the time. I know what a compiler is.
> 
> noexec has never been worth anything because of scripts. Kernel won't
> load that binary, I can write a script to do it.

Scripts can only do what the interpreter does. And it's often a lot harder
to get the interpreter to do certain things. For example, you simply
_cannot_ get any thread race conditions with most scripts out there, nor 
can you generally use magic mmap patterns.

Am I claiming that disallowing self-written ELF binaries gets rid of all 
security holes? Obviously not. I'm claiming that there are things that 
people can do that make it harder, and that _real_ security is not about 
trusting one subsystem, but in making it hard enough in many independent 
ways that it's just too effort-intensive to attack.

It's the same thing with passwords. Clearly any password protected system
can be broken into: you just have to guess the password. It then becomes a
matter of how hard it is to "guess" - at some point you say a password is
secure not because it is a password, but because it's too _expensive_ to
guess/break.

So all security issues are about balancing cost vs gain. I'm convinced
that the gain from openness is higher than the cost. Others will disagree.  

		Linus
