Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbVICER6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVICER6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVICER6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:17:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbVICER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:17:57 -0400
Date: Fri, 2 Sep 2005 21:16:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-mm1: hangs during boot ...
Message-Id: <20050902211609.5d706010.akpm@osdl.org>
In-Reply-To: <43191DBF.10407@bigpond.net.au>
References: <43184B8A.4040801@bigpond.net.au>
	<20050902131122.4c634211.akpm@osdl.org>
	<43191DBF.10407@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> Andrew Morton wrote:
> > Peter Williams <pwil3058@bigpond.net.au> wrote:
> > 
> >>... at the the point indicated by the following output:
> >>
> >>[    8.197224] Freeing unused kernel memory: 288k freed
> >>[    8.428217] SCSI subsystem initialized
> >>[    8.510376] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 11
> >>[    8.587731] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
> >>[    8.671531] sym0: SCSI BUS has been reset.
> >>[    8.725530] scsi0 : sym-2.2.1
> >>[   17.256480]  0:0:0:0: ABORT operation started.
> >>[   22.323534]  0:0:0:0: ABORT operation timed-out.
> >>[   22.384348]  0:0:0:0: DEVICE RESET operation started.
> >>[   27.458702]  0:0:0:0: DEVICE RESET operation timed-out.
> >>[   27.527544]  0:0:0:0: BUS RESET operation started.
> >>[   32.533775]  0:0:0:0: BUS RESET operation timed-out.
> >>[   32.599173]  0:0:0:0: HOST RESET operation started.
> >>[   32.669659] sym0: SCSI BUS has been reset.
> >>
> > 
> > 
> > Is there no response from sysrq-T?
> 
> Now that I've tried it there is a response.  I've attached the complete 
> output from the boot including the sysrq-T output in the hang.output 
> attachment to this e-mail.

Thanks.

> ...
> [  278.990398] Call Trace:
> [  279.024761]  [<c02279ff>] serio_thread+0xbf/0xf0
> [  279.085573]  [<c013b2a6>] kthread+0xa6/0xb0
> [  279.140552]  [<c01034d9>] kernel_thread_helper+0x5/0xc
> [  279.208130] insmod        D C171DCC0     0   227      1           232    70 )[  279.309031] d7f33b04 d7f33ab8 d8836bb0 c171dcc0 00001055 0fbf64f3 00000000 d
> [  279.408678]        0000e83b d7f33acc c01da354 d750e6ac d750e570 c130d160 0a9
> [  279.518639]        d7f32000 0a72aa15 00000002 00000246 c172de50 c172de50 d7f
> [  279.628599] Call Trace:
> [  279.662960]  [<c02d5c74>] wait_for_completion+0xa4/0x110
> [  279.732934]  [<c0245c16>] blk_execute_rq+0x66/0xb0
> [  279.796035]  [<d8836eb6>] scsi_execute+0xb6/0xd0 [scsi_mod]
> [  279.869446]  [<d8836f4d>] scsi_execute_req+0x7d/0xb0 [scsi_mod]
> [  279.947438]  [<d88393f6>] scsi_probe_lun+0xb6/0x1d0 [scsi_mod]
> [  280.024285]  [<d883995e>] scsi_probe_and_add_lun+0xde/0x1e0 [scsi_mod]
> [  280.110295]  [<d883a119>] scsi_scan_target+0xc9/0x140 [scsi_mod]
> [  280.189431]  [<d883a208>] scsi_scan_channel+0x78/0x90 [scsi_mod]
> [  280.268569]  [<d883a2e9>] scsi_scan_host_selected+0xc9/0x120 [scsi_mod]
> [  280.355722]  [<d883a362>] scsi_scan_host+0x22/0x30 [scsi_mod]
> [  280.431425]  [<d8864e45>] sym2_probe+0xf5/0x120 [sym53c8xx]
> [  280.504835]  [<c01e6ced>] pci_call_probe+0xd/0x10
> [  280.566791]  [<c01e6d39>] __pci_device_probe+0x49/0x60
> [  280.634369]  [<c01e6d79>] pci_device_probe+0x29/0x50
> [  280.699657]  [<c023e0ee>] driver_probe_device+0x3e/0xc0
> [  280.768486]  [<c023e25f>] __driver_attach+0x5f/0x70
> [  280.832628]  [<c023d7d3>] bus_for_each_dev+0x43/0x70
> [  280.897916]  [<c023e289>] driver_attach+0x19/0x20
> [  280.959770]  [<c023dc5b>] bus_add_driver+0x7b/0xd0
> [  281.022767]  [<c023e692>] driver_register+0x42/0x50
> [  281.086910]  [<c01e6fd0>] pci_register_driver+0x70/0x90
> [  281.155635]  [<d880202b>] sym2_init+0x2b/0x45 [sym53c8xx]
> [  281.226752]  [<c014340c>] sys_init_module+0xec/0x230
> [  281.292042]  [<c0105199>] syscall_call+0x7/0xb
> [  281.350458] scsi_eh_0     D 00000000     0   232      1                 227 )[  281.451357] d7a51ea0 d7a51e64 1e62bb57 00000000 d7a50000 1e62c494 00000000 d
> [  281.551005]        00000106 d79b0ab0 c130d160 d79b0bec d79b0ab0 c130d160 9de
> [  281.660963]        d7a50000 9de05c44 00000007 d7a50000 d7a51ef4 d7a51ef0 d7a
> [  281.770923] Call Trace:
> [  281.805288]  [<c02d5c74>] wait_for_completion+0xa4/0x110
> [  281.875159]  [<d8863490>] sym_eh_handler+0x240/0x290 [sym53c8xx]
> [  281.954293]  [<d88635fd>] sym53c8xx_eh_host_reset_handler+0x2d/0x50 [sym53c8][  282.050611]  [<d8835e9b>] scsi_try_host_reset+0x2b/0xa0 [scsi_mod]
> [  282.132041]  [<d883602c>] scsi_eh_host_reset+0x1c/0xa0 [scsi_mod]
> [  282.212324]  [<d88363f7>] scsi_eh_ready_devs+0x57/0x70 [scsi_mod]
> [  282.292604]  [<d883654f>] scsi_unjam_host+0x9f/0xc0 [scsi_mod]
> [  282.369451]  [<d8836629>] scsi_error_handler+0xb9/0xe0 [scsi_mod]
> [  282.449734]  [<c01034d9>] kernel_thread_helper+0x5/0xc
> 

scsi went ga-ga during insertion of the sym2 driver.  Usual culprits cc'ed ;)

