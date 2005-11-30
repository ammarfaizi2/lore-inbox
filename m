Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVK3Am3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVK3Am3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVK3Am3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:42:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750732AbVK3Am2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:42:28 -0500
Date: Tue, 29 Nov 2005 16:42:22 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       torvalds@osdl.org
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129164222.66d00ca1@dxpl.pdx.osdl.net>
In-Reply-To: <20051129162519.1ef07387.akpm@osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	<200511292247.09243.rjw@sisk.pl>
	<200511292342.36228.rjw@sisk.pl>
	<20051129145328.3e5964a4@dxpl.pdx.osdl.net>
	<20051129233744.GA32316@kroah.com>
	<20051129161731.69ce252c@dxpl.pdx.osdl.net>
	<20051129162519.1ef07387.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005 16:25:19 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > [  125.653485]  <1>Fixing recursive fault but reboot is needed!
> >  [  125.653620] ----------- [cut here ] --------- [please bite here ] ---------
> >  [  125.653622] Kernel BUG at mm/mmap.c:1956
> >  [  125.653624] invalid operand: 0000 [727] SMP
> >  [  125.653625] CPU 0
> >  [  125.653627] Modules linked in:
> >  [  125.653629] Pid: 746, comm: hotplug Not tainted 2.6.15-rc3 #1
> >  [  125.653631] RIP: 0010:[<ffffffff8016cecb>] <ffffffff8016cecb>{exit_mmap+235}
> >  [  125.653636] RSP: 0018:ffff81007ebcfeb8  EFLAGS: 00010202
> >  [  125.653639] RAX: 0000000000000000 RBX: ffff810002c0e3e0 RCX: 00000000000005b4
> >  [  125.653642] RDX: 000000000000000f RSI: ffff81007fc2ead8 RDI: ffff81007ff5ca80
> >  [  125.653645] RBP: 0000000000000000 R08: ffff81007ff2c920 R09: 0000000000000000
> >  [  125.653647] R10: 0000000000000000 R11: 0000000000000246 R12: ffff81007eb785c0
> >  [  125.653649] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000000
> >  [  125.653653] FS:  0000000000587850(0000) GS:ffffffff805c6800(0000) knlGS:0000000000000000
> >  [  125.653655] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  [  125.653658] CR2: 000000000040a9b0 CR3: 0000000000101000 CR4: 00000000000006e0
> >  [  125.653661] Process hotplug (pid: 746, threadinfo ffff81007ebce000, task ffff81007ebcafa0)
> >  [  125.653663] Stack: 000000000000003c ffff810002c0e3e0 ffff81007eb785c0 ffff81007eb78638
> >  [  125.653668]        ffff81007ebcafa0 ffffffff80130d61 0000000000000100 0000000000000100
> >  [  125.653672]        ffff81007ebcb5e4 ffffffff80135bb2
> >  [  125.653675] Call Trace:<ffffffff80130d61>{mmput+49} <ffffffff80135bb2>{do_exit+578}
> >  [  125.653682]        <ffffffff8024f961>{__up_write+49} <ffffffff801366b8>{do_group_exit+248}
> >  [  125.653687]        <ffffffff8010dcee>{system_call+126}
> >  [  125.653691]
> >  [  125.653692] Code: 0f 0b 68 de 7e 3e 80 c2 a4 07 48 83 c4 10 5b 5d 41 5c c3 66
> >  [  125.653700] RIP <ffffffff8016cecb>{exit_mmap+235} RSP <ffff81007ebcfeb8>
> >  [  125.653704]  <1>Fixing recursive fault but reboot is needed!
> >  [  125.653841] ----------- [cut here ] --------- [please bite here ] ---------
> >  [  125.653843] Kernel BUG at mm/mmap.c:1956
> 
> That's
> 
>         BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
> 
> It's hard to see how this is caused by a USB patch.
> 
> Are you using the very latest Linus tree?  You should...

Yes, when I retested with the usb patch it was against a fresh git pull.
So it probably isn't a USB problem but something that got introduced between
the two (2.6.15-rc3 vs latest).

I'll go back to the 2.6.15-rc3 tree and test usb fix.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
