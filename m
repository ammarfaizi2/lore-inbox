Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUKJI5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUKJI5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKJI5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:57:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:4332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261415AbUKJI5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:57:50 -0500
Date: Wed, 10 Nov 2004 00:57:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/preempt-locking.txt clarification
Message-Id: <20041110005742.35828d2b.akpm@osdl.org>
In-Reply-To: <1100074907.3654.780.camel@thanatos>
References: <1073302283.1903.85.camel@thanatos.hubertnet>
	<1074561880.26456.26.camel@localhost>
	<1100074907.3654.780.camel@thanatos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood <jdthood@yahoo.co.uk> wrote:
>
> I have tried to clarify the text while at the same time
>  preserving the original meaning.  Everything is pretty clear
>  now except for the last paragraph which I still find baffling.
>  I don't know what "a test to see if preemption is required" is
>  exactly and I don't understand when such a test is required.

I guess it's saying that if you do this:

	local_irq_disable();
	lah_de_dah();
	local_irq_enable();

then you should follow that by

	preempt_check_resched();

just in case someone told this task to preempt itself while it had
interrupts disabled.

But I don't see why that's needed: if the preempt command came from another
CPU then this CPU will take the cross-CPU interrupt as soon as interrupts
are enabled.  And the preempt command couldn't have come from _this_ CPU,
because it had interrupts disabled.

