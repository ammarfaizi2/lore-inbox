Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRIDV10>; Tue, 4 Sep 2001 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRIDV1P>; Tue, 4 Sep 2001 17:27:15 -0400
Received: from chopin.beltron.com ([207.236.241.244]:36360 "EHLO
	chopin.beltron.com") by vger.kernel.org with ESMTP
	id <S269372AbRIDV1H> convert rfc822-to-8bit; Tue, 4 Sep 2001 17:27:07 -0400
Message-ID: <F50B5436A4CED31190DA000629386F010168AB67@CHOPIN>
From: =?iso-8859-1?Q?=22Hammond=2C_Jean-Fran=E7ois=22?= 
	<Jean-Francois.Hammond@mindready.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Scheduling in interrup
Date: Tue, 4 Sep 2001 17:20:52 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>o	Are you attempting to access paged RAM?

I am using kmalloc to reserve my memory.
kmalloc as the options GFP_KERNEL and GFP_DMA.
I am not using any command to reserve memory in
the interrupt handler.

>o	Are you accessing anything that sleeps?

Not in the interrupt handler.

>o	Are you enabling interrupts without protecting against
	re-entry first?

I am not sure what do you mean, but I am attaching the interrupt
handler with the function request_irq with the option SA_INTERRUPT &
SA_SHIRQ.
Does the kernel prevent re-entry of the interrupt handler ?

I look in the function schedule :

asmlinkage void schedule(void)
{
	struct schedule_data * sched_data;
	struct task_struct *prev, *next, *p;
	struct list_head *tmp;
	int this_cpu, c;

	if (!current->active_mm) BUG();
need_resched_back:
	prev = current;
	this_cpu = prev->processor;

	if (in_interrupt())
		goto scheduling_in_interrupt;

<...>

scheduling_in_interrupt:
	printk("Scheduling in interrupt\n");
	BUG(); <--------------------------------This is the line 706. -->
This is my problem <--
	return;
}

Do you have any idea how this could happen ?

Thanks,

Jean-François Hammond				.

