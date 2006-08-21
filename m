Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWHUHh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWHUHh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWHUHh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:37:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40079 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965062AbWHUHh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:37:26 -0400
Message-ID: <44E9624D.4060203@cn.ibm.com>
Date: Mon, 21 Aug 2006 15:35:41 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:463
References: <44E942ED.9010502@cn.ibm.com> <20060821053833.GA9828@localdomain>
In-Reply-To: <20060821053833.GA9828@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

>Hi,
>
>Yao Fei Zhu wrote:
>  
>
>>Hi, all
>>
>>Online and offline cpus in 2.6.18-rc4/PPC64 will trigger Call Trace
>>like this,
>>
>>[root@blade11 ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
>>[root@blade11 ~]# dmesg -c
>>BUG: sleeping function called from invalid context at 
>>arch/powerpc/kernel/rtas.c:463
>>in_atomic():0, irqs_disabled():1
>>Call Trace:
>>[C0000000725EB9C0] [C00000000000FB70] .show_stack+0x68/0x1b0 (unreliable)
>>[C0000000725EBA60] [C000000000053EB4] .__might_sleep+0xd8/0xf4
>>[C0000000725EBAE0] [C00000000001D5D8] .rtas_busy_delay+0x20/0x5c
>>[C0000000725EBB70] [C00000000001DC00] .rtas_set_indicator+0x6c/0xcc
>>[C0000000725EBC10] [C000000000049130] .xics_migrate_irqs_away+0x6c/0x20c
>>[C0000000725EBCD0] [C000000000048EEC] .pSeries_cpu_disable+0x98/0xb4
>>[C0000000725EBD50] [C000000000029A24] .__cpu_disable+0x44/0x58
>>[C0000000725EBDC0] [C000000000082030] .take_cpu_down+0x10/0x38
>>[C0000000725EBE40] [C000000000090000] .do_stop+0x16c/0x20c
>>[C0000000725EBEE0] [C000000000078EBC] .kthread+0x128/0x178
>>[C0000000725EBF90] [C0000000000271DC] .kernel_thread+0x4c/0x68
>>    
>>
>
>
>The fix for this was committed to Linus's tree after 2.6.18-rc4; look for
>
>[POWERPC] Fix might-sleep warning on removing cpus
>
>in the change history.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Yes, tested the fix, thanks.

