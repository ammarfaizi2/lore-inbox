Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUEBIBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUEBIBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEBIBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:01:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52494 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262205AbUEBIBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:01:09 -0400
Date: Sun, 2 May 2004 09:00:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, cw@f00f.org, koke@amedias.org,
       linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502090059.A9605@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, cw@f00f.org, koke@amedias.org,
	linux-kernel@vger.kernel.org
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040501180347.31f85764.akpm@osdl.org>; from akpm@osdl.org on Sat, May 01, 2004 at 06:03:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 06:03:47PM -0700, Andrew Morton wrote:
> Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> >
> > (2) tty hangup is scheduled for work_queue.
> 
> This is the problem, isn't it?
> 
> >From what context is tty_hangup() invoked?  (stick a dump_stack() in there>?)

>From IRQ context.  It's tty_vhangup() which is invoked from user context,
and calls do_tty_hangup() synchronously.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
