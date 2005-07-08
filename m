Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVGHMN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVGHMN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVGHMN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:13:28 -0400
Received: from odin2.bull.net ([192.90.70.84]:52212 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262590AbVGHMN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:13:26 -0400
Subject: Re: PREEMPT_RT and mptfusion
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050707175231.GA29046@elte.hu>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
	 <20050706120848.GB16843@elte.hu>
	 <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr>
	 <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr>
	 <20050706143157.GA22156@elte.hu>
	 <1120719326.6225.102.camel@ibiza.btsn.frna.bull.fr>
	 <20050707175231.GA29046@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1120823999.6225.149.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Fri, 08 Jul 2005 14:00:00 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 07/07/2005 � 19:52, Ingo Molnar a �crit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > Same problem with this patch and CONFIG_PCI_MSI=y
> > This is not the solution.
> 
> ok, -51-12 should have a better fix - does that kernel work for you with 
> PCI_MSI=y?
I tried 51-13. It's OK.
I have new messages :
...
Freeing unused kernel memory: 376k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
BUG: modprobe:1099 RT task yield()-ing!
 [<c0104533>] dump_stack+0x23/0x30 (20)
 [<c03ce248>] yield+0x58/0x60 (20)
 [<c011b7e3>] wait_task_inactive+0x93/0xb0 (24)
 [<c013b1d6>] kthread_bind+0x26/0x60 (24)
 [<c014f05c>] __stop_machine_run+0x9c/0xd0 (132)
 [<c014f0b4>] stop_machine_run+0x24/0x40 (20)
 [<c014a74a>] sys_init_module+0x8a/0x230 (32)
 [<c01034a8>] sysenter_past_esp+0x61/0x89 (-8116)
------------------------------
| showing all locks held by: |  (modprobe/1099 [f700a610,  98]):
------------------------------

#001:             [c0440fa4] {module_mutex.lock}
... acquired at:  sys_init_module+0x3b/0x230

#002:             [c04416a4] {stopmachine_mutex.lock}
... acquired at:  __stop_machine_run+0x69/0xd0

ts: Compaq touchscreen protocol output
Generic RTC Driver v1.07
ACPI: Power Button (FF) [PWRF]
...
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

