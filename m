Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUG2Idy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUG2Idy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUG2Idy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:33:54 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:58264 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267194AbUG2Idw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:33:52 -0400
Message-ID: <4108B66D.1050000@yahoo.com.au>
Date: Thu, 29 Jul 2004 18:33:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Dave Hansen <haveblue@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
References: <1089871489.10000.388.camel@nighthawk> <20040728234255.29ef4c13.pj@sgi.com>
In-Reply-To: <20040728234255.29ef4c13.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:

>I just hit what might be the same oops.
>
>I had not upgraded my working kernel for a month, and just now, when I
>upgraded to 2.6.8-rc2-mm1, running sn2_defconfig on a small SN2 system,
>it fails to boot everytime, ending with an Oops that starts out with:
>
>======================================================
>Freeing unused kernel memory: 320kB freed
>Unable to handle kernel NULL pointer dereference (address 0000000000000008)
>swapper[0]: Oops 8813272891392 [1]
>Modules linked in:
>
>Pid: 0, CPU 0, comm:              swapper
>psr : 0000101008022018 ifs : 8000000000000e20 ip  : [<a0000001000bd710>]    Not tainted
>ip is at find_busiest_group+0xb0/0x640
>======================================================
>
>I added a conditional printk_ratelimit'ed print at the top of
>find_busiest_group() whenever group is NULL, just before the first
>dereference of group in the line:
>
>	local_group = cpu_isset(this_cpu, group->cpumask);
>
>That print fires about 20,480 times each 5 second suppression window.
>
>But it boots, if I also add code to break out of the "do { ... } while
>(group != sd->groups)" loop, whenever group goes NULL.
>
>

OK, I still can't work out why this is happening. Can you try with
2.6.8-rc2-mm1? Does it happen continually after the system has booted?
If it happens in 2.6.8-rc2-mm1, comment out the call to cpu_attach_domain
in kernel/sched.c (so you'll only be using the dummy boot-up domain).
Does that fix it?

