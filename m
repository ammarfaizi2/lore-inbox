Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVDEBJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDEBJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 21:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDEBJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 21:09:08 -0400
Received: from fmr19.intel.com ([134.134.136.18]:680 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261464AbVDEBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 21:09:03 -0400
Subject: Re: [RFC 5/6]clean cpu state after hotremove CPU
From: Li Shaohua <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1112663194.17861.12.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Apr 2005 09:06:34 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 03:11, Zwane Mwaikambo wrote:
> On Mon, 4 Apr 2005, Li Shaohua wrote:
> 
> > Clean up all CPU states including its runqueue and idle thread, 
> > so we can use boot time code without any changes.
> > Note this makes /sys/devices/system/cpu/cpux/online unworkable.
> >  
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  #include <asm/nmi.h>
> > +
> > +#ifdef CONFIG_STR_SMP
> > +extern void cpu_exit_clear(int);
> > +#endif
> 
> Perhaps change that ifdef to denote something which clearly shows that its 
> physical hotplug as we'll need this for other users too.
Ok.

> > +#ifdef CONFIG_STR_SMP
> > +extern void do_exit_idle(void);
> > +extern void cpu_uninit(void);
> > +void cpu_exit_clear(int cpu)
> > +{
> > +	int sibling;
> > +	cpucount --;
> 
> Is that protected by the cpu_control semaphore?
cpu_exit_clear is called before the dead CPU ack CPU_DEAD, so it's
finished before __cpu_die returns, which is protected by cpu_control.
Maybe I should add comments for it.

Thanks,
Shaohua

