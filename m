Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTAFWcd>; Mon, 6 Jan 2003 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTAFWcc>; Mon, 6 Jan 2003 17:32:32 -0500
Received: from are.twiddle.net ([64.81.246.98]:14208 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267196AbTAFWcb>;
	Mon, 6 Jan 2003 17:32:31 -0500
Date: Mon, 6 Jan 2003 14:41:04 -0800
From: Richard Henderson <rth@twiddle.net>
To: davidm@hpl.hp.com
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       bjornw@axis.com, geert@linux-m68k.org, ralf@gnu.org, mkp@mkp.net,
       willy@debian.org, anton@samba.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting
Message-ID: <20030106144104.A1938@twiddle.net>
Mail-Followup-To: davidm@hpl.hp.com, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, bjornw@axis.com, geert@linux-m68k.org,
	ralf@gnu.org, mkp@mkp.net, willy@debian.org, anton@samba.org,
	gniibe@m17n.org, kkojima@rr.iij4u.or.jp,
	Jeff Dike <jdike@karaya.com>
References: <20030106022803.902F82C0E2@lists.samba.org> <15897.56108.201340.229554@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15897.56108.201340.229554@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Jan 06, 2003 at 11:38:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:38:20AM -0800, David Mosberger wrote:
> What about all the problems that Richard Henderson pointed out with
> the original in-kernel module loader?  Were those solved?

Yes.  The most important one for correctness was

ChangeSet@1.838.130.13, 2003-01-01 19:02:38-08:00, rusty@rustcorp.com.au
  [PATCH] Modules 3/3: Sort sections
  
  RTH's final complaint (so far 8) was that we should sort the module
  sections: archs might require some sections to be adjacent, so they can
  all be reached by a relative pointer (ie.  GOT pointer).  This
  implements that reordering, and simplfies the module interface for
  architectures as well.
  
  Previously an arch could specify it wanted extra space, but not where
  that space would be.  The new method (used only by PPC so far) is to
  allocate an empty section (in asm/module.h or by setting LDFLAGS_MODULE
  to use an arch specific linker script), and expand that to the desired
  size in "module_frob_arch_sections()".


> My gut feeling is that we really want shared objects for kernel
> modules on ia64 (and probably alpha?).

Well, most everyone wants it.  Except that MIPS is terminally
broken.  They need a rewrite of bfd/elfxx-mips.c in order to
be able to do non-pic ET_DYN images.  Which leaves the rest of
us out in the cold.


r~
