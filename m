Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSL0AnD>; Thu, 26 Dec 2002 19:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSL0AnD>; Thu, 26 Dec 2002 19:43:03 -0500
Received: from web13202.mail.yahoo.com ([216.136.174.187]:56912 "HELO
	web13202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264702AbSL0AnC>; Thu, 26 Dec 2002 19:43:02 -0500
Message-ID: <20021227005118.18686.qmail@web13202.mail.yahoo.com>
Date: Thu, 26 Dec 2002 16:51:18 -0800 (PST)
From: Anomalous Force <anomalous_force@yahoo.com>
Subject: holy grail
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a hot swap kernel would be something like the holy grail of kernel
hacking. it would logically go something like this:

void kexec_hot_swap()
{
        void *kern = load_kernel_into_mem();
        syscall_queue(ENABLE); /* queue all sys calls */
        irq_queue(ENABLE); /* queue all irqs */
        /* bring new kernel's state inline with current one's.
           this includes all data structures, module hooks, etc.
           this needs to be very fast as irqs will be pending... */
        synch_kernel(kern);
        kernel_start(kern); /* fire in the hole... */
}

at this point the new kernel would know it is being started as a
hot swap throught a flag or something, and dequeue the irq's
that are pending, followed by the sys calls that are waiting.
if this goes how i think it should, a user running on the system
wont even know the kernel was swapped.

what do you think? is it do-able?

=====
Main Entry: anom·a·lous 
1 : inconsistent with or deviating from what is usual, normal, or expected: IRREGULAR, UNUSUAL
2 (a) : of uncertain nature or classification (b) : marked by incongruity or contradiction : PARADOXICAL
synonym see IRREGULAR

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
