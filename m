Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWC3QSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWC3QSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWC3QSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:18:46 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:7892 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751241AbWC3QSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:18:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 18:17:36 +0200
User-Agent: KMail/1.9.1
Cc: Ashok Raj <ashok.raj@intel.com>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060329220808.GA1716@elf.ucw.cz> <20060329154748.A12897@unix-os.sc.intel.com> <20060330084153.GC8485@elf.ucw.cz>
In-Reply-To: <20060330084153.GC8485@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301817.37315.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 30 March 2006 10:41, Pavel Machek wrote:
> > > So if you have a single core x86, you want X86_PC, and if you have HT or SMP, 
> > > you want GENERICARCH? If so, could this be done via selects or depends or at 
> > > least defaults in Kconfig?
> > 
> > Yes, i think only SUSPEND_SMP is affect by this.

That's correct.

> > I thought Rafael cced Pavel during that exchange, maybe i missed.

I did, but Pavel was travelling at that time (I think).

[Well, I had the feeling it would cause problems but unfortunately I couldn't
show that.]

> > How about this patch.
> > 
> > Make SUSPEND_SMP depend on X86_GENERICARCH, since hotplug cpu requires !X86_PC 
> > due to some race in IPI handling.  See more discussion here
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=114303306032338&w=2
> 
> I can't see useful discussion there.
> 
> > Index: linux-2.6.16-git16/kernel/power/Kconfig
> > ===================================================================
> > --- linux-2.6.16-git16.orig/kernel/power/Kconfig
> > +++ linux-2.6.16-git16/kernel/power/Kconfig
> > @@ -96,5 +96,5 @@ config SWSUSP_ENCRYPT
> > 
> >  config SUSPEND_SMP
> >         bool
> > -       depends on HOTPLUG_CPU && X86 && PM
> > +       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
> >         default y
> 
> 
> Heh, great, so one more magic option that is required.

BTW it's i386-centric, as X86_GENERICARCH is not defined on x86_64, for
example.

FUrther, the whole problem, as far as I can understand it, is i386-specific,
so it should be resolved in the i386 architecture config rather than anywhere
else.

Greetings,
Rafael
