Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSGPAyo>; Mon, 15 Jul 2002 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317716AbSGPAyn>; Mon, 15 Jul 2002 20:54:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317165AbSGPAym>;
	Mon, 15 Jul 2002 20:54:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
       Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
       ralf@gnu.org, paulus@samba.org, anton@samba.org, schwidefsky@de.ibm.com,
       ak@suse.de, davem@redhat.com
Subject: Re: [PATCH] 2.5.25 Hotplug CPU boot changes 
In-reply-to: Your message of "15 Jul 2002 13:29:01 +0100."
             <1026736141.13885.105.camel@irongate.swansea.linux.org.uk> 
Date: Tue, 16 Jul 2002 10:48:26 +1000
Message-Id: <20020716005809.D5F1E4599@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1026736141.13885.105.camel@irongate.swansea.linux.org.uk> you write
:
> On Mon, 2002-07-15 at 09:58, Rusty Russell wrote:
> > The following patches change boot sequence, and once Linus releases
> > 2.5.26, I'll be updating and sending them.  This will break every SMP
> > architecture (patch for x86 below, and I have a patch for PPC32).
> >			printk("ksoftirqd for %i failedn", hotcpu);
> 
> Q: What prevents a CPU coming up -during- an MTRR change once the rest
> of the cpu hot plugging is present ?

Nothing, that's (one of the reasons) why cpu hotplug is not
implemented on x86.

[ Disclosure: I tried to rewrite the x86 boot code to actually bring
  CPUs up one at a time, rather than the minimal wedge seen in this
  patch, and failed.  Me no x86-pert, and the boot code is hairy. ]

I'm still considering a big reader lock around the actual bringing up
of CPUs, pending me completing my audit of what code actually needs
this (surprisingly, very little generic code actually cares how many
CPUs we have, so it's mainly a few corner cases).  This would be
cheap, and allow code that cared to lock out cpu changes.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
