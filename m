Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVEZF4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEZF4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVEZF4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:56:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:56981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbVEZF4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:56:10 -0400
Date: Wed, 25 May 2005 22:52:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: Hotplug CPU printk issue
Message-Id: <20050525225204.68bf0684.akpm@osdl.org>
In-Reply-To: <1117086211.7657.10.camel@linux-hp.sh.intel.com>
References: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	<1117076334.4086.11.camel@linux-hp.sh.intel.com>
	<20050525204828.70acc1b5.akpm@osdl.org>
	<1117086211.7657.10.camel@linux-hp.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> > Please confirm that we in fact do not want to allow downed CPUs to
>  > print things, then send a patch.
>  Yep. In the cpu hotplug case, per-cpu data possibly isn't initialized
>  even the system state is 'running'. As the comments say in the original
>  code, some console drivers assume per-cpu resources have been allocated.
>  radeon fb is one such driver, which uses kmalloc. After a CPU is down,
>  the per-cpu data of slab is freed, so the system crashed when printing
>  some info.

hm, that certainly sounds sane, but I do recall there were
reasonable-sounding reasons why the ia64 guys wanted printk-on-a-down-CPU
to work.  Hopefully David can remember what the problem was so we can find
a more thorough fix.

