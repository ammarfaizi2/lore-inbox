Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJ2Tel>; Tue, 29 Oct 2002 14:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJ2Tej>; Tue, 29 Oct 2002 14:34:39 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:19159 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262230AbSJ2Tbw>; Tue, 29 Oct 2002 14:31:52 -0500
Message-ID: <3DBEE2A8.6020404@us.ibm.com>
Date: Tue, 29 Oct 2002 11:34:00 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, akpm@zip.com.au, mingo@redhat.com,
       mochel@osdl.org
Subject: Re: [PATCH] Hotplug CPUs for i386 2.5.44
References: <20021028080437.DE7112C0E3@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Doesn't apply to -mm5 because someone did wierd things with the CPU
> placement in driverfs, which clashes with this patch which moves it to
> kernel/cpu.c...
> 
> Usage:
> 1) Apply patch, and boot resulting kernel.
> 2) echo 0 > /devices/root/sys/cpu0/online
> 3) echo 1 > /devices/root/sys/cpu0/online
<grins sheepishly>

Errr..  you may want to use 
/devices/class/cpu/devices/[0..num_online_cpus()].  There are symlinks 
here for every registered CPU device, no matter how some NUMA wacko 
rearranges the root/sys directory topology.  ;)

Cheers!

-Matt


> The CPU actually spins with interrupts off, doing cpu_relax() and
> polling a variable.  It's basically useful for testing the unplug
> infrastructure and benchmarking.
> 
> http://www.kernel.org/pub/linux/kernel/people/rusty/patches/hotcpu-x86-28-10-2002.2.5.44.diff.gz
> 
> Cheers!
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


