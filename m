Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVEaI5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVEaI5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVEaI5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:57:33 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:55286 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261410AbVEaIzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:55:43 -0400
Message-ID: <429C2686.7030004@stud.feec.vutbr.cz>
Date: Tue, 31 May 2005 10:55:34 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: Eran Mann <emann@mrv.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-15
References: <20050527072810.GA7899@elte.hu>  <429C1206.5000707@mrv.com> <1117527531.19367.31.camel@ibiza.btsn.frna.bull.fr>
In-Reply-To: <1117527531.19367.31.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> Kernel: arch/i386/boot/bzImage is ready
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/scsi/qla2xxx/qla2xxx.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/shpchp.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/pciehp.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/ibmphp.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/pci/hotplug/cpqphp.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/net/plip.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/char/watchdog/cpu5wdt.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [drivers/block/sx8.ko] undefined!

Have you tried loading and using some of these modules with older -RT 
kernels? If they have been using init_MUTEX_LOCKED on RT semaphores, 
they should have BUG & Oops. Recent -RT kernels have added extra check 
for this during linking. The fact that you are prevented from building 
these modules is a Good Thing(TM).
Maybe these drivers should be using completions instead of semaphores.
A quick fix would be changing the 'struct semaphore' to 'struct 
compat_semaphore'.

Michal
