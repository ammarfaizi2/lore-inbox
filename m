Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUAQC6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265989AbUAQC6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:58:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37866 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265988AbUAQC5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:57:50 -0500
Date: Sat, 17 Jan 2004 03:57:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: root@chaos.analogic.com, cliffw@osdl.org, piggin@cyberone.com.au,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-ID: <20040117025745.GJ12027@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de> <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos> <20040116160133.5af17a6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116160133.5af17a6a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 04:01:33PM -0800, Andrew Morton wrote:
>...
> I must say that I'm a bit wobbly about Adrian's recent patches, simply
> because of the overall intrusiveness and conceptual changes which they
> introduce.

The only patch where I'd say this really applies to is 
better-i386-cpu-selection.patch .

I'm really happy that you added it in the latest -mm and I'm even more
happy that I haven't yet heard of any major breakage it has caused.

But it's your decision whether you like this patch or prefer to drop it.

> Remind me again, what did they buy us?

The main effect is that better-i386-cpu-selection.patch makes it easier
for people who configure kernels that should work on different CPU
types. A user (= person compiling his own kernel) does no longer need
any deeper knowledge when e.g. configuring a kernel that should run on
both an Athlon and a Pentium 4 - he simply selects all CPUs he wants to
support in his kernel.

As a side effect, this patch allows further optimizations based on the 
fact that e.g. a kernel for an i386 no longer needs to support an Athlon 
which can be used to omit support for non-selected CPUs [1].

cu
Adrian

[1] e.g. there's no need to include arch/i386/kernel/cpu/amd.c in your
    kernel if the kernel should only run on a 386;
    I made two such example patches that are _way_ too ugly for merging
    but show that this CPU selection scheme makes some more space 
    savings possible

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

