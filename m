Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbTGJW6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbTGJW6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:58:53 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:5820 "HELO
	develer.com") by vger.kernel.org with SMTP id S269671AbTGJW63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:58:29 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix do_div() for all architectures
Date: Fri, 11 Jul 2003 01:13:04 +0200
User-Agent: KMail/1.5.9
Cc: Richard Henderson <rth@twiddle.net>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200307060133.15312.bernie@develer.com> <200307082027.26233.bernie@develer.com> <20030710154019.GA18697@twiddle.net>
In-Reply-To: <20030710154019.GA18697@twiddle.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307110113.04982.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 17:40, Richard Henderson wrote:
 > On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
 > > +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor)
 > > __attribute_pure__;
 >
 > ...
 >
 > > +		__rem = __div64_32(&(n), __base);	\
 >
 > The pure declaration is very incorrect.  You're writing to N.

Here comes the obvious fix. Mea culpa, mea culpa, mea maxima culpa!

NOTE: I've intentionally left the __attribute_pure__ definition in
linux/compiler.h since it might apply to many other functions.


Linus, please apply and forgive me for getting this simple patch wrong
so many times in a row.

-------------------------------------------------------------------------

 - remove incorrect __attribute_pure__ from __div64_32() since it obviously
   clobbers memory through &(n);


diff -Nru linux-2.5.74-bk4.orig/include/asm-generic/div64.h linux-2.5.74-bk4/include/asm-generic/div64.h
--- linux-2.5.74-bk4.orig/include/asm-generic/div64.h   2003-07-11 01:00:44.000000000 +0200
+++ linux-2.5.74-bk4/include/asm-generic/div64.h        2003-07-11 00:59:52.000000000 +0200
@@ -32,7 +32,7 @@

 #elif BITS_PER_LONG == 32

-extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor) __attribute_pure__;
+extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);

 # define do_div(n,base) ({                             \
        uint32_t __base = (base);                       \

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


