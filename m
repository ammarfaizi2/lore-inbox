Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVEaIaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVEaIaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEaIaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:30:18 -0400
Received: from odin2.bull.net ([192.90.70.84]:21720 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261364AbVEaI3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:29:36 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Eran Mann <emann@mrv.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <429C1206.5000707@mrv.com>
References: <20050527072810.GA7899@elte.hu>  <429C1206.5000707@mrv.com>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1117527531.19367.31.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 31 May 2005 10:18:52 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 31/05/2005 à 09:28, Eran Mann a écrit :
> Ingo Molnar wrote:
> > i have released the -V0.7.47-10 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> I tried to compile -V0.7.47-15 and it fails to compile.
> net/sunrpc/sched.c: In function `rpc_run_timer':
> net/sunrpc/sched.c:107: error: `RPC_TASK_HAS_TIMER' undeclared (first 
> use in this function)
> ...
> 
> It seems the following hunk of the patch is bogus as it removes a 
> required define:
> 
> --- linux/include/linux/sunrpc/sched.h.orig
> +++ linux/include/linux/sunrpc/sched.h
> @@ -138,7 +138,6 @@ typedef void 
> (*rpc_action)(struct rpc_
>   #define RPC_TASK_RUNNING       0
>   #define RPC_TASK_QUEUED                1
>   #define RPC_TASK_WAKEUP                2
> -#define RPC_TASK_HAS_TIMER     3
> 
>   #define RPC_IS_RUNNING(t)      (test_bit(RPC_TASK_RUNNING, 
> &(t)->tk_runstate))
>   #define rpc_set_running(t)     (set_bit(RPC_TASK_RUNNING, 
> &(t)->tk_runstate))

We also have the following :

Kernel: arch/i386/boot/bzImage is ready
  Building modules, stage 2.
  MODPOST
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/scsi/qla2xxx/qla2xxx.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/shpchp.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/pciehp.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/ibmphp.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/cpqphp.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/net/plip.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/char/watchdog/cpu5wdt.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/block/sx8.ko] undefined!
...
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root -r 2.6.12-rc5-RT-V0.7.47-15-DAV06; fi
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/scsi/qla2xxx/qla2xxx.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/shpchp.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/pciehp.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/pci_hotplug.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/ibmphp.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/cpqphp.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/net/plip.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/char/watchdog/cpu5wdt.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-rc5-RT-V0.7.47-15-DAV06/kernel/drivers/block/sx8.ko needs unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
make[3]: *** [_modinst_post] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.89329 (%install)



