Return-Path: <linux-kernel-owner+w=401wt.eu-S965211AbWLUKmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWLUKmK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWLUKmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:42:10 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:38907 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965212AbWLUKmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:42:08 -0500
Date: Thu, 21 Dec 2006 11:40:13 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Sorin Manolache" <sorinm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie questions about while (1) in kernel mode and spinlocks
Message-ID: <20061221114013.19734840@localhost>
In-Reply-To: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
References: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 10:41:44 +0100
"Sorin Manolache" <sorinm@gmail.com> wrote:

> while (1)
>     ;
> 
> in the read function of a test device driver. I expect the calling
> process to freeze, and then a timer interrupt to preempt the kernel
> and to schedule another process. This does not happen, the whole
> system freezes. I see no effect from pressing keys or moving the
> mouse. Why? The hardware interrupts are not disabled, are they? Why do
> the interrupt handlers not get executed?

Here I'm not sure. I think that interrupts are enabled and processed
correctly BUT the process cannot be Preempted because there is some
lock held (every lock will increment the preemption count).

The mouse doesn't move because X cannot be executed...

A quick test you can do is to enable CONFIG_MAGIC_SYSRQ and try with
"ALT + Stamp + B" when the system "freezes". If it reboots then
interrupts work  :)

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
