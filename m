Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbSLEVdq>; Thu, 5 Dec 2002 16:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbSLEU5V>; Thu, 5 Dec 2002 15:57:21 -0500
Received: from [195.39.17.254] ([195.39.17.254]:17924 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267425AbSLEU5O>;
	Thu, 5 Dec 2002 15:57:14 -0500
Date: Wed, 4 Dec 2002 12:19:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021204111947.GB309@elf.ucw.cz>
References: <p737kesu9bt.fsf@oldwotan.suse.de> <20021202.002815.58826951.davem@redhat.com> <20021202090756.GA26034@wotan.suse.de> <20021202.021629.93360250.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202.021629.93360250.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    > BTW, I bet your dynamic relocation tables are a bit larger too.
>    
>    Somewhat, but does it matter?  They are not kept in memory anyways.
> 
> It's all about how much data a ld.so relocation has to touch.  But
> preloading will help out here, even though that isn't in wide spread
> use just yet.
> 
> And I was talking about user stack usage, not the kernel kind
> :-)
> 
> Andi, do something very simple like run -m32 vs -m64 microbenchmarks,
> I bet -m32 beats -m64 in all the lmbench lat_proc tests.  On sparc64
> it's (on a 2-way SMP system):
> 
> -m32 fork+exit:		360.8328 microseconds
> -m32 fork+execve:	1342.2213 microseconds
> -m32 fork+/bin/sh:	5497.0149 microseconds
> 
> -m64 fork+exit:		553.9076 microseconds
> -m64 fork+execve:	1904.6315 microseconds
> -m64 fork+/bin/sh:	6268.6932 microseconds
> 
> NOTE: make sure you change /bin/sh to be 32-bit/64-bit as
>       appropriate in the tests above.
> 
> So what is this on x86_64? :-) I think lat_proc is great becuase it
> shows pure libc overhead in continually relocating the exit()
> etc. symbols in the child for fork+exit, for example.
> 
> The reason I'm making such a stink about this is that I don't want
> people believing that "the code generation improvements due to the
> extra x86_64 registers available nullifies the bloat cost from
> going to 64-bit"

Actually, it tends to nullify the bloat cost and then make it few
percent faster... For most of spec2000 modulo two or three cache-bound
tests that are 50% slower :-(.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
