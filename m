Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTI3Qew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTI3Qew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:34:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15331 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261746AbTI3Qes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:34:48 -0400
Date: Tue, 30 Sep 2003 18:34:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       John Bradford <john@grabjohn.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930163441.GP295@fs.tum.de>
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com> <20030930140627.GB28876@mail.shareable.org> <20030930145007.GB12812@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930145007.GB12812@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:50:08PM +0100, Dave Jones wrote:
>...
>  > Basically, if you're building a
>  > distro boot kernel, you must turn on all known workarounds.  That's
>  > certainly lowest-common-denominator, but it's a far cry from the
>  > configuration that a 386-as-firewall user wants.
> 
> Ok, I see what you're getting at, but Adrian's patch turned arch/i386/Kconfig
> and arch/i386/Makefile into guacamole.  After spending so much time
> getting that crap into something maintainable, it seemed a huge step
> backwards to litter it with dozens of ifdefs and duplication.
> There has to be a cleaner way of pleasing everyone.
>...

Referring to the latest patch I sent:

arch/i386/Kconfig:
The only problems seem to be some CPU_ONLY_* derived symbols I haven't 
yet found a better solution for.

arch/i386/Makefile:
There are two ifdefs to deal with Pentium 4 and K7/K8 selected at the 
same time:
ifdef CONFIG_CPU_PENTIUM4
  cpuflags-$(CONFIG_CPU_K{7,8})    := ...
else
  cpuflags-$(CONFIG_CPU_K{7,8})    := ...
endif

That's perhaps not optimal but IMHO not that bad.

The dozens of ifdefs were in other areas where I tried to add some 
additional space optimizations. It was a mistake to put them into the 
same patch and in the latest patches I sent they were already separated 
and they are _not_ required for the CPU selection scheme.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

