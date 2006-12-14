Return-Path: <linux-kernel-owner+w=401wt.eu-S1751834AbWLNWKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWLNWKi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWLNWKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:10:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34589 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbWLNWKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:10:37 -0500
Date: Thu, 14 Dec 2006 14:10:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: seven <horia.muntean@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temporary random kernel hang
Message-Id: <20061214141034.790b2a8c.akpm@osdl.org>
In-Reply-To: <7800583.post@talk.nabble.com>
References: <7755634.post@talk.nabble.com>
	<20061209230746.7e33b40f.akpm@osdl.org>
	<7800583.post@talk.nabble.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 10:46:25 -0800 (PST)
seven <horia.muntean@gmail.com> wrote:

> 
> 
> 
> > A kernel profile will tell us were the kernel is burning CPU.  Something
> > like this (run as root):
> > 
> > #!/bin/sh
> > while true
> > do
> > 	opcontrol --stop
> > 	opcontrol --shutdown
> > 	rm -rf /var/lib/oprofile
> > 	opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> > 	opcontrol --start-daemon
> > 	opcontrol --start
> > 	date
> > 	sleep 5
> > 	opcontrol --stop
> > 	opcontrol --shutdown
> > 	opreport -l /boot/vmlinux-$(uname -r) | head -50
> > done | tee /tmp/oprofile-output
> > 
> > Then locate the output record which correlates with one of these episodes.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 
> Hello Andrew,

No, I wasn't ignoring you for four days.  Please, always do reply-to-all.

> First, thank you for the pointers. I did what you suggested ( installed
> oprofile and run the script ). In the same time, I added a timestamp column
> to vmstat recording.
> 
> I can see dramatic changes in the output of opreport during the freeze
> period, but I do not know what it means. 
> 
> ..
>
> CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not
> stopped) with a unit mask of 0x01 (mandatory) count 100000
> samples  %        symbol name
> 741       4.3771  ia32_sysenter_target
> 682       4.0286  sysenter_do_call
> 622       3.6742  find_vma
> 523       3.0894  copy_user_generic
> 515       3.0421  schedule
> 495       2.9240  do_futex
> 419       2.4750  __find_get_block
> 373       2.2033  do_gettimeofday
> 372       2.1974  tcp_sendmsg
> 325       1.9198  main_timer_handler
> 312       1.8430  try_to_wake_up
> 298       1.7603  __switch_to
> 260       1.5358  fget
> 239       1.4118  gs_change
> 227       1.3409  ia32_syscall
> 222       1.3114  __down_read
> 219       1.2936  page_fault
> 193       1.1401  find_lock_page
> 189       1.1164  __up_read
> 180       1.0633  fget_light
> 178       1.0515  clear_page
> 178       1.0515  tcp_ack
> 175       1.0337  ll_rw_block
> 167       0.9865  math_state_restore
> 156       0.9215  thread_return
> 154       0.9097  lock_sock
> 151       0.8920  fput
> 138       0.8152  recalc_task_prio
> 135       0.7974  tcp_v4_rcv
> 129       0.7620  kfree
> 128       0.7561  IRQ0xa9_interrupt
> 124       0.7325  release_sock
> 123       0.7266  device_not_available
> 120       0.7088  __tcp_push_pending_frames
> 114       0.6734  __kmalloc
> 111       0.6557  unlock_buffer
> 110       0.6498  inet_sendmsg
> 108       0.6380  __brelse
> 105       0.6202  do_gettimeoffset_tsc
> 100       0.5907  rw_verify_area
> 95        0.5612  tcp_init_tso_segs
> 94        0.5553  kmem_cache_free
> 94        0.5553  radix_tree_lookup
> 92        0.5434  ip_output
> 89        0.5257  file_update_time
> 86        0.5080  dnotify_parent
> 86        0.5080  kmem_cache_alloc

versus

> Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
> Daemon started.
> Profiler running.
> Mon Dec 11 18:30:09 GMT 2006
> Stopping profiling.
> Stopping profiling.
> Killing daemon.
> CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not
> stopped) with a unit mask of 0x01 (mandatory) count 100000
> samples  %        symbol name
> 196048    9.3307  page_fault
> 184945    8.8023  force_sig_info
> 153475    7.3045  do_signal
> 120071    5.7146  get_signal_to_deliver
> 116196    5.5302  ia32_setup_sigcontext
> 89368     4.2534  ia32_syscall
> 82987     3.9497  __down_read_trylock
> 82396     3.9215  save_i387_ia32
> 79436     3.7807  copy_user_generic
> 77587     3.6927  __sigqueue_alloc
> 74439     3.5428  sys32_rt_sigreturn
> 69484     3.3070  recalc_sigpending_tsk
> 65733     3.1285  do_page_fault
> 49694     2.3651  retint_restore_args
> 45756     2.1777  ia32_setup_rt_frame
> 45717     2.1759  try_to_wake_up
> 45658     2.1730  restore_i387_ia32
> 31626     1.5052  __up_read
> 30286     1.4414  __dequeue_signal
> 29849     1.4206  memcpy
> 27139     1.2917  sys32_sigaltstack
> 25838     1.2297  ia32_restore_sigcontext
> 25126     1.1958  kmem_cache_free
> 24757     1.1783  do_sigaltstack
> 22884     1.0891  __sigqueue_free
> 22818     1.0860  error_sti
> 22007     1.0474  signal_wake_up
> 19816     0.9431  kmem_cache_alloc
> 17810     0.8476  retint_signal
> 17208     0.8190  is_prefetch
> 16315     0.7765  _atomic_dec_and_lock

It's certainly different.  It is hard to work out what might be going
on in there, but there's no obvious sign of misbehaviour.  It could be that
the application has simply gone berzerk and is doing a larger number or
expensive system calls.

The next step would be to try to catch one of these eposides with strace.
