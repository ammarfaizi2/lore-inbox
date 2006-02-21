Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWBUWuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWBUWuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWBUWuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:50:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964888AbWBUWux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:50:53 -0500
Date: Tue, 21 Feb 2006 14:49:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Hesse, Christian" <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: hald in status D with 2.6.16-rc4
Message-Id: <20060221144907.1ac11799.akpm@osdl.org>
In-Reply-To: <200602212322.48645.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de>
	<20060220211909.7964d56e.akpm@osdl.org>
	<200602212322.48645.mail@earthworm.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hesse, Christian" <mail@earthworm.de> wrote:
>
> On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > Hello everybody,
> > >
> > > since using kernel version 2.6.16-rc4 the hal daemon is in status D after
> > > resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints what could be
> > > the problem? It worked perfectly with 2.6.15.x and suspend2 2.2.
> >
> > a) Look in the logs for any oopses, other nasties
> 
> Nothing.
> 
> > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' then find
> >    the trace for `hald' in `foo', send it to this list.
> 
> Ok, here it is:
> 
> hald          D E0B50480     0  7791      1  7797   10654  7609 (NOTLB)
> cc6cbccc e0b50480 000f4428 e0b50480 000f4428 c6c9605c c14dce00 c14dce00
>        e0b50480 000f4428 cc3df530 dff6e5c0 cc3df530 00000296 dff6e5c8 c046f202
>        00000001 cc3df530 c0115680 d7ea1ce0 dff6e5c8 00000003 00000001 00000000
> Call Trace:
>  [<c046f202>] __down+0x62/0xc0
>  [<c0115680>] default_wake_function+0x0/0x20
>  [<c046dd3f>] __down_failed+0x7/0xc
>  [<c0288bbf>] .text.lock.osl+0x13/0x3c
>  [<c0292678>] acpi_ex_system_wait_semaphore+0x34/0x48
>  [<c028d5da>] acpi_ev_acquire_global_lock+0x67/0x6c
>  [<c0293fdc>] acpi_ex_acquire_global_lock+0x14/0x3b
>  [<c028f578>] acpi_ex_read_data_from_field+0x114/0x14b
>  [<c029475b>] acpi_ex_resolve_node_to_value+0x123/0x1ac
>  [<c028fdc2>] acpi_ex_resolve_to_value+0x5e/0x69
>  [<c02923df>] acpi_ex_resolve_operands+0x277/0x4dc
>  [<c028a4fd>] acpi_ds_exec_end_op+0xab/0x36e
>  [<c0298fe6>] acpi_ps_parse_loop+0x5ba/0x8bc
>  [<c0298881>] acpi_ps_parse_aml+0x4e/0x1f9
>  [<c02998fb>] acpi_ps_execute_pass+0x72/0x83
>  [<c0299824>] acpi_ps_execute_method+0x54/0x7d
>  [<c0296c5f>] acpi_ns_execute_control_method+0x5a/0x67
>  [<c0296bee>] acpi_ns_evaluate_by_handle+0x73/0x8a
>  [<c0296aee>] acpi_ns_evaluate_relative+0xaa/0xc6
>  [<c0296375>] acpi_evaluate_object+0x139/0x1fb
>  [<c024e2e2>] copy_to_user+0x42/0x60
>  [<c02a0107>] acpi_battery_get_status+0x6b/0x11c
>  [<c02a056b>] acpi_battery_read_state+0x52/0x185
>  [<c01832d8>] seq_read+0xe8/0x2f0
>  [<c0162dba>] vfs_read+0xaa/0x1a0
>  [<c01631d1>] sys_read+0x51/0x80
>  [<c0102b5f>] sysenter_past_esp+0x54/0x75
> 
> This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.

Hopefully suspend2 isn't involved.  People would feel more comfortable if
you could test a vanilla mainline tree..

Could the ACPI team please take a look at fixing this regression?
