Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUC3UIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUC3UIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:08:06 -0500
Received: from fmr06.intel.com ([134.134.136.7]:52172 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261358AbUC3UHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:07:04 -0500
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <200403302030.26476.arekm@pld-linux.org>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
	 <200403302030.26476.arekm@pld-linux.org>
Content-Type: text/plain; charset=iso-8859-2
Organization: 
Message-Id: <1080677134.980.166.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2004 15:05:35 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can make sure that ACPI checks implicitly or explicitly
that CMPXCHG is available -- but I can't make sure that
some other random part of the kernel which may not have
been written yet does.  So I'd rather that they not build,
like ACPI didn't.

BTW. CMPXCHG (486 and above) doesn't seem to be in CPUID,
CMPXCHG8B is, but that starts with Pentium and above.
Maybe simpler to rely on the implicit "check" that we
did in previous releases...  Earliest known ACPI
implementation as on Pentium-1.

cheers,
-Len

On Tue, 2004-03-30 at 13:30, Arkadiusz Miskiewicz wrote:
> Dnia Tuesday 30 of March 2004 19:44, Len Brown napisa³:
> 
> > Luming has already taking a swing at this patch here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=2391
> Wouldn't be better to just remove #ifdef CONFIG_X86_CMPXCHG around __cmpxchg() 
> and cmpxchg macro in ./include/asm-i386/system.h so cmpxchg() would be there 
> always even on i386 but leave CONFIG_X86_CMPXCHG macro if anyone want's to 
> check for it in some code. No code duplication and you get what you need.
> 
> It would be something like:
> 
> #ifdef CONFIG_X86_CMPXCHG
> #define __HAVE_ARCH_CMPXCHG 1
> #endif
> static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>                                       unsigned long new, int size)
> {
> }
> #define cmpxchg(ptr,o,n)\
>         ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>                                         (unsigned long)(n),sizeof(*(ptr))))
> 
> instead of current:
> 
> #ifdef CONFIG_X86_CMPXCHG
> #define __HAVE_ARCH_CMPXCHG 1
> 
> static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>                                       unsigned long new, int size)
> {
> }
> #define cmpxchg(ptr,o,n)\
>         ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>                                         (unsigned long)(n),sizeof(*(ptr))))
> 
> #else
> /* Compiling for a 386 proper.  Is it worth implementing via cli/sti?  */
> #endif
> 
> ?
> 
> > thanks,
> > -Len

