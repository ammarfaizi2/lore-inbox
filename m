Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267698AbUHJVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267698AbUHJVGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUHJVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:06:47 -0400
Received: from hell.org.pl ([212.244.218.42]:47364 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S267698AbUHJVGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:06:44 -0400
Date: Tue, 10 Aug 2004 23:06:47 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Brown, Len" <len.brown@intel.com>
Cc: Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
Message-ID: <20040810210647.GA17943@hell.org.pl>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	acpi-devel@lists.sourceforge.net
References: <41189098.4000400@free.fr> <4118A500.1080306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <4118A500.1080306@free.fr>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Eric Valette:
> >I tried 2.6.8-rc4-mm1 on my ASUS L3800C laptop (radeon 7500), defined 
> >CONFIG_FB_MODE_HELPERS and I have got a hard freeze when starting X and 
> >framebuffer console with a lot of yellow dot on the bottom screen. 
> >Suddently I hear the fan meaning the machine is dead
> 
> OK I've reverted the most suspect change 
> (remove-unconditional-pci-acpi-irq-routing.patch) and it did not fix the 
> problem. As Karol Kozimor suspected ACPI, I then tried with acpi=off and 
> then it boot but I will burn my CPU as fans are ACPI controlled...

Here's more about my problem: it seems 2.6.8-rc3-mm1 sometimes manages to
boot here. Even so, kacpid completely hogs the CPU. dmesg and debug output
is at http://hell.org.pl/~sziwan/2.6.8-rc3-mm1.report (300 kB), DSDT is at
http://hell.org.pl/~sziwan/l3800c.dsl. Note the odd thermal zone output
(did somebody mention TZ problems?). Call trace below.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

Pid: 5, comm:               kacpid
EIP: 0060:[<c01e65c7>] CPU: 0
EIP is at acpi_os_get_thread_id+0x1f/0x2b
 EFLAGS: 00000246    Not tainted  (2.6.8-rc3-mm1)
EAX: 00000000 EBX: 00000000 ECX: c1272030 EDX: 00000000
ESI: c136bf28 EDI: cfeec028 EBP: 00000048 DS: 007b ES: 007b
CR0: 8005003b CR2: b7bd4000 CR3: 0fdce000 CR4: 00000690
 [<c020a7c9>] acpi_ut_acquire_mutex+0x34/0x159
 [<c02088a8>] acpi_ut_release_to_cache+0x44/0x94
 [<c020ad54>] acpi_ut_delete_generic_state+0x37/0x49
 [<c020c1ea>] acpi_ut_update_object_reference+0x9e/0x27f
 [<c020c4a8>] acpi_ut_remove_reference+0x81/0x99
 [<c01e8eca>] acpi_ds_get_predicate_value+0x196/0x1bd
 [<c01e94a1>] acpi_ds_exec_end_op+0x3e7/0x426
 [<c02011e5>] acpi_ps_parse_loop+0x6be/0x9ef
 [<c02015d8>] acpi_ps_parse_aml+0xc2/0x26e
 [<c0202229>] acpi_psx_execute+0x1d9/0x274
 [<c01fd981>] acpi_ns_execute_control_method+0xe2/0x100
 [<c01fd870>] acpi_ns_evaluate_by_handle+0xd7/0x106
 [<c01fd618>] acpi_ns_evaluate_relative+0x158/0x1b2
 [<c01fcae7>] acpi_evaluate_object+0x16a/0x263
 [<c01e6a82>] acpi_evaluate_integer+0x89/0x19c
 [<c01ed5ce>] acpi_ev_sci_xrupt_handler+0x4e/0x57
 [<c02094ad>] acpi_ut_status_exit+0x3e/0x4a
 [<c02094ad>] acpi_ut_status_exit+0x3e/0x4a
 [<c02093af>] acpi_ut_trace+0x28/0x2e
 [<c02179de>] acpi_thermal_get_temperature+0x62/0x9e
 [<c02185f2>] acpi_thermal_check+0x6e/0x2c6
 [<c020e2ac>] acpi_bus_get_device+0x9c/0xa7
 [<c02193c2>] acpi_thermal_notify+0x88/0xf6
 [<c01ee20d>] acpi_ev_notify_dispatch+0x57/0x60
 [<c01e5ee5>] acpi_os_execute_deferred+0x59/0x72
 [<c01226ed>] worker_thread+0x1ad/0x273
 [<c0112036>] activate_task+0x5c/0x6f
 [<c01e5e8c>] acpi_os_execute_deferred+0x0/0x72
 [<c01128dc>] default_wake_function+0x0/0xc
 [<c011291b>] __wake_up_common+0x33/0x56
 [<c01128dc>] default_wake_function+0x0/0xc
 [<c0122540>] worker_thread+0x0/0x273
 [<c0125c40>] kthread+0x90/0x95
 [<c0125bb0>] kthread+0x0/0x95
 [<c0102249>] kernel_thread_helper+0x5/0xb

