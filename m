Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbULCAak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbULCAak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbULCAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:30:40 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48257 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261815AbULCAaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:30:35 -0500
Subject: Re: GFP_ATOMIC vs GFP_KERNEL in netfilter module
From: Robert Love <rml@novell.com>
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
In-Reply-To: <92A26C52-44B7-11D9-A62F-000A957B2B6C@inf.ufrgs.br>
References: <92A26C52-44B7-11D9-A62F-000A957B2B6C@inf.ufrgs.br>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 19:31:49 -0500
Message-Id: <1102033909.6052.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 21:12 -0200, Roberto Jung Drebes wrote:

> If I use GFP_KERNEL with the kmallocs, I get errors like

So don't use GFP_KERNEL; use GFP_ATOMIC.  You cannot sleep in netfilter
hooks, since they are run in interrupt context (when the packet is
received) by the net_rx_action softirq.  You can see this in your stack
trace.

> If I use GFP_ATOMIC, I don't get the error, but I think timers are not 
> being called after the delay. I have a similar code for transmition, 
> which works OK with GFP_KERNEL (delays messages) but with GFP_ATOMIC it 
> does also not delay.

If you have problems with GFP_ATOMIC, the problem is elsewhere and not
in the fact that your allocations are atomic versus not.

First thing, though, check the return value from kmalloc for failure (dp
and tl equal NULL) to ensure that the allocation is even working!

	Robert Love


