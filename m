Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132004AbQKQMev>; Fri, 17 Nov 2000 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132175AbQKQMel>; Fri, 17 Nov 2000 07:34:41 -0500
Received: from Cantor.suse.de ([194.112.123.193]:18437 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132004AbQKQMeU>;
	Fri, 17 Nov 2000 07:34:20 -0500
Date: Fri, 17 Nov 2000 13:04:18 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Jordan <ledzep37@home.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117130418.B3572@gruyere.muc.suse.de>
In-Reply-To: <3A14FF48.E554BE1B@home.com> <14869.6415.500026.432150@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14869.6415.500026.432150@harpo.it.uu.se>; from mikpe@csd.uu.se on Fri, Nov 17, 2000 at 12:39:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 12:39:59PM +0100, Mikael Pettersson wrote:
> Jordan writes:
>  > I have been running a plug in for xmms for some time that uses the
>  > aviplay program and avifile library...then when upgrading to test5/6 I
>  > start getting this error message when running xmms:
>  > 
>  > ERROR: no time-stamp counter found! Quitting.
>  > ...
>  > contents of /proc/cpuinfo:
>  > ...
>  > features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
> 
> The 'flags' line in /proc/cpuinfo was recently renamed 'features', due to
> some semantic changes. You have a user-space program which parses /proc/cpuinfo
> instead of executing CPUID itself, so it breaks.

The program would be broken if it executed CPUID itself, because it has no way to guarantee
that the CPUID is executed on all CPUs the scheduler may later move the task too.

I think it is also nasty to break non broken programs this way, looking for 
flags in /proc/cpuinfo is the only reliable way to do the checks on 2.2.

-Andi (proud owner of an AMP system with one CPU implementing FXSR and one not,
which causes lots of interesting problems) 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
