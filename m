Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVDDTMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVDDTMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDDTKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:10:40 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:8843 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261338AbVDDTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:09:27 -0400
Date: Mon, 4 Apr 2005 13:11:32 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 5/6]clean cpu state after hotremove CPU
In-Reply-To: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Li Shaohua wrote:

> Clean up all CPU states including its runqueue and idle thread, 
> so we can use boot time code without any changes.
> Note this makes /sys/devices/system/cpu/cpux/online unworkable.
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  #include <asm/nmi.h>
> +
> +#ifdef CONFIG_STR_SMP
> +extern void cpu_exit_clear(int);
> +#endif

Perhaps change that ifdef to denote something which clearly shows that its 
physical hotplug as we'll need this for other users too.

> +#ifdef CONFIG_STR_SMP
> +extern void do_exit_idle(void);
> +extern void cpu_uninit(void);
> +void cpu_exit_clear(int cpu)
> +{
> +	int sibling;
> +	cpucount --;

Is that protected by the cpu_control semaphore?

Thanks,
	Zwane

