Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVDYAwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVDYAwc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 20:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVDYAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 20:52:32 -0400
Received: from fmr19.intel.com ([134.134.136.18]:1678 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262388AbVDYAwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 20:52:30 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20050423153501.5286b6c6.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050412105115.GD17903@elf.ucw.cz>
	 <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
	 <20050413083202.GA1361@elf.ucw.cz>
	 <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	 <20050423153501.5286b6c6.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1114390165.29778.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 25 Apr 2005 08:49:25 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 06:35, Andrew Morton wrote:
> fbcon is trying to call kmalloc before the slab system is initialised. 
> It would be best to fix that within fbcon.
This solves the problem too.

> Well as the comment says, if this CPU isn't online yet, and if the system
> has not yet reached SYSTEM_RUNNING state then we bale out of the printk
> because this cpu's per-cpu resources may not yet be fully set up.
After the CPU is offline (we are doing CPU hotplug). Its per-cpu
resources like kmalloc also aren't initialized. This is in
SYSTEM_RUNNING state too, so the system state doesn't matter. Removing
the system state check seems better than fixing the fbcon driver to me.

Thanks,
Shaohua

