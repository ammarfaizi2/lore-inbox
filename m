Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753356AbWKQWZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbWKQWZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbWKQWZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:25:10 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:44024 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753356AbWKQWZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=emQoupCvIDrzyMILBHx22XMrgO5nzshkfVLGGOaG3dfHnbaPD+evTII5xDwJV5yN6KPyaPthJYR0p0TEHkFIVC9t1zNY8iWpVZkHla+TXjv0iBcnn4HaQiczte42cKkOm5LukbrkjBdj7hkzHBiZ8WARaurrL6kWssUBwDw3zuU=
Message-ID: <8aa016e10611171425u6461a170ydf0b930b46b4ad85@mail.gmail.com>
Date: Sat, 18 Nov 2006 03:55:06 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       davej@codemonkey.org.uk, paul.s.diefenbaugh@intel.com, linux@brodo.de,
       denis.m.sadykov@intel.com
Subject: Re: [BUG][acpi-cpufreq/userspace-governor]Frequency does not change
Cc: linux-kernel@vger.kernel.org, suzuki@linux.vnet.ibm.com
In-Reply-To: <8aa016e10611171322h2f736d3fo413ec81298f6a8a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8aa016e10611171322h2f736d3fo413ec81298f6a8a2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so there was one thing which I had not tried. I tried to get back
to 1.86 Ghz. This is what happened,

The console first,
[root@localhost cpufreq]# echo 1862000 > scaling_setspeed
[dhaval@localhost ~]$
Message from syslogd@localhost at Sat Nov 18 03:51:49 2006 ...
localhost kernel: Oops: 0002 [1] SMP

Message from syslogd@localhost at Sat Nov 18 03:51:49 2006 ...
localhost kernel: last sysfs file:
/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

Message from syslogd@localhost at Sat Nov 18 03:51:49 2006 ...
localhost kernel: CR2: ffff81081f319a78

And then the dnesg
<snip>
userspace: cpufreq_set for cpu 0, freq 1862000 kHz
cpufreq-core: target for CPU 0: 1862000 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 1862000 (0)
freq-table: request for target 1862000 kHz (relation: 0) for cpu 0
freq-table: target is 0 (1862000 kHz, 0)
acpi-cpufreq: next_pref_state is 0
cpufreq-core: notification 0 of frequency transition to 1862000 kHz
userspace: saving cpu_cur_freq of cpu 0 to be 1862000 kHz
cpufreq-core: notification 1 of frequency transition to 1862000 kHz
Unable to handle kernel paging request at ffff81081f319a78 RIP:
 [<ffffffff804b36ce>] cpufreq_stats_update+0x38/0x52
PGD 8063 PUD 0
Oops: 0002 [1] SMP
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
CPU 0
Modules linked in:
Pid: 3635, comm: bash Not tainted 2.6.19-rc5-mm2 #11
RIP: 0010:[<ffffffff804b36ce>]  [<ffffffff804b36ce>]
cpufreq_stats_update+0x38/0x52
RSP: 0018:ffff810012c8fd28  EFLAGS: 00010202
RAX: 0000000000012fb0 RBX: 0000000000000000 RCX: ffff81001f319a80
RDX: 00000000ffffffff RSI: ffff81001f2f7c00 RDI: ffffffff80d47c00
RBP: 0000000100008f3f R08: ffffffff809bbc40 R09: 0000000000000000
R10: 0000000000000007 R11: ffff81001e73a778 R12: ffff810012c8fe18
R13: 0000000000000000 R14: ffffffff80d47b38 R15: 0000000000000001
FS:  00002aeeeb25fd30(0000) GS:ffffffff807e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffff81081f319a78 CR3: 000000001e87b000 CR4: 00000000000006e0
Process bash (pid: 3635, threadinfo ffff810012c8e000, task ffff81001e73a040)
Stack:  ffff810012c8fdd8 00000000ffffffff ffff81001f2f7c00 ffffffff804b372f
 ffff810012c8fe18 0000000000000000 ffff810012c8fe18 0000000000000001
 0000000000000000 ffffffff8054e528 ffffffff80d47bc0 ffff810012c8fe18
Call Trace:
 [<ffffffff804b372f>] cpufreq_stat_notifier_trans+0x47/0x75
 [<ffffffff8054e528>] notifier_call_chain+0x20/0x32
 [<ffffffff8023d273>] srcu_notifier_call_chain+0x36/0x4f
 [<ffffffff804b3168>] cpufreq_notify_transition+0xd0/0xe8
 [<ffffffff8021ba51>] acpi_cpufreq_target+0x2fb/0x359
 [<ffffffff804b3d3b>] store_speed+0xac/0xc5
 [<ffffffff804b1ad5>] store+0x44/0x5b
 [<ffffffff802ba23f>] sysfs_write_file+0xd3/0x107
 [<ffffffff802814b6>] vfs_write+0xad/0x153
 [<ffffffff80281a52>] sys_write+0x45/0x6e
 [<ffffffff8020953e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:


Code: 48 01 04 d1 48 89 6e 08 48 c7 c7 00 7c d4 80 e8 7d 85 09 00
RIP  [<ffffffff804b36ce>] cpufreq_stats_update+0x38/0x52
 RSP <ffff810012c8fd28>
CR2: ffff81081f319a78
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1
2 locks held by bash/3635:
 #0:  (userspace_mutex){--..}, at: [<ffffffff804b3cfa>] store_speed+0x6b/0xc5
 #1:  (&cpufreq_stats_lock){--..}, at: [<ffffffff804b36b3>]
cpufreq_stats_update+0x1d/0x52

Call Trace:
 [<ffffffff8020ac25>] show_trace+0x34/0x47
 [<ffffffff8020ac4a>] dump_stack+0x12/0x17
 [<ffffffff80245725>] down_read+0x15/0x40
 [<ffffffff8023cbdb>] blocking_notifier_call_chain+0x13/0x36
 [<ffffffff8023308a>] do_exit+0x20/0x807
 [<ffffffff8054e488>] do_page_fault+0x738/0x7b8
 [<ffffffff8054c49d>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
 [<ffffffff804b36ce>] cpufreq_stats_update+0x38/0x52
 [<ffffffff804b36b3>] cpufreq_stats_update+0x1d/0x52
 [<ffffffff804b372f>] cpufreq_stat_notifier_trans+0x47/0x75
 [<ffffffff8054e528>] notifier_call_chain+0x20/0x32
 [<ffffffff8023d273>] srcu_notifier_call_chain+0x36/0x4f
 [<ffffffff804b3168>] cpufreq_notify_transition+0xd0/0xe8
 [<ffffffff8021ba51>] acpi_cpufreq_target+0x2fb/0x359
 [<ffffffff8054a79d>] __mutex_lock_slowpath+0x230/0x23b
 [<ffffffff804b3d3b>] store_speed+0xac/0xc5
 [<ffffffff804b1ad5>] store+0x44/0x5b
 [<ffffffff802ba23f>] sysfs_write_file+0xd3/0x107
 [<ffffffff802814b6>] vfs_write+0xad/0x153
 [<ffffffff80281a52>] sys_write+0x45/0x6e
 [<ffffffff8020953e>] system_call+0x7e/0x83

Thanks
Dhaval

On 11/18/06, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> Hey there,
>
> Looks like I spoke too soon. I tried changing the frequency in cpu1
> and then it all fell apart. I got a ridiculously high value. To test
> it, I rebooted my system, and this is what happened.
>
> [root@localhost dhaval]# cd /sys/devices/system/cpu/cpu0/cpufreq/
> [root@localhost cpufreq]# cat *
> 0
> 1862000
> 1862000
> 1596000
> 1862000 1596000
> ondemand userspace
> 1862000
> acpi-cpufreq
> userspace
> 1862000
> 1596000
> 1862000
> cat: stats: Is a directory
> [root@localhost cpufreq]# echo 1596000 > scaling_setspeed
> [root@localhost cpufreq]# cat *
> 0
> 1862000
> 1862000
> 1596000
> 1862000 1596000
> ondemand userspace
> 0
> acpi-cpufreq
> userspace
> 1862000
> 1596000
> 0
> cat: stats: Is a directory
> [root@localhost cpufreq]# cd ../../cpu1/cpufreq/
> [root@localhost cpufreq]# cat *
> 1
> 1862000
> 1862000
> 1596000
> 1862000 1596000
> ondemand userspace
> 1862000
> acpi-cpufreq
> userspace
> 1862000
> 1596000
> 1862000
> cat: stats: Is a directory
> [root@localhost cpufreq]# echo 1596000 > scaling_setspeed
> [root@localhost cpufreq]# cat *
> 1
> 1596000
> 1862000
> 1596000
> 1862000 1596000
> ondemand userspace
> 4294967295
> acpi-cpufreq
> userspace
> 1862000
> 1596000
> 4294967295
> cat: stats: Is a directory
> [root@localhost cpufreq]# cd ../../cpu1/cpufreq
> [root@localhost cpufreq]# cat *
> 1
> 1596000
> 1862000
> 1596000
> 1862000 1596000
> ondemand userspace
> 4294967295
> acpi-cpufreq
> userspace
> 1862000
> 1596000
> 4294967295
> cat: stats: Is a directory
>
>
> The dmesg is as follows,
> acpi-cpufreq: get_cur_freq_on_cpu (0)
> acpi-cpufreq: get_cur_val = 100665128
> acpi-cpufreq: cur freq = 1862000
> userspace: cpufreq_set for cpu 0, freq 1596000 kHz
> cpufreq-core: target for CPU 0: 1596000 kHz, relation 0
> acpi-cpufreq: acpi_cpufreq_target 1596000 (0)
> freq-table: request for target 1596000 kHz (relation: 0) for cpu 0
> freq-table: target is 1 (1596000 kHz, 9)
> cpufreq-core: notification 0 of frequency transition to 0 kHz
> userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
> cpufreq-core: notification 1 of frequency transition to 0 kHz
> userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
> acpi-cpufreq: get_cur_freq_on_cpu (0)
> printk: 2 messages suppressed.
> acpi-cpufreq: get_cur_freq_on_cpu (1)
> acpi-cpufreq: get_cur_val = 100665128
> acpi-cpufreq: cur freq = 1862000
> userspace: cpufreq_set for cpu 1, freq 1596000 kHz
> cpufreq-core: target for CPU 1: 1596000 kHz, relation 0
> acpi-cpufreq: acpi_cpufreq_target 1596000 (1)
> freq-table: request for target 1596000 kHz (relation: 0) for cpu 1
> freq-table: target is 1 (1596000 kHz, 9)
> cpufreq-core: notification 0 of frequency transition to 4294967295 kHz
> printk: 6 messages suppressed.
> acpi-cpufreq: get_cur_freq_on_cpu (0)
> acpi-cpufreq: get_cur_val = 100664859
> acpi-cpufreq: cur freq = 1596000
> acpi-cpufreq: get_cur_freq_on_cpu (1)
> acpi-cpufreq: get_cur_val = 100664859
> acpi-cpufreq: cur freq = 1596000
> [root@localhost cpufreq]#
>
> This is on the 2.6.19-rc5-mm2 with the patch at
> http://lkml.org/lkml/2006/11/15/302 applied.
>
> Thanks and regards
> Dhaval Giani
>
