Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTEKRwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTEKRwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:52:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60750 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261821AbTEKRwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:52:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CaT <cat@zip.com.au>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <20030510025634.GA31713@averell>
	<20030510033504.GA1789@zip.com.au>
	<1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 12:01:57 -0600
In-Reply-To: <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m1bry9746i.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sad, 2003-05-10 at 04:35, CaT wrote:
> > On Sat, May 10, 2003 at 04:56:34AM +0200, Andi Kleen wrote:
> > > Extensive discussion by various experts on the discuss@x86-64.org
> > > mailing list concluded that the correct vector to restart an 286+ 
> > > CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
> > > but the first is correct.
> > 
> > Could this bug, by any chance, cause a system to shutdown instead of
> > rebooting? This is what happens to me at the moment but not each and
> > every time.
> 
> Unlikely. But try it and see 8)
> 
> At least some SMP boxes freak if you do a poweroff request on CPU != 0

As per the MP spec.  The system should reboot on the bootstrap cpu.
smp_processor_id() == 0 on x86.  apicid??

I have a patch for this as part my kexec stuff as the kernel freaks
when it doesn't start up on the bootstrap cpu as well.  I am busily
cleaning it up so it works in interrupt context as well.

Alan if you want it holler and I can send it to you as well.

Eric
