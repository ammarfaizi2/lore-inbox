Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUCDFah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUCDFah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:30:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:7146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261456AbUCDFa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:30:28 -0500
Date: Wed, 3 Mar 2004 21:30:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nmi_watchdog=2 and P4-HT
Message-Id: <20040303213033.6348a08b.akpm@osdl.org>
In-Reply-To: <20040304054215.GA683@zaniah>
References: <20040304054215.GA683@zaniah>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie <phil.el@wanadoo.fr> wrote:
>
> Hi,
> 
> Actually with nmi_watchdog=2 and a P4 ht box the nmi is reflected
> only on logical processor 0, it's better to get it on both.

What do you mean by "reflected"?  That the NMi is delivered to both
siblings but only appears in /proc/interrupts as being delivered to the
zeroeth?

> Note, if you test this patch, than on all x86 SMP and nmi_watchdog=2
> nmi occurs at 1000 hz (if the cpu is loaded) not at the intended 1 hz
> rate but that's a distinct problem.

nmi_watchdog=2 is local apic, and nmi_watchdog=1 is I/O apic, is that
correct?

I am showing the current behaviour:


nmi_watchdog=1: 1000 NMI/second, accounted to both siblings
nmi_watchdog=2: one NMI/second, accounted to sibling 0 only.

with your patch:

nmi_watchdog=1: 1000 NMI/second, accounted to both siblings
nmi_watchdog=2: 1000 NMI/second, accounted to both siblings

All of these are wrong, aren't they?  We'd like to see one NMI per second,
on all siblings.  I gues that's not possible for the IO APIC?

>From the above it appears that you have a solution planned for the local
APIC at least, yes?
