Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271239AbUJVLy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271239AbUJVLy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271238AbUJVLy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:54:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56448 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S271239AbUJVLyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:54:33 -0400
Date: Fri, 22 Oct 2004 13:54:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041022115456.GA991@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FADC.6030905@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177FADC.6030905@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Oct 21 12:33:22 porky kernel: BUG: atomic counter underflow at:
> Oct 21 12:33:22 porky kernel:  [<c0254dd8>] qdisc_destroy+0x98/0xa0 (12)
> Oct 21 12:33:22 porky kernel:  [<c0254fed>] dev_shutdown+0x3d/0xa0 (16)
> Oct 21 12:33:22 porky kernel:  [<c024773b>] unregister_netdevice+0x13b/0x280 (28)
> Oct 21 12:33:22 porky netfs: Mounting other filesystems:  succeeded
> Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (12)
> Oct 21 12:33:22 porky kernel:  [<e09a6160>] tulip_remove_one+0x0/0xa0 [tulip] (4)
> Oct 21 12:33:22 porky kernel:  [<c02058de>] unregister_netdev+0x1e/0x30 (24)
> Oct 21 12:33:22 porky kernel:  [<e09a618f>] tulip_remove_one+0x2f/0xa0 [tulip] (16)
> Oct 21 12:33:22 porky kernel:  [<c01f2907>] device_release_driver+0x67/0x70 (8)
> Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (8)
> Oct 21 12:33:22 porky kernel:  [<c01c4e26>] pci_device_remove+0x76/0x80 (20)
> Oct 21 12:33:22 porky kernel:  [<c01f573b>] device_detach_shutdown+0xb/0x40 (12)
> Oct 21 12:33:22 porky kernel:  [<c01f2907>] device_release_driver+0x67/0x70 (12)
> Oct 21 12:33:22 porky kernel:  [<c01f293b>] driver_detach+0x2b/0x40 (24)
> Oct 21 12:33:22 porky kernel:  [<c01f2daf>] bus_remove_driver+0x3f/0x70 (20)
> Oct 21 12:33:22 porky kernel:  [<c01f32b9>] driver_unregister+0x19/0x30 (20)
> Oct 21 12:33:22 porky kernel:  [<c01c50cc>] pci_unregister_driver+0x1c/0x30 (16)
> Oct 21 12:33:22 porky kernel:  [<e09a7767>] tulip_cleanup+0x17/0x1b [tulip] (16)
> Oct 21 12:33:22 porky kernel:  [<c0139801>] sys_delete_module+0x121/0x150 (12)
> Oct 21 12:33:22 porky kernel:  [<c01531a1>] sys_munmap+0x51/0x60 (64)
> Oct 21 12:33:22 porky kernel:  [<c0116a20>] do_page_fault+0x0/0x660 (16)
> Oct 21 12:33:22 porky kernel:  [<c0106719>] sysenter_past_esp+0x52/0x71 (16)

i think this is an upstream bug that the atomic-counter debugging assert
triggers. Jeff, the assert above shows qdisc->refcnt underflowing from 0
to -1. So the qdisc_destroy() [or dev_shutdown()?] use is inbalanced. 
Plus rtl8139 is doing this too, see the log below. The upstream kernel
does not notice this condition. Or is ->refcnt allowed to underflow?

	Ingo

Oct 20 16:47:18 localhost kernel: BUG: atomic counter underflow at:
Oct 20 16:47:18 localhost kernel:  [<c02b8d88>] qdisc_destroy+0x98/0xa0 (12)
Oct 20 16:47:18 localhost kernel:  [<c02b8f9d>] dev_shutdown+0x3d/0xa0 (16)
Oct 20 16:47:18 localhost kernel:  [<c02aa38b>] unregister_netdevice+0x13b/0x280 (28)
Oct 20 16:47:18 localhost kernel:  [<c01148b0>] mcount+0x14/0x18 (8)
Oct 20 16:47:18 localhost kernel:  [<e0836b10>] rtl8139_remove_one+0x0/0xa0 [8139too] (4)
Oct 20 16:47:18 localhost kernel:  [<c0241f8e>] unregister_netdev+0x1e/0x30 (24)
Oct 20 16:47:18 localhost kernel:  [<e0836b3a>] rtl8139_remove_one+0x2a/0xa0 [8139too] (16)
Oct 20 16:47:18 localhost kernel:  [<c01148b0>] mcount+0x14/0x18 (12)
Oct 20 16:47:18 localhost kernel:  [<c01e4016>] pci_device_remove+0x76/0x80 (20)
Oct 20 16:47:18 localhost kernel:  [<c02306cb>] device_detach_shutdown+0xb/0x40 (12)
Oct 20 16:47:18 localhost kernel:  [<c022d817>] device_release_driver+0x67/0x70 (12)
Oct 20 16:47:18 localhost kernel:  [<c022d84b>] driver_detach+0x2b/0x40 (24)
Oct 20 16:47:18 localhost kernel:  [<c022dcbf>] bus_remove_driver+0x3f/0x70 (20)
Oct 20 16:47:18 localhost kernel:  [<c022e1c9>] driver_unregister+0x19/0x30 (20)
Oct 20 16:47:18 localhost kernel:  [<c01e42bc>] pci_unregister_driver+0x1c/0x30 (16)
Oct 20 16:47:18 localhost kernel:  [<e0838b07>] rtl8139_cleanup_module+0x17/0x1b [8139too] (16)
Oct 20 16:47:18 localhost kernel:  [<c013c8d1>] sys_delete_module+0x121/0x150 (12)
Oct 20 16:47:18 localhost kernel:  [<c01596a4>] sys_munmap+0x54/0x70 (64)
Oct 20 16:47:18 localhost kernel:  [<c0118560>] do_page_fault+0x0/0x6d0 (16)
Oct 20 16:47:18 localhost kernel:  [<c0107b49>] sysenter_past_esp+0x52/0x71 (16)
