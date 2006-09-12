Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWILWCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWILWCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWILWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:02:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:10699 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030341AbWILWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:02:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Nhx6G+LlfpOshSqzn/ZY1d0wBpgdap3jnFM67e0z+GquQWcLv5j+Wbo6fc6HJeu5b9f4gSphwkSQMQLNPpr2xbFOnEJxZ3NaZ1q6jfJqY2Vyq5dkGPbpAGNWuZ4FTSVVaJZsEn5yKkcQGVAi9EOM3yFwKP7teib6kfomhcPSy2Q=
Message-ID: <45072E7A.2080701@gmail.com>
Date: Wed, 13 Sep 2006 00:02:11 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-rc6-mm2
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609121211t2dec0e49qb8d3dbfad2476852@mail.gmail.com>
In-Reply-To: <6bffcb0e0609121211t2dec0e49qb8d3dbfad2476852@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/ 
>>
>>
> 
> My FC6T2 bug appeared in -mm
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202223
> 
> Any ideas about this?

Hi,
this is known:
http://lkml.org/lkml/2006/9/8/56

> echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> 
> CPU 1 is now offline
> lockdep: not fixing up alternatives.
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.18-rc6-mm2 #120
> -------------------------------------------------------
> bash/1961 is trying to acquire lock:
> ((cpu_chain).rwsem){----}, at: [<c012e289>]
> blocking_notifier_call_chain+0x11/0x2d
> 
> but task is already holding lock:
> (workqueue_mutex){--..}, at: [<c02f8156>] mutex_lock+0x1c/0x1f
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> -> #1 (workqueue_mutex){--..}:
>       [<c0138b97>] add_lock_to_list+0x5c/0x7a
>       [<c013aca0>] __lock_acquire+0x9ec/0xae8
>       [<c013b0fc>] lock_acquire+0x6b/0x88
>       [<c02f7f1b>] __mutex_lock_slowpath+0xd6/0x2f5
>       [<c02f8156>] mutex_lock+0x1c/0x1f
>       [<c01312de>] workqueue_cpu_callback+0x109/0x1ff
>       [<c012de43>] notifier_call_chain+0x20/0x31
>       [<c012e295>] blocking_notifier_call_chain+0x1d/0x2d
>       [<c013f867>] _cpu_down+0x48/0x207
>       [<c013fbf8>] disable_nonboot_cpus+0x98/0x12c
>       [<c01451d6>] prepare_processes+0xe/0x41
>       [<c014539e>] pm_suspend_disk+0x9/0xe2
>       [<c0144635>] enter_state+0x53/0x177
>       [<c01447df>] state_store+0x86/0x9c
>       [<c01abde4>] subsys_attr_store+0x20/0x25
>       [<c01abee3>] sysfs_write_file+0xa6/0xcc
>       [<c0174d60>] vfs_write+0xcd/0x174
>       [<c01753fa>] sys_write+0x3b/0x71
>       [<c0103156>] sysenter_past_esp+0x5f/0x99
>       [<ffffffff>] 0xffffffff
> -> #0 ((cpu_chain).rwsem){----}:
>       [<c013a280>] print_circular_bug_tail+0x2e/0x62
>       [<c013abd7>] __lock_acquire+0x923/0xae8
>       [<c013b0fc>] lock_acquire+0x6b/0x88
>       [<c0136e60>] down_read+0x28/0x3b
>       [<c012e289>] blocking_notifier_call_chain+0x11/0x2d
>       [<c013f98e>] _cpu_down+0x16f/0x207
>       [<c013fbf8>] disable_nonboot_cpus+0x98/0x12c
>       [<c01451d6>] prepare_processes+0xe/0x41
>       [<c014539e>] pm_suspend_disk+0x9/0xe2
>       [<c0144635>] enter_state+0x53/0x177
>       [<c01447df>] state_store+0x86/0x9c
>       [<c01abde4>] subsys_attr_store+0x20/0x25
>       [<c01abee3>] sysfs_write_file+0xa6/0xcc
>       [<c0174d60>] vfs_write+0xcd/0x174
>       [<c01753fa>] sys_write+0x3b/0x71
>       [<c0103156>] sysenter_past_esp+0x5f/0x99
>       [<ffffffff>] 0xffffffff
> 
> other info that might help us debug this:
> 
> 2 locks held by bash/1961:
> #0:  (cpu_add_remove_lock){--..}, at: [<c02f8156>] mutex_lock+0x1c/0x1f
> #1:  (workqueue_mutex){--..}, at: [<c02f8156>] mutex_lock+0x1c/0x1f
> 
> stack backtrace:
> [<c01041ba>] dump_trace+0x63/0x1ca
> [<c0104333>] show_trace_log_lvl+0x12/0x25
> [<c0104993>] show_trace+0xd/0x10
> [<c0104a58>] dump_stack+0x16/0x18
> [<c013a2a9>] print_circular_bug_tail+0x57/0x62
> [<c013abd7>] __lock_acquire+0x923/0xae8
> [<c013b0fc>] lock_acquire+0x6b/0x88
> [<c0136e60>] down_read+0x28/0x3b
> [<c012e289>] blocking_notifier_call_chain+0x11/0x2d
> [<c013f98e>] _cpu_down+0x16f/0x207
> [<c013fbf8>] disable_nonboot_cpus+0x98/0x12c
> [<c01451d6>] prepare_processes+0xe/0x41
> [<c014539e>] pm_suspend_disk+0x9/0xe2
> [<c0144635>] enter_state+0x53/0x177
> [<c01447df>] state_store+0x86/0x9c
> [<c01abde4>] subsys_attr_store+0x20/0x25
> [<c01abee3>] sysfs_write_file+0xa6/0xcc
> [<c0174d60>] vfs_write+0xcd/0x174
> [<c01753fa>] sys_write+0x3b/0x71
> [<c0103156>] sysenter_past_esp+0x5f/0x99
> DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x99
> 
> Leftover inexact backtrace:
> 
> l *blocking_notifier_call_chain+0x11/0x2d
> 0xc012e278 is in blocking_notifier_call_chain
> (/usr/src/linux-mm/kernel/sys.c:324).
> 319      *      of the last notifier function called.
> 320      */
> 321
> 322     int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
> 323                     unsigned long val, void *v)
> 324     {
> 325             int ret;
> 326
> 327             down_read(&nh->rwsem);
> 328             ret = notifier_call_chain(&nh->head, val, v);
> 
> l *mutex_lock+0x1c/0x1f
> 0xc02f813a is in mutex_lock (/usr/src/linux-mm/kernel/mutex.c:85).
> 80       *   deadlock debugging. )
> 81       *
> 82       * This function is similar to (but not equivalent to) down().
> 83       */
> 84      void inline fastcall __sched mutex_lock(struct mutex *lock)
> 85      {
> 86              might_sleep();
> 87              /*
> 88               * The locking fastpath is the 1->0 transition from
> 89               * 'unlocked' into 'locked' state.
> 
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg2
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-config1

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
