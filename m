Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVGLQdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVGLQdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGLQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:32:10 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:45484 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261570AbVGLQaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:30:06 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Kernel header policy
Date: Tue, 12 Jul 2005 17:30:00 +0100
User-Agent: KMail/1.8.1
Cc: Peter Staubach <staubach@redhat.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Marc Aurele La France <tsi@ualberta.ca>, linux-kernel@vger.kernel.org
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl> <42D3C51D.3020703@redhat.com> <1121175394.3171.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1121175394.3171.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121730.00977.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Jul 2005 14:36, Arjan van de Ven wrote:
> On Tue, 2005-07-12 at 09:26 -0400, Peter Staubach wrote:
> > Horst von Brand wrote:
> > >>I am contacting you to express my concern over a growing trend in
> > >> kernel development.  I am specifically referring to changes being made
> > >> to kernel headers that break compatibility at the userland level,
> > >> where __KERNEL__ isn't #define'd.
> > >
> > >The policy with respect to kernel headers is /very/ simple:
> > >
> > >  T H E Y   A R E   N E V E R   U S E D   F R O M   U S E R L A N D.
> > >
> > >This general policy makes all your points (trivially) moot.
> >
> > I must admit a little confusion here.  Clearly, kernel header files are
> > used at the user level.  The kernel and user level applications must
> > share definitions for a great many things.
>
> you are incorrect or rather imprecise here. Userspace needs headers
> which define the kernel<->Userspace ABI. That is not the same as "the"
> kernel headers.
>
> > Perhaps more precisely, the rule is that kernel header files should not
> > be #include'd directly from user level applications, but may be
> > #include'd indirectly through other header files as appropriate?
>
> actually the rule in linux is that you should use cleaned up ABI
> defining headers. There's several sets to chose from even. Generally
> those sets have their origins in the kernel but are stripped down to
> just the userspace-abi elements.
> (eg no kernel specific things like spinlocks or inlines or ..)

One example of such "cleaned up headers" that are distro non-specific are the 
linux-libc-headers available from:

http://ep09.pld-linux.org/~mmazur/linux-libc-headers/

These are replacements for /usr/include/linux and /usr/include/asm (for your 
arch) and favour userspace, kept in sync with kernelspace manually. However, 
your glibc should (ideally) be compiled against these so that you don't get 
weird, incompatible data structures. I've never personally seen this happen, 
however.

If the "bugs" you were complaining about originally are still present in these 
libc-headers, you may have a legitimate issue and directing your questions to 
Mariusz Mazur is probably okay.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
