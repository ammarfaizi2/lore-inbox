Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUB0IA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUB0IA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 03:00:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7569 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261730AbUB0IAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 03:00:25 -0500
Date: Fri, 27 Feb 2004 00:00:22 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-Id: <20040227000022.0fe37e54.zaitcev@redhat.com>
In-Reply-To: <mailman.1077822002.21081.linux-kernel2news@redhat.com>
References: <mailman.1077822002.21081.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 11:05:07 -0800
Tim Bird <tim.bird@am.sony.com> wrote:

> What's the rationale for not supporting interrupt priorities
> in the kernel?

Interrupts interrupt other interrupts today, so this aspect of nested
interrupts is functional. In fact, it's a major headache, because
with explosion of the number of interrupt sources in modern x86 servers
were are pushed against the stack size.

The only thing remaining is something like UNIX spl(). You can overload
enable_irq, disable_irq with enabling IRQs numbered lower than the IRQ
being disabled, thus turning them into spl(). This is correct, but stupid.

Nobody writes drivers and arches like so, because if your _rely_ on such
implementation of enable_irq and disable_irq, the driver or framwork
becomes silently API dependant, and breaks silently.

If you want PILs like on sparc, well, your architecture can provide them.
They make no sense on x86, of course, so they are called some arch-specific
name, like __spl().

Why do you want "interrupt priorities", anyway? Is there a consumer
electronics application which requires that? No, seriously, what is it?

-- Pete
