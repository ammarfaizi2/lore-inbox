Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUJDTsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUJDTsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJDTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:45:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:45000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268344AbUJDTjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:39:49 -0400
Date: Mon, 4 Oct 2004 12:37:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper
 call
Message-Id: <20041004123725.58f1e77c.akpm@osdl.org>
In-Reply-To: <20041004102220.A3304@unix-os.sc.intel.com>
References: <20041003100857.GB5804@optonline.net>
	<20041003162012.79296b37.akpm@osdl.org>
	<20041004102220.A3304@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
>  On Sun, Oct 03, 2004 at 04:20:12PM -0700, Andrew Morton wrote:
>  > Does CPU hotplug behave correctly wrt /sys/devices/system/cpu?  Given that
>  > register_cpu() is still marked __init, I assume not.
> 
>  Currently what we have in the kernel is logical cpu hotplug, i.e once the
>  cpu is registered via register_cpu() that cpu can only go offline and still
>  the entry for that cpu will be present in the /sys/devices/system/cpu/cpuX/online.
> 
>  So __init register_cpu() is fine untill we support unregister_cpu()
>  which is required for physical cpu hotplug case.
> 
>  I have submitted ACPI based physical cpu hotplug patches and waiting to here from
>  ACPI mainitainer Len Brown, there I have taken care to support unregister_cpu()
>  and register_cpu() is marked as __devinit in those patches.

OK...

But still, cpu_run_sbin_hotplug() should not exist.  It is duplicating
(indeed, emulating) kobject_hotplug() behaviour.  To the extent that it now
has a hardwired sysfs path embedded in it:

	sprintf(devpath_str, "DEVPATH=devices/system/cpu/cpu%d", cpu);

which should have been obtained from kobject_get_path().
