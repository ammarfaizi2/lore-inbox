Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWFRQNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWFRQNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFRQNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:13:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:40987 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932194AbWFRQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:13:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=erdoc7TRU0Uwvyjc0C1gXvSM6ot3i+T3HwFGezzXn56hWi/vcJN5aKFdbbGwidKulheI45Pi5+1TS3s+bWOkv9DWLJ0KOa1S//ysQWJXyqzg24faSYkS7WG1JLxjSkrbxlumf8JC0X6AExh6oR4mMhbN8QjXb7iA8YZQ+/UdQJc=
Message-ID: <6bffcb0e0606180913o5826a928gb7e8d0a6dc4f461c@mail.gmail.com>
Date: Sun, 18 Jun 2006 18:13:46 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060618070641.GA6759@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060618070641.GA6759@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 18/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.17-rt1 tree, which can be downloaded from the
> usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

I get this when I reboot my system.

Jun 18 17:59:26 ltg01-fedora kernel: skge eth0: disabling interface
Jun 18 17:59:27 ltg01-fedora kernel: BUG: using smp_processor_id() in
preemptible [00000000] code: modprobe/20325
Jun 18 17:59:27 ltg01-fedora kernel: caller is drain_array+0x15/0xe5
Jun 18 17:59:27 ltg01-fedora kernel:  [<c0104647>] show_trace+0xd/0xf (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c010470c>] dump_stack+0x17/0x19 (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c01da50f>]
debug_smp_processor_id+0x7b/0x8c (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e044>] drain_array+0x15/0xe5 (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e26e>] __cache_shrink+0x35/0xab (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015fac1>]
kmem_cache_destroy+0x76/0x12e (16)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc6d23e>]
ip_conntrack_cleanup+0x80/0xad [ip_conntrack] (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc7030e>]
ip_conntrack_standalone_fini+0x56/0x85 [ip_conntrack] (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c013a7c5>]
sys_delete_module+0x18f/0x1b6 (96)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c0102e73>]
sysenter_past_esp+0x54/0x75 (-4020)
Jun 18 17:59:27 ltg01-fedora kernel: ---------------------------
Jun 18 17:59:27 ltg01-fedora kernel: | preempt count: 00000001 ]
Jun 18 17:59:27 ltg01-fedora kernel: | 1-level deep critical section nesting:
Jun 18 17:59:27 ltg01-fedora kernel: ----------------------------------------
Jun 18 17:59:27 ltg01-fedora kernel: .. [<c01da4d5>] ....
debug_smp_processor_id+0x41/0x8c
Jun 18 17:59:27 ltg01-fedora kernel: .....[<c015e044>] ..   ( <=
drain_array+0x15/0xe5)
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: ------------------------------
Jun 18 17:59:27 ltg01-fedora kernel: | showing all locks held by: |
(modprobe/20325 [f72380b0, 117]):
Jun 18 17:59:27 ltg01-fedora kernel: ------------------------------
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: #001:             [c0313d04]
{cpucontrol.lock}
Jun 18 17:59:27 ltg01-fedora kernel: ... acquired at:
rt_down+0x11/0x28
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: BUG: modprobe:20325 task might
have lost a preemption check!
Jun 18 17:59:27 ltg01-fedora kernel:  [<c0104647>] show_trace+0xd/0xf (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c010470c>] dump_stack+0x17/0x19 (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c011a884>]
preempt_enable_no_resched+0x4c/0x51 (20)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c01da517>]
debug_smp_processor_id+0x83/0x8c (16)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e044>] drain_array+0x15/0xe5 (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e26e>] __cache_shrink+0x35/0xab (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015fac1>]
kmem_cache_destroy+0x76/0x12e (16)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc6d23e>]
ip_conntrack_cleanup+0x80/0xad [ip_conntrack] (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc7030e>]
ip_conntrack_standalone_fini+0x56/0x85 [ip_conntrack] (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c013a7c5>]
sys_delete_module+0x18f/0x1b6 (96)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c0102e73>]
sysenter_past_esp+0x54/0x75 (-4020)
Jun 18 17:59:27 ltg01-fedora kernel: ---------------------------
Jun 18 17:59:27 ltg01-fedora kernel: | preempt count: 00000000 ]
Jun 18 17:59:27 ltg01-fedora kernel: | 0-level deep critical section nesting:
Jun 18 17:59:27 ltg01-fedora kernel: ----------------------------------------
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: ------------------------------
Jun 18 17:59:27 ltg01-fedora kernel: | showing all locks held by: |
(modprobe/20325 [f72380b0, 117]):
Jun 18 17:59:27 ltg01-fedora kernel: ------------------------------
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: #001:             [c0313d04]
{cpucontrol.lock}
Jun 18 17:59:27 ltg01-fedora kernel: ... acquired at:
rt_down+0x11/0x28
Jun 18 17:59:27 ltg01-fedora kernel:
Jun 18 17:59:27 ltg01-fedora kernel: BUG: using smp_processor_id() in
preemptible [00000000] code: modprobe/20325
Jun 18 17:59:27 ltg01-fedora kernel: BUG: using smp_processor_id() in
preemptible [00000000] code: modprobe/20325
Jun 18 17:59:27 ltg01-fedora kernel: caller is drain_array+0x15/0xe5
Jun 18 17:59:27 ltg01-fedora kernel:  [<c0104647>] show_trace+0xd/0xf (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c010470c>] dump_stack+0x17/0x19 (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c01da50f>]
debug_smp_processor_id+0x7b/0x8c (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e044>] drain_array+0x15/0xe5 (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015e26e>] __cache_shrink+0x35/0xab (32)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c015fac1>]
kmem_cache_destroy+0x76/0x12e (16)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc6d248>]
ip_conntrack_cleanup+0x8a/0xad [ip_conntrack] (12)
Jun 18 17:59:27 ltg01-fedora kernel:  [<fdc7030e>]
ip_conntrack_standalone_fini+0x56/0x85 [ip_conntrack] (8)
Jun 18 17:59:27 ltg01-fedora kernel:  [<c013a7c5>]
sys_delete_module+0x18f/0x1b6 (96)
Jun 18 17:59:27 ltg01-fedora kernel: Kernel logging (proc) stopped.

Here is a config file
http://www.stardust.webpages.pl/files/rt/2.6.17-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
