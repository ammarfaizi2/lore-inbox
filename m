Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTJ1MYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbTJ1MYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:24:18 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:54432 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263937AbTJ1MYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:24:16 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Tue, 28 Oct 2003 12:53:38 +0200
User-Agent: KMail/1.5.4
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <200310271537.30435.ioe-lkml@rameria.de> <20031027154309.GB19711@gtf.org>
In-Reply-To: <20031027154309.GB19711@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310281153.38244.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 October 2003 16:43, Jeff Garzik wrote:
> On Mon, Oct 27, 2003 at 04:37:30PM +0200, Ingo Oeser wrote:
> > On Saturday 25 October 2003 21:17, Jeff Garzik wrote:
> > > Graphics processors are growing more general, too -- moving towards
> > > generic vector/data processing engines.  I bet you'll see an optimal
> > > model emerge where you have some sort of "JIT" for GPU microcode in
> > > userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT,
> > > which in turn pipelines data and microcode commands to the GPU kernel
> > > driver.
> >
> > These "JIT" is needed also for another reason:
> >
> > 	There are contraints for GPU commands and the pipelines need to
> > 	be modelled, like CPU piplines are modelled in a compiler. But
> > 	more like the pipelines of some early long instruction word
> > 	processors, where issuing to a used pipeline will cause random
> > 	behavior and crashes. So the JIT doesn't should also emit
> > 	synchronization points.
> >
> > With this JIT in place, there need to be just some hardware description
> > files (backends) and some API (GL, DirectX, X) description files
> > (frontends).
>
> I agree 60%  ;-)   This JIT emits GPU-specific microcode, so it should
> lean towards being hardware-dependent.  Speed and efficiency IMO demand
> that.
>
> Looking at existing, open-source CPU JITs, there are certainly general
> pieces and CPU-specific pieces.  But for GPUs, I think the best method
> is to start at the more-GPU-specific end of the spectrum, and _evolve_
> towards a more general solution, as hardware needs dictate.

Yes, you are partially right. The GCC project had already the problem
that they startet too simple with their pipeline management and had to
redesign it. 

If the kernel framework will not suffice the vendor needs (e.g. they
don't win in the benchmark, just because we cannot model their
hardware), it will be simply not used and we'll get just another nvidia
like driver.

But maybe I've read to much GCC internals recently, so I favor machine
descriptions and stateful pipeline descriptions for this ;-)

Your key argument still holds: This is just taking a instruction/data stream
from multiple sources and mapping it to another one with multiple
data/instruction sinks -> JIT.

> I followed GGI for a while.  Trying to be all things to all people was
> their principle mistake.  As Pat Morita said in Karate Kid,
> "Focus, Daniel-san!"  Be specific before general.

I noticed that it's ok to keep the design in mind, even in the comments,
but it never proved good to me to keep the design in dead code and
useless layers.

So I guess, we agree here ;-)


