Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWHEL0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHEL0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWHEL0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:26:50 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15443 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932359AbWHEL0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:26:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QfeiDAtf7/Pt/oYRtMuRMP4BuyQUHrw4NIhcUlwQ18uwcGcNRAv9+SjCp7ZfcBG/9IXxcduhAddOspcYV0RdXp5yyftrQa23CQxUJHwrGTYbXkMWk0bfd2QtyV4TmmTxeFVQNx9VOyDlPPdaRA2pqjD9ov1NCGjBOT36UzCfu7s=
Message-ID: <6bffcb0e0608050426s6c39e4f0o57f9093b03c3b27b@mail.gmail.com>
Date: Sat, 5 Aug 2006 13:26:49 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
In-Reply-To: <6bffcb0e0608050411q22112b71wced519a6491c6abe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	 <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	 <20060804222400.GC18792@redhat.com>
	 <20060805003142.GH18792@redhat.com>
	 <20060805021051.GA13393@redhat.com>
	 <20060805022356.GC13393@redhat.com>
	 <20060805024947.GE13393@redhat.com>
	 <20060805064727.GF13393@redhat.com>
	 <6bffcb0e0608050354k4dd0bb0ep337216e984ce41d7@mail.gmail.com>
	 <6bffcb0e0608050411q22112b71wced519a6491c6abe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> audit(1154775731.471:6): avc:  denied  { write } for  pid=1361
> comm="cpuspeed" name="cpufreq" dev=sysfs ino=4863
> scontext=system_u:system_r:cpuspeed_t:s0
> tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> CPU0 called lock_cpu_hotplug() for app konsole. recursive_depth=0
>  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
>  [<c012aadf>] flush_workqueue+0x25/0x57
>  [<c020e1b7>] release_dev+0x485/0x5f2
>  [<c016f7f8>] d_lookup+0x1b/0x3b
>  [<c012d8d6>] remove_wait_queue+0xc/0x34
>  [<c020e333>] tty_release+0xf/0x18
>  [<c015c943>] __fput+0x90/0x15e
>  [<c015a361>] filp_close+0x4e/0x54
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> konsole acquired cpu_bitmask_lock
> CPU0 called unlock_cpu_hotplug() for app konsole. recursive_depth=0
>  [<c0132a62>] unlock_cpu_hotplug+0x34/0xb2
>  [<c020e1b7>] release_dev+0x485/0x5f2
>  [<c016f7f8>] d_lookup+0x1b/0x3b
>  [<c012d8d6>] remove_wait_queue+0xc/0x34
>  [<c020e333>] tty_release+0xf/0x18
>  [<c015c943>] __fput+0x90/0x15e
>  [<c015a361>] filp_close+0x4e/0x54
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> konsole released cpu_bitmask_lock

Aug  5 13:18:00 ltg01-fedora kernel: CPU0 called lock_cpu_hotplug()
for app kded. recursive_depth=0
Aug  5 13:18:00 ltg01-fedora kernel:  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
Aug  5 13:18:00 ltg01-fedora kernel:  [<c012aadf>] flush_workqueue+0x25/0x57
Aug  5 13:18:00 ltg01-fedora kernel:  [<c020e1b7>] release_dev+0x485/0x5f2
Aug  5 13:18:00 ltg01-fedora kernel:  [<c014c28f>] do_wp_page+0x318/0x348
Aug  5 13:18:00 ltg01-fedora kernel:  [<c01425d4>] find_get_page+0x36/0x3b
Aug  5 13:18:00 ltg01-fedora kernel:  [<c014d46b>] __handle_mm_fault+0x6bf/0x727
Aug  5 13:18:00 ltg01-fedora kernel:  [<c020e333>] tty_release+0xf/0x18
Aug  5 13:18:00 ltg01-fedora kernel:  [<c015c943>] __fput+0x90/0x15e
Aug  5 13:18:00 ltg01-fedora kernel:  [<c015a361>] filp_close+0x4e/0x54
Aug  5 13:18:00 ltg01-fedora kernel:  [<c0102d51>] sysenter_past_esp+0x56/0x79
Aug  5 13:18:00 ltg01-fedora kernel: kded acquired cpu_bitmask_lock
[..]
Aug  5 13:18:03 ltg01-fedora kernel: CPU1 called lock_cpu_hotplug()
for app mingetty. recursive_depth=0
Aug  5 13:18:03 ltg01-fedora kernel:  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012aadf>] flush_workqueue+0x25/0x57
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020e1b7>] release_dev+0x485/0x5f2
Aug  5 13:18:03 ltg01-fedora kernel:  [<c01463a2>] __pagevec_free+0x18/0x22
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0148251>] release_pages+0x13b/0x143
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020e333>] tty_release+0xf/0x18
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c943>] __fput+0x90/0x15e
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015a361>] filp_close+0x4e/0x54
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011e477>] put_files_struct+0x65/0xa7
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011f44f>] do_exit+0x1dd/0x771
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011fa59>] sys_exit_group+0x0/0xd
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012766a>]
get_signal_to_deliver+0x387/0x3cc
Aug  5 13:18:03 ltg01-fedora kernel:  [<c01024ba>] do_notify_resume+0x71/0x5df
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012d8d6>] remove_wait_queue+0xc/0x34
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0211a89>] read_chan+0x0/0x567
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020cc00>] tty_ldisc_deref+0x50/0x5f
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020ede8>] tty_read+0x6d/0xb4
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020ed7b>] tty_read+0x0/0xb4
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c174>] vfs_read+0x9f/0x141
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c5c0>] sys_read+0x3c/0x63
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0102e4a>] work_notifysig+0x13/0x19
Aug  5 13:18:03 ltg01-fedora kernel: mingetty acquired cpu_bitmask_lock
[..]
Aug  5 13:18:03 ltg01-fedora kernel: CPU1 called lock_cpu_hotplug()
for app mingetty. recursive_depth=0
Aug  5 13:18:03 ltg01-fedora kernel:  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012aadf>] flush_workqueue+0x25/0x57
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020e1b7>] release_dev+0x485/0x5f2
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0115c9e>] __wake_up_common+0x2f/0x53
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0115cd3>] __wake_up_locked+0x11/0x15
Aug  5 13:18:03 ltg01-fedora kernel:  [<c02b5ef5>] __down+0xa1/0xd7
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0117186>] default_wake_function+0x0/0xc
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020e333>] tty_release+0xf/0x18
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c943>] __fput+0x90/0x15e
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015a361>] filp_close+0x4e/0x54
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011e477>] put_files_struct+0x65/0xa7
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011f44f>] do_exit+0x1dd/0x771
Aug  5 13:18:03 ltg01-fedora kernel:  [<c011fa59>] sys_exit_group+0x0/0xd
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012766a>]
get_signal_to_deliver+0x387/0x3cc
Aug  5 13:18:03 ltg01-fedora kernel:  [<c01024ba>] do_notify_resume+0x71/0x5df
Aug  5 13:18:03 ltg01-fedora kernel:  [<c012d8d6>] remove_wait_queue+0xc/0x34
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0211a89>] read_chan+0x0/0x567
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020cc00>] tty_ldisc_deref+0x50/0x5f
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020ede8>] tty_read+0x6d/0xb4
Aug  5 13:18:03 ltg01-fedora kernel:  [<c020ed7b>] tty_read+0x0/0xb4
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c174>] vfs_read+0x9f/0x141
Aug  5 13:18:03 ltg01-fedora kernel:  [<c015c5c0>] sys_read+0x3c/0x63
Aug  5 13:18:03 ltg01-fedora kernel:  [<c0102e4a>] work_notifysig+0x13/0x19
