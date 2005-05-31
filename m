Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVEaMJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVEaMJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEaMJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:09:28 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:43695 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261328AbVEaMJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:09:14 -0400
Date: Tue, 31 May 2005 08:09:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-15
In-reply-to: <1117527531.19367.31.camel@ibiza.btsn.frna.bull.fr>
To: linux-kernel@vger.kernel.org
Message-id: <200505310809.11887.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <20050527072810.GA7899@elte.hu> <429C1206.5000707@mrv.com>
 <1117527531.19367.31.camel@ibiza.btsn.frna.bull.fr>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 04:18, Serge Noiraud wrote:
>Le mar 31/05/2005 à 09:28, Eran Mann a écrit :
>> Ingo Molnar wrote:
>> > i have released the -V0.7.47-10 Real-Time Preemption patch,
>> > which can be downloaded from the usual place:
>> >
>> >     http://redhat.com/~mingo/realtime-preempt/
>>
>> I tried to compile -V0.7.47-15 and it fails to compile.
>> net/sunrpc/sched.c: In function `rpc_run_timer':
>> net/sunrpc/sched.c:107: error: `RPC_TASK_HAS_TIMER' undeclared
>> (first use in this function)
>> ...
>>
>> It seems the following hunk of the patch is bogus as it removes a
>> required define:
>>
>> --- linux/include/linux/sunrpc/sched.h.orig
>> +++ linux/include/linux/sunrpc/sched.h
>> @@ -138,7 +138,6 @@ typedef void
>> (*rpc_action)(struct rpc_
>>   #define RPC_TASK_RUNNING       0
>>   #define RPC_TASK_QUEUED                1
>>   #define RPC_TASK_WAKEUP                2
>> -#define RPC_TASK_HAS_TIMER     3
>>
>>   #define RPC_IS_RUNNING(t)      (test_bit(RPC_TASK_RUNNING,
>> &(t)->tk_runstate))
>>   #define rpc_set_running(t)     (set_bit(RPC_TASK_RUNNING,
>> &(t)->tk_runstate))
>
>We also have the following :
>
>Kernel: arch/i386/boot/bzImage is ready
>  Building modules, stage 2.
>  MODPOST
>*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/scsi/qla2xxx/qla2xxx.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/pci/hotplug/shpchp.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/pci/hotplug/pciehp.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/pci/hotplug/pci_hotplug.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/pci/hotplug/ibmphp.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/pci/hotplug/cpqphp.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/net/plip.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/char/watchdog/cpu5wdt.ko] undefined! *** Warning:
> "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
> [drivers/block/sx8.ko] undefined! ...
>if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> System.map -b /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root -r
> 2.6.12-rc5-RT-V0.7.47-15-DAV06; fi WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/scsi/qla2xxx/qla2xxx.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/shpchp.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/pciehp.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/pci_hotplug.ko
> needs unknown symbol
> there_is_no_init_MUTEX_LOCKED_for_RT_semaphores WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/ibmphp.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/pci/hotplug/cpqphp.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/net/plip.ko needs unknown
> symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/char/watchdog/cpu5wdt.ko needs
> unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> WARNING:
> /var/tmp/kernel-2.6.12rc5RTV0.7.4715DAV06-root/lib/modules/2.6.12-r
>c5-RT-V0.7.47-15-DAV06/kernel/drivers/block/sx8.ko needs unknown
> symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores make[3]: ***
> [_modinst_post] Error 1
>error: Bad exit status from /var/tmp/rpm-tmp.89329 (%install)

I had no such error, applying the 
realtime-preempt-2.6.12-rc5-V0.7.47-15 patch to rc5-git5 (other than 
the Makefile, easily fixed, and lib/Kconfig.debug, as git5 had 
already played with the location of the frame pointers option.  I 
left it at the git5 level, seemed to work.  Its built, but not 
rebooted to, working on wedding photo's for the neighbors ATM.

I used the "linux-2.6.12-rc5-git5-RT-V0.7.47-15" throughout _my_ 
scripts and the Makefile as the version number.  I note your error 
messages seem to indicate a miss-match there.

So many thanks to the original poster, whose message prompted me to 
take another swing at it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
