Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSLKMkq>; Wed, 11 Dec 2002 07:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSLKMkp>; Wed, 11 Dec 2002 07:40:45 -0500
Received: from elin.scali.no ([62.70.89.10]:13836 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266981AbSLKMko>;
	Wed, 11 Dec 2002 07:40:44 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1039610907.25187.190.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 13:48:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It get even worse with Hammer. When you run hammer in compatibility mode
(32 bit app on a 64 bit OS) the sysenter is an illegal instruction.
Since Intel don't implement syscall, there is no portable sys*
instruction for 32 bit apps. You could argue that libc hides it for you
and you just need libc to test the host at startup (do I get a sigill if
I try to do getpid() with sysenter? syscall? if so we uses int80 for
syscalls).  But not all programs are linked dyn.

Too bad really, I tried the sysenter patch once, and the gain (on PIII
and athlon) was significant.

Fortunately the 64bit libc for hammer uses syscall. 


PS:  rdtsc on P4 is also painfully slow!!!

TJ

On man, 2002-12-09 at 20:46, H. Peter Anvin wrote: 
> Followup to:  <20021209193649.GC10316@suse.de>
> By author:    Dave Jones <davej@codemonkey.org.uk>
> In newsgroup: linux.dev.kernel
> >
> > On Mon, Dec 09, 2002 at 05:48:45PM +0000, Linus Torvalds wrote:
> > 
> >  > P4's really suck at system calls.  A 2.8GHz P4 does a simple system call
> >  > a lot _slower_ than a 500MHz PIII. 
> >  > 
> >  > The P4 has problems with some other things too, but the "int + iret"
> >  > instruction combination is absolutely the worst I've seen.  A 1.2GHz
> >  > Athlon will be 5-10 times faster than the fastest P4 on system call
> >  > overhead. 
> > 
> > Time to look into an alternative like SYSCALL perhaps ?
> > 
> 
> SYSCALL is AMD.  SYSENTER is Intel, and is likely to be significantly
> faster.  Unfortunately SYSENTER is also extremely braindamaged, in
> that it destroys *both* the EIP and the ESP beyond recovery, and
> because it's allowed in V86 and 16-bit modes (where it will cause
> permanent data loss) which means that it needs to be able to be turned
> off for things like DOSEMU and WINE to work correctly.
> 
> 	-hpa



-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

