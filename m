Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWD2ATD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWD2ATD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 20:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWD2ATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 20:19:03 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:65180 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030223AbWD2ATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 20:19:01 -0400
Date: Sat, 29 Apr 2006 09:18:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, ebiederm@xmission.com,
       nanhai.zou@intel.com
Subject: Re: [Lhms-devel] Re: [PATCH] register hot-added memory to iomem
 resource
Message-Id: <20060429091839.ff8433e9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060428184349.GA28994@in.ibm.com>
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
	<20060427160130.6149550f.akpm@osdl.org>
	<20060428092754.cf382d03.kamezawa.hiroyu@jp.fujitsu.com>
	<20060428184349.GA28994@in.ibm.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 14:43:49 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Fri, Apr 28, 2006 at 09:27:54AM +0900, KAMEZAWA Hiroyuki wrote:
> > > And how is kdump to know that memory was hot-added?  Do we generate a
> > > hotplug event?
> > > 
> > A user program has to make memory section online from sysfs , anyway.
> > 
> > The hotplug script for memory hotplug will run at memory hotplug event 
> > from ACPI. If a user uses /probe interface (powerpc, x86_64),
> > he knows what he does. 
> > 
> > hot-add -> online memory -> kexec_load() is a scenario I think of.
> > 
> 
> Did a quick search but can't locate a memory hotplug agent. Can you give
> some pointers.
> 
Sorry, I think there is no generic memory hotplug agent now.
I do it by hand or handmaid scripts.
(Just because our target, NUMA-node-hotplug, is now under construction.)

In theory, ACPI namespace notifier calls memory hotplug agent and it just does
%echo online > /sys/devices/system/memory/memoryXXX/state.

After this, new memory is available.
This page has a bit more information. http://lhms.sourceforge.net/

BTW, could you teach me pointers to kexec/kload tools ?

-Kame

