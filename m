Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270639AbRHQT5M>; Fri, 17 Aug 2001 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRHQT4u>; Fri, 17 Aug 2001 15:56:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64239 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270639AbRHQT4s>; Fri, 17 Aug 2001 15:56:48 -0400
Message-ID: <3B7D76EF.DA34EB23@mvista.com>
Date: Fri, 17 Aug 2001 12:56:31 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Victor Yodaiken <yodaiken@fsmlabs.com>
CC: Russell King <rmk@arm.linux.org.uk>,
        "christophe =?iso-8859-1?Q?barb=E9?=" <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), 
 exit(), SIGCHLD)
In-Reply-To: <20010817125727.A16475@hq2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Yodaiken wrote:
> 
> On Fri, Aug 17, 2001 at 11:25:42AM -0700, george anzinger wrote:
> > >
> > How about something like:
> >
> > In ../asm/signal.h  (for i386)
> >
> > #define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
> > type name(p1_type p1,p2_typ p2)\
> > {     struct pt_regs *regs = (struct pt_regs *)&p1;
> 
> In RTLinux we define MACHDEPREGS as an arch dependent type. PPC defines
> this as a pointer and x87 as the structure etc. The small number of functions
> that actually need to manipulate this can be made machine dependent too.
> Came in handy during the port to BSD too.

Uh..?  I though that was what I was allowing.  It seems to me to be a
lot of extra work to put the same code in 15 different archs. 
Especially if one does not really know each of them, nor can any one
group (or individual) be expected to be able to test (or even have the
hardware to test) each of them.

This said, what I am trying to define is a way to write common code that
will handle each arch as the arch coder defines the macro for his arch. 
In the given case, for example, the type of the arch dependent structure
is _only_ used in the macros which are defined in the asm/*.h file.  In
this particular case, the common macros, (which the arch macros over
ride) do not call the arch dependent function, but assume that it
returns true.  For nano_sleep, this means that it will return early on
ptrace signals, a standard violation, but what the  current code does,
so each arch can fix their system by defining the macro.  I also would
like a way to avoid writing (and supporting) 15 different nano_sleeps,
clock_nano_sleeps, etc.

If I miss understand what you are saying, please help me to understand
it.  But do keep in mind, that I _really_ don't want to support 15
incarnations of nano_sleep and clock_nano_sleep.  I would, however, like
to find a simple and elegant way to write and support the one common
nano_sleep and clock_nano_sleep, or what ever code.

George
