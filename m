Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUC1GYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 01:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUC1GYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 01:24:37 -0500
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:8832 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262062AbUC1GYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 01:24:33 -0500
Date: Sun, 28 Mar 2004 08:24:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ivan Godard <igodard@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
Message-ID: <20040328062422.GB307@elf.ucw.cz>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz> <066b01c41464$7e0ec9c0$fc82c23f@pc21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066b01c41464$7e0ec9c0$fc82c23f@pc21>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On So 27-03-04 17:32:06, Ivan Godard wrote:
> > > 1) had a large number of distinguishable address spaces
> > > 2) any running code had two of these (code and data environment) it
> could
> > > use arbitrarily, but access to addresses in others was arbitrarily
> protected
> > > 3) flat, unified virtual addresses (64 bit) so that pointers, including
> > > inter-space pointers, have the same representation in all spaces
> >
> > Hmm, will it be possible to have UML?
> 
> If by UML you mean Uniform Modelling Language, I don't understand where the
> protection model has any impact. UML models flow, permissions are somewhat
> superimposed, just like file permissions in a UML model on any
> machine.

I meant "User Mode Linux" == linux running under linux. Someone
probably has an URL.

> > > 9) Hardware interrupts are involuntary inter-space calls. They do not
> > > require locking (assuming the handler is re-entrant - and if not then
> only
> > > from themselves), nor task switch, nor disabling other interrupts. The
> > > handler runs in the stack of whoever got interrupted, which (depending
> on
> > > interrupt priorities) could be another interrupt, on an interrupt, ...
> on an
> > > app, all mutually protected.
> >
> > How do you implement ptrace if apps are protected from kernel?
> 
> Anybody can make all or part of themselves visible to anybody else. If you
> start up an app in your space, you can grant visibility to a debugger in
> another space. But this applies only to you. For example, suppose that your
> app calls a paranoid server DLL passing in a function, and the DLL in turn
> calls back your function. Then your stack will have a hunk of you (that you
> can see and expose to the debugger), then a hunk of DLL function activations
> (which are opaque to you AND the debugger unless you can talk the DLL into
> exposing itself), and then another hunk of you again (and again visible to
> you and the debugger). The DLL and you (and your debugger) are mutually
> protected.
> 
> To do this on a conventional system requires that the DLL runs as a server
> process, and getting it to do something for you requires a roundtrip through
> the dispatcher. For us it's a simple subroutine call, just as if the DLL
> were un-paranoid and had been linked into your code. Clearer?

Strange system.... If an application does not grant kernel access to
its space, how is kernel supposed to do its job? For example, that
"paranoid DLL" becomes unswappable, then?

If you have "enough" paranoid DLLs, you can then bring the machine
down due to lack of real memory :-).

> > > 10) Drivers can have their own individual space(s) distinct from those
> of
> > > the kernel and the apps. Buggy drivers cannot crash the kernel.
> >
> > Well... buggy drivers can usually program DMA to do crashing for them.
> 
> Nope. The DMA has the same permissions as the driver that starts it.

So normal PCI cards are not allowed, or do you have some kind of
IOMMU?

> > That would be pretty big rewrite...
> >
> > Anyway, I believe you *do* want linux on it, if only as a test load.
> 
> We definitely want Linux. The question is whether Linux will want the result
> of our port, or (in finer detail) what parts could we do in what way to be
> useful to other people.

If most changes are in arch/, it should be acceptable...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
