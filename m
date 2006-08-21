Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWHUFii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWHUFii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHUFii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:38:38 -0400
Received: from rune.pobox.com ([208.210.124.79]:27532 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932603AbWHUFih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:38:37 -0400
Date: Mon, 21 Aug 2006 00:38:33 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:463
Message-ID: <20060821053833.GA9828@localdomain>
References: <44E942ED.9010502@cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E942ED.9010502@cn.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yao Fei Zhu wrote:
> Hi, all
> 
> Online and offline cpus in 2.6.18-rc4/PPC64 will trigger Call Trace
> like this,
> 
> [root@blade11 ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
> [root@blade11 ~]# dmesg -c
> BUG: sleeping function called from invalid context at 
> arch/powerpc/kernel/rtas.c:463
> in_atomic():0, irqs_disabled():1
> Call Trace:
> [C0000000725EB9C0] [C00000000000FB70] .show_stack+0x68/0x1b0 (unreliable)
> [C0000000725EBA60] [C000000000053EB4] .__might_sleep+0xd8/0xf4
> [C0000000725EBAE0] [C00000000001D5D8] .rtas_busy_delay+0x20/0x5c
> [C0000000725EBB70] [C00000000001DC00] .rtas_set_indicator+0x6c/0xcc
> [C0000000725EBC10] [C000000000049130] .xics_migrate_irqs_away+0x6c/0x20c
> [C0000000725EBCD0] [C000000000048EEC] .pSeries_cpu_disable+0x98/0xb4
> [C0000000725EBD50] [C000000000029A24] .__cpu_disable+0x44/0x58
> [C0000000725EBDC0] [C000000000082030] .take_cpu_down+0x10/0x38
> [C0000000725EBE40] [C000000000090000] .do_stop+0x16c/0x20c
> [C0000000725EBEE0] [C000000000078EBC] .kthread+0x128/0x178
> [C0000000725EBF90] [C0000000000271DC] .kernel_thread+0x4c/0x68


The fix for this was committed to Linus's tree after 2.6.18-rc4; look for

[POWERPC] Fix might-sleep warning on removing cpus

in the change history.
