Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWCDPm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWCDPm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 10:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWCDPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 10:42:25 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:56558 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751815AbWCDPmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 10:42:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sraUjoFKr9wFdjpN7Kj1gCN4rfUzEA/MHukr1RD0hfoLcMJYUOzQERUtEA6ykHNnPE2H/SjK4fBnUemmi6nonNpBMBN0XdqPXFKEhnspYZNBvii2JsTZbboBjQj1YVjD34zClm2u4QQpGf5zJvdRUIjiZ38wmujVMTiS2SIyyJM=
Message-ID: <f89c9fd60603040742x1ae5ce29rbe4ccc39fb973e08@mail.gmail.com>
Date: Sat, 4 Mar 2006 10:42:23 -0500
From: "shane Miller" <gshanemiller@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How linux schedules things when interrupts occur
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All-

I know what interrupts are. I read the Linux Device driver book and
see how to deal with them. But I don't see the full picture on how the
kernel deals with scheduling it's work. Bsically I am leaking for more
meat on this.

Suppose Linux is running on a single CPU system. Conceptually the CPU
is executing a user thread/process --- whether  that be user code or
library code on the user's behalf --- or the CPU is in the kernel.

When an APIC processed hardware interrupt comes and assuming the
interrupt is not masked off then if

* the CPU is doing user code, the kernel arranges to block/preempt the
current user process/thread and jumps into the kernel and runs the
registered interrupt handler.

* the CPU is in the kernel so it jumps to the interrupt handler and
runs it.

Can somebody put some more meat on this? For example,

* how does the kernel decide what to schedule once the interrupt
handler is done? Does it, as may be the case, resume the preempted user
thread or resume where it left off in the kernel? Or does it merely
call schedule().
* What happens if a signal comes during this work?

Once I understand this I think I can deal with the case in which an
interrupt comes while an interrupt is already being processed.

Thanks.
