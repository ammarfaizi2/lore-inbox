Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVDFX5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVDFX5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVDFX5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:57:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26052 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262341AbVDFX5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:57:44 -0400
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <Pine.LNX.4.61.0504070133380.25131@scrub.home>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
	 <42544D7E.1040907@linux-m68k.org> <1112821319.14584.28.camel@localhost>
	 <Pine.LNX.4.61.0504070133380.25131@scrub.home>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 16:57:36 -0700
Message-Id: <1112831857.14584.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 01:40 +0200, Roman Zippel wrote:
> On Wed, 6 Apr 2005, Dave Hansen wrote:
> > On Wed, 2005-04-06 at 22:58 +0200, Roman Zippel wrote:
> > > Dave Hansen wrote:
> > > > --- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-04-04 09:04:48.000000000 -0700
> > > > +++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:23.000000000 -0700
> > > > @@ -0,0 +1,25 @@
> > > > +choice
> > > > +	prompt "Memory model"
> > > > +	default FLATMEM
> > > > +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> > > > +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
> > > 
> > > Does this really have to be a user visible option and can't it be
> > > derived from other values? The help text entries are really no help at all.
> > 
> > I hope that this selection will replace the current DISCONTIGMEM prompts
> > in the individual architectures.  That way, you won't get a net increase
> > in the number of prompts.
> 
> Why is this choice needed at all? Why would one choose SPARSEMEM over 
> DISCONTIGMEM?

For now, it's only so people can test either one, and we don't have to
try to toss DICONTIGMEM out of the kernel in fell swoop.  When the
memory hotplug options are enabled, the DISCONTIG option goes away, and
SPARSEMEM is selected as the only option.

I hope to, in the future, make the options more like this:

config MEMORY_HOTPLUG...
config NUMA...

config DISCONTIGMEM
	depends on NUMA && !MEMORY_HOTPLUG

config SPARSEMEM
	depends on MEMORY_HOTPLUG || OTHER_ARCH_THING

config FLATMEM
	depends on !DISCONTIGMEM && !SPARSEMEM

So, if they enable NUMA, they get DISCONTIGMEM automatically.  If they
enable MEMORY_HOTPLUG on top of that, they automatically get SPARSEMEM
instead.  All of the complex "pick your memory model" stuff goes away,
and you just select features.  However, I think the current situation is
a reasonable intermediate step, as we need to be able to switch back and
forth for now.

> Help texts such as "If unsure, choose <something else>" make 
> the complete config option pretty useless.

They don't make it useless, they just guide a clueless user to the right
place, without them having to think about it at all.  Those of us that
need to test the various configurations are quite sure of what we're
doing, and can ignore the messages. :)

I'm not opposed to creating some better help text for those things, I'm
just not sure that we really need it, or that it will help end users get
to the right place.  I guess more explanation never hurt anyone.

-- Dave

