Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272785AbTG3HEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272786AbTG3HEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:04:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41733 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272785AbTG3HEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:04:38 -0400
Date: Wed, 30 Jul 2003 09:11:31 +0200
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The well-factored 386
Message-ID: <20030730071131.GA6282@hh.idb.hist.no>
References: <03072809023201.00228@linux24> <20030728093245.60e46186.davem@redhat.com> <20030728194127.GA10673@mail.jlokier.co.uk> <20030729111423.GA5320@hh.idb.hist.no> <20030729161951.GA15889@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729161951.GA15889@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 05:19:51PM +0100, Jamie Lokier wrote:
> Helge Hafting wrote:
> > > The one thing that made it on-topic for me was his quiet suggestion
> > > that "forreal" mode interrupts are faster, and that it might, perhaps,
> > > be possible to modify a Linux kernel to run in that mode - to take
> > > advantage of the faster interrupts.
> > 
> > That would have to be a kernel for very special use.  The "forreal"
> > mode has protection turned off.  As far as I know, that
> > means any user process can take over the cpu as if
> > it was running in kernel mode.
> 
> There are quite a few embedded systems where that is ok, especially if
> performance is improved.
> 
> Also, I am not sure whether paging still works in "forreal" mode.  If
> it does, kernel memory could still be protected.  Not well enough for
> security, but enough to protect against programming errors.
> 
Paging works even in real mode, afaik. 386es used to emulate
"expanded" memory (a simple bank-switching thing for 286)
by going into protected mode, change the page tables, then
return to real mode with paging still enabled.

So you can probably use paging in "forreal" mode too. I believe
you only get the page table's memory mapping capabilities
though, I don't think you get protection of "kernel" pages
without protection enabled.  

You could still "hide" kernel memory by giving userspace another
page table, but that means page table switching on each
syscall which kills performance worse than interrupt handling
in protecxted mode.

Helge Hafting
