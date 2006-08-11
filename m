Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWHKXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWHKXSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWHKXSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:18:13 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:415 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751273AbWHKXSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:18:11 -0400
Date: Fri, 11 Aug 2006 19:13:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [145/145] i386: Disallow kprobes on
  NMI handlers
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608111916_MC3-1-C7D7-ACA5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608110853.19740.ak@suse.de>

On Fri, 11 Aug 2006 08:53:19 +0200, Andi Kleen wrote:

> > > --- linux.orig/arch/i386/kernel/entry.S
> > > +++ linux/arch/i386/kernel/entry.S
> > > @@ -725,7 +725,7 @@ debug_stack_correct:
> > >   * check whether we got an NMI on the debug path where the debug
> > >   * fault happened on the sysenter path.
> > >   */
> > > -ENTRY(nmi)
> > > +KPROBE_ENTRY(nmi)
> > >       RING0_INT_FRAME
> > >       pushl %eax
> > >       CFI_ADJUST_CFA_OFFSET 4
> > 
> > Needs .popsection at the end of the NMI code.
> 
> This is fixed up in a later patch I think.
> i386: KPROBE_ENTRY ends up putting code into .fixup

That patch was earlier, not later.  I applied the 060811 patchset from
firstfloor and you still need this:

--- 2.6.18-rc4-ff.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc4-ff/arch/i386/kernel/entry.S
@@ -801,6 +801,7 @@ nmi_16bit_stack:
 	.align 4
 	.long 1b,iret_exc
 .previous
+.popsection
 
 KPROBE_ENTRY(int3)
 	RING0_INT_FRAME
-- 
Chuck
