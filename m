Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWG1VtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWG1VtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWG1VtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:49:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161316AbWG1VtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:49:18 -0400
Date: Fri, 28 Jul 2006 14:48:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-Id: <20060728144854.44c4f557.akpm@osdl.org>
In-Reply-To: <1154112276.3530.3.camel@amdx2.microgate.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<1154112276.3530.3.camel@amdx2.microgate.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 13:44:36 -0500
Paul Fulghum <paulkf@microgate.com> wrote:

> 2.6.18-rc2-mm1 causes boot to fail early with:
> kernel panic: IO_APIC timer interrupt 0 doesn't work
> 
> 2.6.18-rc2 works.
> 
> 2.6.18-rc2-mm1 kernel config located at:
> http://www.microgate.com/ftp/linux/test/config
> 
> syslog from working 2.6.18-rc2 located at:
> http://www.microgate.com/ftp/linux/test/syslog
> 

I don't know what would have caused this.  Was 2.6.18-rc1-mm2 OK?

Patches which touch arch/i386/kernel/io_apic.c are:

x86_64-mm-i386-up-generic-arch.patch
x86_64-mm-i386-io-apic-access.patch
genirq-convert-the-i386-architecture-to-irq-chips.patch
initial-generic-hypertransport-interrupt-support.patch
genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch
genirq-i386-irq-move-msi-message-composition-into-io_apicc.patch
genirq-i386-irq-dynamic-irq-support.patch

The developers of those patches are cc'ed.

A bisection search would be useful, if you have the time.  I'd zero in on
the x86_64 tree initially.  Perhaps x86_64-mm-i386-io-apic-access.patch.

Or it could be something else altogether.
