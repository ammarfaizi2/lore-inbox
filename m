Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUELSN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUELSN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUELSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:13:57 -0400
Received: from palrel12.hp.com ([156.153.255.237]:11151 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265144AbUELSNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:13:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16546.26974.678560.553686@napali.hpl.hp.com>
Date: Wed, 12 May 2004 11:13:50 -0700
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
In-Reply-To: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 12 May 2004 10:59:24 -0700, Stephen Hemminger <shemminger@osdl.org> said:

  Stephen> I used GCC nested functions in the (not released) bridge
  Stephen> sysfs interface for 2.6.6.  It seemed like a nice way to
  Stephen> express the sysfs related interface without doing lots of
  Stephen> code copying (or worse lots of macros).

Oh, man!  Nested C functions are evil.  Just don't do it.

  Stephen> This works fine for GCC 2.95 and 3.X for i386 and x86_64
  Stephen> architectures, but the ia64 (cross compiler) pukes with:

  Stephen> In function `store_forward_delay':
  Stephen> : undefined reference to `__ia64_trampoline'

  Stephen> Redoing it as separate functions is easy enough, but the
  Stephen> questions are:

  Stephen> - Are gcc nested functions allowed in the kernel?  If not
  Stephen> where should this restriction be put in Documentation?
  Stephen> CodingStyles?

Nested C functions shouldn't be allowed _anywhere_.  It's the worst
extension that has made it into GNU C.

  Stephen> - Or is gcc on ia64 just too stupid? or do some more
  Stephen> support routines need to exist in arch/ia64?

It has nothing to do with stupidity.  The kernel doesn't support all
the routines provided by libgcc.a.  __ia64_trampoline() is one of
them.

  Stephen> - Do other architectures (sparc, ppc) have similar problems?

It's not a problem.  It's a feature.  It's likely that other
architectures which require a helper-routine from libgcc would behave
the same.

	--david
