Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTJ0Psj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTJ0Psi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:48:38 -0500
Received: from havoc.gtf.org ([63.247.75.124]:11701 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262960AbTJ0Psh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:48:37 -0500
Date: Mon, 27 Oct 2003 10:43:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031027154309.GB19711@gtf.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <200310271537.30435.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310271537.30435.ioe-lkml@rameria.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 04:37:30PM +0200, Ingo Oeser wrote:
> On Saturday 25 October 2003 21:17, Jeff Garzik wrote:
> > Graphics processors are growing more general, too -- moving towards
> > generic vector/data processing engines.  I bet you'll see an optimal
> > model emerge where you have some sort of "JIT" for GPU microcode in
> > userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT,
> > which in turn pipelines data and microcode commands to the GPU kernel
> > driver.
> 
> These "JIT" is needed also for another reason: 
> 
> 	There are contraints for GPU commands and the pipelines need to
> 	be modelled, like CPU piplines are modelled in a compiler. But
> 	more like the pipelines of some early long instruction word
> 	processors, where issuing to a used pipeline will cause random
> 	behavior and crashes. So the JIT doesn't should also emit
> 	synchronization points. 
> 
> With this JIT in place, there need to be just some hardware description
> files (backends) and some API (GL, DirectX, X) description files
> (frontends).

I agree 60%  ;-)   This JIT emits GPU-specific microcode, so it should
lean towards being hardware-dependent.  Speed and efficiency IMO demand
that.

Looking at existing, open-source CPU JITs, there are certainly general
pieces and CPU-specific pieces.  But for GPUs, I think the best method
is to start at the more-GPU-specific end of the spectrum, and _evolve_
towards a more general solution, as hardware needs dictate.

In other terms, let the hardware drive the JIT design and evolution, and
don't over-design for a future that may never come.  That was part of
GGI's problem, IMO.


> Now we just need some funding for that and the datasheets. Then it's
> doable.

Yep ;-)


> I see just one showstopper: Cheating in benchmarks isn't possible anymore.
> 
> PS: That's basically the GGI approach taken further.

I followed GGI for a while.  Trying to be all things to all people was
their principle mistake.  As Pat Morita said in Karate Kid,
"Focus, Daniel-san!"  Be specific before general.

	Jeff



