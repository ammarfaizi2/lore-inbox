Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWGXNUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWGXNUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWGXNUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:20:50 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:57044 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932165AbWGXNUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:20:49 -0400
Subject: Re: BUG: soft lockup detected on CPU#1!
From: Steven Rostedt <rostedt@goodmis.org>
To: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, nathans@sgi.com,
       xfs@oss.sgi.com
In-Reply-To: <20060721225304.GA12184@planetzork.ping.de>
References: <20060717125216.GA15481@planetzork.ping.de>
	 <1153146608.1218.9.camel@localhost.localdomain>
	 <20060717144831.GA28284@planetzork.ping.de>
	 <20060721225304.GA12184@planetzork.ping.de>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 09:20:32 -0400
Message-Id: <1153747232.4002.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-22 at 00:53 +0200, Jochen Heuer wrote:

> 
> Is there anything I can test? Disable irq balancing? Disabling preemption did
> not help. Disabling IO-APIC? What can I do to help isolate the problem because
> it really is annoying and I don't like pushing the reset button. Because if the
> system locks up *really* nothing works. The screen is frozen, no mouse, no
> keyboard, no sys-rq, no network ... nothing.

Jochen, have you tried to enable NMI?  Make sure you have Local APIC
enabled (you should since it's SMP), and on your kernel command line (in
Grub) add "lapic nmi_watchdog=2". (lapic isn't really needed, but I
always add it so I don't forget to when working on UP machines).

Run it again, and if it locks up hard, which probably means its spinning
somewhere with interrupts disabled, the NMI will trigger and should give
you another dump of where it's locked up.

-- Steve


