Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293068AbSBWBic>; Fri, 22 Feb 2002 20:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293067AbSBWBi3>; Fri, 22 Feb 2002 20:38:29 -0500
Received: from jalon.able.es ([212.97.163.2]:4515 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293068AbSBWBiQ>;
	Fri, 22 Feb 2002 20:38:16 -0500
Date: Sat, 23 Feb 2002 02:38:08 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Hang on floppy access, patched 2.4.18-rc[34]
Message-ID: <20020223023808.C1689@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My system is locking up when trying to access the floppy drive.
The mount or mkfs command just get stuck, no response to ctrl-c.
Kernel is 2.4.18-rc3 with vm-25, sched-O1, read-latency, mini-lowlat,
irqrate-A1. But is also hangs on rc4 without irqrate-A1.
Decoded output from SysRQ-P follows:

ksymoops 2.4.3 on i686 2.4.18-rc3-jam1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-rc3-jam1/ (default)
     -m /boot/System.map-2.4.18-rc3-jam1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Pid: 0, comm:              swapper
EIP: 0010:[schedule+129/928] CPU: 0 EFLAGS: 00000286    Tainted: P 
EIP: 0010:[<c0117651>] CPU: 0 EFLAGS: 00000286    Tainted: P 
lf32-i386 -a i386
EAX: 000000ff EBX: c02bac80 ECX: 00000000 EDX: c027c000
ESI: 00000000 EDI: c027c000 EBP: c027dfc0 DS: 0018 ES: 0018
CR0: 8005003b CR2: 4004f6b0 CR3: 1d9fc000 CR4: 000002d0
Call Trace: [rest_init+0/64] [default_idle+0/64] [default_idle+0/64] [rest_init+0/64] [cpu_idle+41/48] 
Call Trace: [<c0105000>] [<c0105200>] [<c0105200>] [<c0105000>] [<c0105289>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0117650 <schedule+80/3a0>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c0105200 <default_idle+0/40>
Trace; c0105200 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105288 <cpu_idle+28/30>

Proc;  init
>>EIP; c1837f54 <_end+14f7360/204ed40c>   <=====
Trace; c0123194 <schedule_timeout+84/b0>
Trace; c0123100 <process_timeout+0/10>
Trace; c014973e <do_select+1fe/240>
Trace; c0149ae8 <sys_select+338/490>
Trace; c01070ba <system_call+32/38>
Proc;  keventd
>>EIP; c1829f74 <_end+14e9380/204ed40c>   <=====
Trace; c0127cd0 <context_thread+130/240>
Trace; c0127ba0 <context_thread+0/240>
Trace; c0105000 <_stext+0/0>
Trace; c010561a <kernel_thread+4a/60>
Proc;  kswapd
>>EIP; c011d834 <exit_files+34/40>   <=====
Trace; c011d834 <exit_files+34/40>
Trace; c0133d28 <kswapd+88/ba>
Trace; c0133ca0 <kswapd+0/ba>
Trace; c0105000 <_stext+0/0>
Trace; c010561a <kernel_thread+4a/60>
Proc;  bdflush
>>EIP; 0000377a Before first symbol   <=====
Trace; c0117bca <interruptible_sleep_on+4a/70>
Trace; c013f0d6 <bdflush+d6/e0>
Trace; c0105000 <_stext+0/0>
Trace; c010561a <kernel_thread+4a/60>
Proc;  kupdated
>>EIP; 00000002 Before first symbol   <=====
Trace; c0123194 <schedule_timeout+84/b0>
Trace; c0123100 <process_timeout+0/10>
Trace; c013eebc <sync_old_buffers+2c/90>
Trace; c013f184 <kupdate+a4/140>
Trace; c013f0e0 <kupdate+0/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c010561a <kernel_thread+4a/60>
Proc;  scsi_eh_0
>>EIP; 00000056 Before first symbol   <=====
Trace; c0105cf4 <__down_interruptible+74/f0>
Trace; c0105dd2 <__down_failed_interruptible+6/c>
Trace; c01bf3cc <_text_lock_scsi_error+e6/10a>
Trace; c010706e <ret_from_fork+6/20>
Trace; c010561a <kernel_thread+4a/60>
Proc;  syslogd
>>EIP; 00000246 Before first symbol   <=====
Trace; c0123124 <schedule_timeout+14/b0>
Trace; c01ec3be <sock_poll+1e/30>
Trace; c014973e <do_select+1fe/240>
Trace; c0149ae8 <sys_select+338/490>
Trace; c01070ba <system_call+32/38>
Proc;  klogd
>>EIP; df9798e0 <_end+1f638cec/204ed40c>   <=====
Trace; c011a85c <do_syslog+dc/3f0>
Trace; c013a8f6 <sys_read+96/110>
Trace; c011ebf2 <sys_time+12/60>
Trace; c01070ba <system_call+32/38>
Proc;  mount
>>EIP; 00000282 Before first symbol   <=====
Trace; c013bb16 <__wait_on_buffer+76/a0>
Trace; c011f41a <do_softirq+5a/90>
Trace; c01a696a <floppy_revalidate+1ba/1f0>
Trace; c014141a <check_disk_change+6a/80>
Trace; c01a6640 <floppy_open+350/3c0>
Trace; c0141506 <do_open+86/150>
Trace; c0141630 <blkdev_get+60/70>
Trace; c01400d6 <get_sb_bdev+c6/2a0>
Trace; e098d2c0 <[msdos]msdos_fs_type+0/1a>
Trace; c01406d8 <do_kern_mount+b8/150>
Trace; e098d2c0 <[msdos]msdos_fs_type+0/1a>
Trace; c0151b92 <do_add_mount+22/e0>
Trace; c0151e4a <do_mount+15a/180>
Trace; c0151c9c <copy_mount_options+4c/a0>
Trace; c0151f14 <sys_mount+a4/100>
Trace; c01070ba <system_call+32/38>
Proc;  flush
>>EIP; c01348e0 <__get_free_pages+10/20>   <=====
Trace; c01348e0 <__get_free_pages+10/20>
Trace; c0149402 <__pollwait+32/90>
Trace; c0123194 <schedule_timeout+84/b0>
Trace; c0123100 <process_timeout+0/10>
Trace; c014973e <do_select+1fe/240>
Trace; c0149ae8 <sys_select+338/490>
Trace; c01070ba <system_call+32/38>


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam1 #1 SMP Sat Feb 23 01:39:06 CET 2002 i686
