Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIOPii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIOPii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUIOPih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:38:37 -0400
Received: from mail.tmr.com ([216.238.38.203]:42000 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266485AbUIOPi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:38:29 -0400
Date: Wed, 15 Sep 2004 11:31:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
In-Reply-To: <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
Message-ID: <Pine.LNX.3.96.1040915111445.10950I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Tigran Aivazian wrote:

> On Fri, 10 Sep 2004, Bill Davidsen wrote:
> 
> > Tigran Aivazian wrote:
> > > Hello,
> > > 
> > > I have received and tested the latest microcode data file from Intel, The
> > > file is dated 2nd September 2004. You can download it both as standalone
> > > (bzip2-ed) text file and bundled with microcode_ctl utility from the
> > > Download section of the website:
> > > 
> > > http://urbanmyth.org/microcode/
> > > 
> > > Please let me know if you find any problems with this data file or with
> > > the Linux microcode driver. Thank you.
> > 
> > Why are you using /dev/cpu/microcode instead of /dev/cpu/N/microcode for 
> > each CPU? Today they are all the same device, but for the future I would 
> > think this was an obvious CYA.
> 
> I have two questions:
> 
> 1. What does "CYA" mean?

Cover Your Ass - or more politely, plan for likely future changes if there
isn't a high cost doing so.
> 
> 2. How do you know which device nodes exist on my workstation?

I don't need to... the stat() call will tell me. If a /dev/cpu/0/microcode
exists it is more likely to be the correct loader for CPU0 than some
generic loader. Obviously if the user provides a name use it.
> 
> Actually, I am using /dev/cpu/0/microcode as the device node (entry point
> into the microcode driver) because that is what is in the distribution I
> am running (old Red Hat).

That's exactly why I mentioned using the per-cpu device if present. While
having CPUs with different loaders is not a feature today, I wouldn't bet
that will always be true. We know that AMD expects to ship dual core CPUs
in an Opteron form factor. If I have a dual opteron system and replace one
CPU with dual core, will I need a different loader? I have no idea, but
since it's easy to use the per-CPU microcode I would.

> 
> The microcode_ctl utility had a hardcoded default "/dev/cpu/microcode" and 
> there is no real reason to change it because different distributions 
> prefer a different value, so how to decide who is "right"?

The obvious seems to be to see if the per-CPU device is present, and use
it if possible. I can't believe that it would be (by design) less correct
than the generic device.
> 
> Also, there is no obvious reason why the future has to be in any way
> different from the present (or the past :)

Your distro and mine already have per-CPU microcode, that's the present.
Lots of people just compile and run, that's the present. It's easy to
check for /dev/cpu/N/micorcode first, then /dev/cpu/microcode, I think
that's the future. I just like having code try a little harder to do the
right thing, Linux should be easy.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

