Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbSLKSnt>; Wed, 11 Dec 2002 13:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbSLKSnt>; Wed, 11 Dec 2002 13:43:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267267AbSLKSns>; Wed, 11 Dec 2002 13:43:48 -0500
Message-ID: <3DF78911.5090107@zytor.com>
Date: Wed, 11 Dec 2002 10:50:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Terje Eggestad <terje.eggestad@scali.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad wrote:
> It get even worse with Hammer. When you run hammer in compatibility mode
> (32 bit app on a 64 bit OS) the sysenter is an illegal instruction.
>
> Since Intel don't implement syscall, there is no portable sys*
> instruction for 32 bit apps. You could argue that libc hides it for you
> and you just need libc to test the host at startup (do I get a sigill if
> I try to do getpid() with sysenter? syscall? if so we uses int80 for
> syscalls).  But not all programs are linked dyn.


Linus talked about this once, and it was agreed that the only sane way
to do this properly was via vsyscalls... have a page mapped somewhere in
high (kernel-area) memory, say at 0xfffff000, but readable by normal
processes.  A system call can be invoked via call 0xfffff000, and the
*kernel* enters whatever code is appropriate to enter itself.

> Too bad really, I tried the sysenter patch once, and the gain (on PIII
> and athlon) was significant.
> 
> Fortunately the 64bit libc for hammer uses syscall. 
> 

Yes.

> 
> PS:  rdtsc on P4 is also painfully slow!!!
> 

Now that's just braindead...

	-hpa


