Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbVGOJQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbVGOJQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbVGOJQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:16:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263254AbVGOJQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:16:32 -0400
Date: Fri, 15 Jul 2005 02:15:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050715021532.3fbba001.akpm@osdl.org>
In-Reply-To: <20050715100327.G25428@flint.arm.linux.org.uk>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715094947.E25428@flint.arm.linux.org.uk>
	<20050715015629.7b0fb13a.akpm@osdl.org>
	<20050715100327.G25428@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Fri, Jul 15, 2005 at 01:56:29AM -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > > On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> > > > +uart_handle_sysrq_char-warning-fix.patch
> > > > 
> > > >  Fix a warning
> > > 
> > > Andrew, this requires a little more fixing than your simple patch.
> > > Several drivers omit 'regs' from the receive handler when sysrq is
> > > not enabled.  Hence, this simple fix on its own will cause compile
> > > failures.
> > 
> > Me no understand.  It replaces a three-arg macro with a three-arg static
> > inline?
> 
> Some serial drivers drop 'regs' from the parent function when sysrq is
> disabled.  'regs' is only passed for sysrq support.
> 

Me still no understand.

+static inline int uart_handle_sysrq_char(struct uart_port *port,
+               unsigned int ch, struct pt_regs *regs)
+{
+       return 0;
+}
	
That function doesn't touch *regs, and all callers pass in either
a pt_regs* or NULL??
