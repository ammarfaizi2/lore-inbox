Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWITWHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWITWHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWITWHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:07:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:17790 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932231AbWITWHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:07:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ble6kmEz40Ze8Lo8uucJtT12eZOFHY3buQiFNi+ztLCpKt2VfdWLCXUsrWv1RKhKK/3FqVCPkXAF5ONBt6qPSwvpYIr+7AQ6OvGF7KSLKhgf+l9afVeWjmYleFDuNLOVHxUPg2iGOm/9lOouMkfzl8HdujwWpy9VrHfNW9f5do8=
Message-ID: <6bffcb0e0609201507o386eec1at8bb08d98dec2ea81@mail.gmail.com>
Date: Thu, 21 Sep 2006 00:07:47 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rt1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060920141907.GA30765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920141907.GA30765@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/06, Ingo Molnar <mingo@elte.hu> wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded
> from the usual place:
>

sudo /etc/init.d/iptables stop

ip_conntrack issue?

BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/20112
caller is drain_array+0x19/0xe6
[<c0104356>] show_trace_log_lvl+0x68/0x193
[<c0104a5a>] show_trace+0x1b/0x20
[<c0104b38>] dump_stack+0x1f/0x24
[<c01f7c3f>] debug_smp_processor_id+0x7f/0x90
[<c01711ea>] drain_array+0x19/0xe6
[<c0171442>] __cache_shrink+0x3b/0x7c
[<c0172e08>] kmem_cache_destroy+0x80/0x145
[<fd9423a8>] ip_conntrack_cleanup+0x88/0xbc [ip_conntrack]
[<fd94540c>] ip_conntrack_standalone_fini+0x5c/0x8b [ip_conntrack]
[<c0143e6f>] sys_delete_module+0x195/0x1be
[<c0103216>] sysenter_past_esp+0x63/0xa1
DWARF2 unwinder stuck at sysenter_past_esp+0x63/0xa1
Leftover inexact backtrace:
[<c0104a5a>] show_trace+0x1b/0x20
[<c0104b38>] dump_stack+0x1f/0x24
[<c01f7c3f>] debug_smp_processor_id+0x7f/0x90
[<c01711ea>] drain_array+0x19/0xe6
[<c0171442>] __cache_shrink+0x3b/0x7c
[<c0172e08>] kmem_cache_destroy+0x80/0x145
[<fd9423a8>] ip_conntrack_cleanup+0x88/0xbc [ip_conntrack]
[<fd94540c>] ip_conntrack_standalone_fini+0x5c/0x8b [ip_conntrack]
[<c0143e6f>] sys_delete_module+0x195/0x1be
[<c0103216>] sysenter_past_esp+0x63/0xa1
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01f7bfe>] .... debug_smp_processor_id+0x3e/0x90
.....[<c01711ea>] ..   ( <= drain_array+0x19/0xe6)
skipping trace printing on CPU#0 != -1
BUG: modprobe:20112 task might have lost a preemption check!
[<c0104356>] show_trace_log_lvl+0x68/0x193
[<c0104a5a>] show_trace+0x1b/0x20
[<c0104b38>] dump_stack+0x1f/0x24
[<c011cd8a>] preempt_enable_no_resched+0x48/0x4d
[<c01f7c47>] debug_smp_processor_id+0x87/0x90
[<c01711ea>] drain_array+0x19/0xe6
[<c0171442>] __cache_shrink+0x3b/0x7c
[<c0172e08>] kmem_cache_destroy+0x80/0x145
[<fd9423a8>] ip_conntrack_cleanup+0x88/0xbc [ip_conntrack]
[<fd94540c>] ip_conntrack_standalone_fini+0x5c/0x8b [ip_conntrack]
[<c0143e6f>] sys_delete_module+0x195/0x1be
[<c0103216>] sysenter_past_esp+0x63/0xa1
DWARF2 unwinder stuck at sysenter_past_esp+0x63/0xa1
Leftover inexact backtrace:
[<c0104a5a>] show_trace+0x1b/0x20
[<c0104b38>] dump_stack+0x1f/0x24
[<c011cd8a>] preempt_enable_no_resched+0x48/0x4d
[<c01f7c47>] debug_smp_processor_id+0x87/0x90
[<c01711ea>] drain_array+0x19/0xe6
[<c0171442>] __cache_shrink+0x3b/0x7c
[<c0172e08>] kmem_cache_destroy+0x80/0x145
[<fd9423a8>] ip_conntrack_cleanup+0x88/0xbc [ip_conntrack]
[<fd94540c>] ip_conntrack_standalone_fini+0x5c/0x8b [ip_conntrack]
[<c0143e6f>] sys_delete_module+0x195/0x1be
[<c0103216>] sysenter_past_esp+0x63/0xa1
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

l *0xc01f7bfe
0xc01f7bfe is in debug_smp_processor_id
(/usr/src/linux-rt/lib/smp_processor_id.c:42).
37              /*
38               * Avoid recursion:
39               */
40              preempt_disable();
41
42              if (!printk_ratelimit())
43                      goto out_enable;
44
45              printk(KERN_ERR "BUG: using smp_processor_id() in
preemptible [%08x] code: %s/%d\n", preempt_count()-1, current->comm,
current->pid);
46              print_symbol("caller is %s\n",
(long)__builtin_return_address(0));

l *0xc01711ea
0xc01711ea is in drain_array (/usr/src/linux-rt/mm/slab.c:3852).
3847                     struct array_cache *ac, int force, int node)
3848    {
3849            int this_cpu = smp_processor_id();
3850            int tofree;
3851
3852            if (!ac || !ac->avail)
3853                    return;
3854            if (ac->touched && !force) {
3855                    ac->touched = 0;
3856            } else {

http://www.stardust.webpages.pl/files/o_bugs/rt/2.6.18-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
