Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSHGKiS>; Wed, 7 Aug 2002 06:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHGKiS>; Wed, 7 Aug 2002 06:38:18 -0400
Received: from ns.suse.de ([213.95.15.193]:42770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318211AbSHGKiQ>;
	Wed, 7 Aug 2002 06:38:16 -0400
Date: Wed, 7 Aug 2002 12:41:53 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020807124153.A8592@wotan.suse.de>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com.suse.lists.linux.kernel> <p73vg6nhtsb.fsf@oldwotan.suse.de> <1028721043.18478.265.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028721043.18478.265.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 12:50:43PM +0100, Alan Cox wrote:
> On Wed, 2002-08-07 at 11:01, Andi Kleen wrote:
> > Can you explain this further. How else do you propose to get rid of 
> > unmaintained-and-absolutely-hopeless-on-64bit drivers in the configuration? 
> > I definitely do not want to get bug reports about these not working on x86-64.
> 
> I don't want a tree where every driver has seventeen lines of if IBM and
> not 64bit || parisc || x86 || !x86_64 || ia64) && (!wednesdayafternoon)
> 
> Its *unmaintainable*.

I don't see why it is unmaintainable. What is so bad with these ifs? 
64bit cleanness is just another dependency, nothing magic and fundamentally
hard.

I admit it is a bit ugly to hardcode CONFIG_X86_64 here, I would actually
prefer an generic CONFIG_64BIT

At least for i386 it should make no difference at all.

If you object to the ifdefs I can turn it into 
dep_tristate  ... $CONFIG_X86_32 (or CONFIG_I386 and add this)

(unfortunately there is no dep_tristate ... !$CONFIG_64BIT) 
Alternatively CONFIG_NO_64BIT to work around this issue.

> 
> The sparc64 people don't do it, the mips people don't do it, the ia64
> people don't do it, wtf should you get to fill config.in with crap

The main reason I'm doing this is that unlike IA64,alpha,mips (sorry no
offense to these ports) x86-64 is aimed at the mass market. I will
not invoke the A..T... word, but having a configuration where a good
chunk of the drivers do not work is just not acceptable for x86-64 where
even non kernel hackers will likely recompile the kernels. I tried
to fix it for some of the drivers but some are obviously hopeless without
major work.

> The _ISA stuff makes sense, thats sensible, but the rest - when people
> moan we tell em to fix the drivers.

I don't think it is very nice. Some of these actually compile, just with
thousands of warnings, but will oops very quickly likely after first load.
I prefer to disable them. That is much nicer to the user.


-Andi

