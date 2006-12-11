Return-Path: <linux-kernel-owner+w=401wt.eu-S1763017AbWLKSq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763017AbWLKSq1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763018AbWLKSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:46:27 -0500
Received: from www.nabble.com ([72.21.53.35]:53411 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763017AbWLKSq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:46:26 -0500
Message-ID: <7800583.post@talk.nabble.com>
Date: Mon, 11 Dec 2006 10:46:25 -0800 (PST)
From: seven <horia.muntean@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Temporary random kernel hang
In-Reply-To: <20061209230746.7e33b40f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: horia.muntean@gmail.com
References: <7755634.post@talk.nabble.com> <20061209230746.7e33b40f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> A kernel profile will tell us were the kernel is burning CPU.  Something
> like this (run as root):
> 
> #!/bin/sh
> while true
> do
> 	opcontrol --stop
> 	opcontrol --shutdown
> 	rm -rf /var/lib/oprofile
> 	opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> 	opcontrol --start-daemon
> 	opcontrol --start
> 	date
> 	sleep 5
> 	opcontrol --stop
> 	opcontrol --shutdown
> 	opreport -l /boot/vmlinux-$(uname -r) | head -50
> done | tee /tmp/oprofile-output
> 
> Then locate the output record which correlates with one of these episodes.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


Hello Andrew,

First, thank you for the pointers. I did what you suggested ( installed
oprofile and run the script ). In the same time, I added a timestamp column
to vmstat recording.

I can see dramatic changes in the output of opreport during the freeze
period, but I do not know what it means. 

Here are my recordings:

vmstat -a 3 | awk {print $0"-"system("date")} > vmstat.txt &

 0  0      0 211888 980736 755460    0    0     0   600 1599 2679 30  8 62 
0  0 Mon Dec 11 18:30:07 GMT 2006
 4  0      0 209356 982216 756600    0    0     0   604 2201 6401 44  8 48 
0  0 Mon Dec 11 18:30:10 GMT 2006
88  0      0 208616 982648 756912    0    0     0     0 2340 3690 45 10 44 
0  0 Mon Dec 11 18:30:13 GMT 2006
 5  0      0 206892 984024 757228    0    0     0   752 2780 5246 53  9 38 
0  0 Mon Dec 11 18:31:00 GMT 2006
179  0      0 206428 984244 758152    0    0     0   287  834  787 17 81  2 
0  0 Mon Dec 11 18:31:00 GMT 2006
245  0      0 206344 984244 758256    0    0     0     0  527  244 14 86  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
297  0      0 206476 984248 758048    0    0     0    32  535  238 15 85  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
procs -----------memory---------- ---swap-- -----io---- -system--
-----cpu------ Mon Dec 11 18:31:00 GMT 2006
 r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy id
wa st Mon Dec 11 18:31:00 GMT 2006
303  0      0 206476 984256 758060    0    0     0   161  375  210 15 85  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
309  0      0 206468 984260 758064    0    0     0     0  352  209 15 85  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
316  0      0 206468 984264 758068    0    0     0    21  345  220 14 86  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
315  0      0 206592 984268 758072    0    0     0    15  315  229 15 85  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
323  0      0 206592 984272 758072    0    0     0    21  330  230 14 86  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
332  0      0 206608 984272 758072    0    0     0     0  439  235 13 87  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
333  0      0 206608 984272 758072    0    0     0    12  374  199 14 86  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
337  0      0 206608 984292 758096    0    0     0    28  333  233 15 85  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
341  0      0 206484 984292 758096    0    0     0     0  328  201 14 86  0 
0  0 Mon Dec 11 18:31:00 GMT 2006
 6  0      0 205344 984368 758164    0    0     0    21  597  887 21 78  1 
0  0 Mon Dec 11 18:31:03 GMT 2006
 0  0      0 204420 984768 757704    0    0     0     0 3911 4646 76 14 10 
0  0 Mon Dec 11 18:31:06 GMT 2006
 5  0      0 293960 917620 736532    0    0     0   707 3191 5204 62  9 28 
0  0 Mon Dec 11 18:31:09 GMT 2006
28  0      0 294556 917764 735684    0    0     0   831 3128 5132 62 14 23 
0  0 Mon Dec 11 18:31:12 GMT 2006
 9  0      0 291836 919304 736960    0    0     0     0 2935 5228 57  9 34 
0  0 Mon Dec 11 18:31:15 GMT 2006

-------------------------------------------------------------------------------------
The script output corresponding to the freeze period is below. Notice that
the third sample has completely different look compared to sample 1, 2, 4, 5
witch correspond to normal operation situation.


Mon Dec 11 18:29:56 GMT 2006
Stopping profiling.
Stopping profiling.
Killing daemon.
CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
700       3.9093  ia32_sysenter_target
608       3.3955  find_vma
603       3.3676  copy_user_generic
570       3.1833  sysenter_do_call
486       2.7142  schedule
485       2.7086  tcp_sendmsg
445       2.4852  __find_get_block
429       2.3958  do_futex
365       2.0384  page_fault
355       1.9826  main_timer_handler
293       1.6363  do_gettimeofday
284       1.5861  try_to_wake_up
277       1.5470  __switch_to
258       1.4409  fget
255       1.4241  clear_page
220       1.2286  ia32_syscall
213       1.1895  ll_rw_block
197       1.1002  find_lock_page
194       1.0834  gs_change
187       1.0443  __up_read
177       0.9885  lock_sock
177       0.9885  tcp_ack
171       0.9550  __down_read
164       0.9159  IRQ0xa9_interrupt
156       0.8712  fget_light
152       0.8489  fput
146       0.8154  kfree
144       0.8042  math_state_restore
144       0.8042  tcp_v4_rcv
128       0.7148  __brelse
128       0.7148  recalc_task_prio
123       0.6869  __handle_mm_fault
123       0.6869  __kmalloc
122       0.6813  copy_page
122       0.6813  kmem_cache_alloc
120       0.6702  __tcp_push_pending_frames
117       0.6534  unlock_buffer
116       0.6478  rw_verify_area
115       0.6422  thread_return
114       0.6367  unmap_vmas
112       0.6255  kmem_cache_free
112       0.6255  radix_tree_lookup
110       0.6143  device_not_available
105       0.5864  ip_output
104       0.5808  pfn_to_page
104       0.5808  release_sock
90        0.5026  release_pages
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
Mon Dec 11 18:30:02 GMT 2006
Stopping profiling.
Stopping profiling.
Killing daemon.
CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
741       4.3771  ia32_sysenter_target
682       4.0286  sysenter_do_call
622       3.6742  find_vma
523       3.0894  copy_user_generic
515       3.0421  schedule
495       2.9240  do_futex
419       2.4750  __find_get_block
373       2.2033  do_gettimeofday
372       2.1974  tcp_sendmsg
325       1.9198  main_timer_handler
312       1.8430  try_to_wake_up
298       1.7603  __switch_to
260       1.5358  fget
239       1.4118  gs_change
227       1.3409  ia32_syscall
222       1.3114  __down_read
219       1.2936  page_fault
193       1.1401  find_lock_page
189       1.1164  __up_read
180       1.0633  fget_light
178       1.0515  clear_page
178       1.0515  tcp_ack
175       1.0337  ll_rw_block
167       0.9865  math_state_restore
156       0.9215  thread_return
154       0.9097  lock_sock
151       0.8920  fput
138       0.8152  recalc_task_prio
135       0.7974  tcp_v4_rcv
129       0.7620  kfree
128       0.7561  IRQ0xa9_interrupt
124       0.7325  release_sock
123       0.7266  device_not_available
120       0.7088  __tcp_push_pending_frames
114       0.6734  __kmalloc
111       0.6557  unlock_buffer
110       0.6498  inet_sendmsg
108       0.6380  __brelse
105       0.6202  do_gettimeoffset_tsc
100       0.5907  rw_verify_area
95        0.5612  tcp_init_tso_segs
94        0.5553  kmem_cache_free
94        0.5553  radix_tree_lookup
92        0.5434  ip_output
89        0.5257  file_update_time
86        0.5080  dnotify_parent
86        0.5080  kmem_cache_alloc
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
Mon Dec 11 18:30:09 GMT 2006
Stopping profiling.
Stopping profiling.
Killing daemon.
CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
196048    9.3307  page_fault
184945    8.8023  force_sig_info
153475    7.3045  do_signal
120071    5.7146  get_signal_to_deliver
116196    5.5302  ia32_setup_sigcontext
89368     4.2534  ia32_syscall
82987     3.9497  __down_read_trylock
82396     3.9215  save_i387_ia32
79436     3.7807  copy_user_generic
77587     3.6927  __sigqueue_alloc
74439     3.5428  sys32_rt_sigreturn
69484     3.3070  recalc_sigpending_tsk
65733     3.1285  do_page_fault
49694     2.3651  retint_restore_args
45756     2.1777  ia32_setup_rt_frame
45717     2.1759  try_to_wake_up
45658     2.1730  restore_i387_ia32
31626     1.5052  __up_read
30286     1.4414  __dequeue_signal
29849     1.4206  memcpy
27139     1.2917  sys32_sigaltstack
25838     1.2297  ia32_restore_sigcontext
25126     1.1958  kmem_cache_free
24757     1.1783  do_sigaltstack
22884     1.0891  __sigqueue_free
22818     1.0860  error_sti
22007     1.0474  signal_wake_up
19816     0.9431  kmem_cache_alloc
17810     0.8476  retint_signal
17208     0.8190  is_prefetch
16315     0.7765  _atomic_dec_and_lock
14320     0.6815  specific_send_sig_info
13881     0.6607  send_signal
13704     0.6522  find_vma
12392     0.5898  free_uid
9283      0.4418  get_sigframe
9184      0.4371  copy_siginfo_to_user32
8525      0.4057  pfn_to_page
7980      0.3798  unhandled_signal
7465      0.3553  error_entry
7309      0.3479  convert_rip_to_linear
6926      0.3296  notifier_call_chain
6367      0.3030  kprobe_exceptions_notify
5948      0.2831  copy_to_user
5408      0.2574  error_exit
4407      0.2097  int_ret_from_sys_call
4128      0.1965  dequeue_signal
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
Mon Dec 11 18:31:02 GMT 2006
Stopping profiling.
Stopping profiling.
Killing daemon.
CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
1113      4.4269  ia32_sysenter_target
911       3.6234  find_vma
887       3.5280  copy_user_generic
850       3.3808  sysenter_do_call
715       2.8438  do_futex
712       2.8319  tcp_sendmsg
679       2.7007  __find_get_block
657       2.6132  schedule
508       2.0205  do_gettimeofday
399       1.5870  try_to_wake_up
375       1.4915  fget
366       1.4557  main_timer_handler
341       1.3563  __switch_to
314       1.2489  IRQ0xa9_interrupt
307       1.2211  ia32_syscall
297       1.1813  clear_page
292       1.1614  ll_rw_block
285       1.1336  unlock_buffer
278       1.1057  gs_change
277       1.1017  fget_light
276       1.0978  find_lock_page
274       1.0898  page_fault
268       1.0659  tcp_ack
247       0.9824  lock_sock
242       0.9625  __down_read
233       0.9267  kfree
223       0.8870  __tcp_push_pending_frames
213       0.8472  tcp_v4_rcv
210       0.8353  math_state_restore
203       0.8074  __up_read
202       0.8034  fput
196       0.7796  recalc_task_prio
194       0.7716  release_sock
187       0.7438  kmem_cache_free
182       0.7239  __brelse
180       0.7159  thread_return
173       0.6881  test_clear_page_dirty
170       0.6762  inet_sendmsg
161       0.6404  ip_output
159       0.6324  device_not_available
156       0.6205  pfn_to_page
151       0.6006  __kmalloc
149       0.5926  tcp_transmit_skb
145       0.5767  file_update_time
143       0.5688  dnotify_parent
142       0.5648  kmem_cache_alloc
141       0.5608  do_gettimeoffset_tsc
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
Mon Dec 11 18:31:08 GMT 2006
Stopping profiling.
Stopping profiling.
Killing daemon.
CPU: P4 / Xeon, speed 3000.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
1054      4.3503  ia32_sysenter_target
880       3.6322  copy_user_generic
859       3.5455  sysenter_do_call
842       3.4753  find_vma
694       2.8645  tcp_sendmsg
675       2.7860  __find_get_block
656       2.7076  do_futex
645       2.6622  schedule
487       2.0101  do_gettimeofday
409       1.6881  try_to_wake_up
384       1.5849  fget
382       1.5767  main_timer_handler
360       1.4859  __switch_to
323       1.3332  tcp_ack
304       1.2547  clear_page
304       1.2547  ll_rw_block
302       1.2465  IRQ0xa9_interrupt
293       1.2093  fget_light
289       1.1928  page_fault
279       1.1516  find_lock_page
273       1.1268  ia32_syscall
271       1.1185  gs_change
256       1.0566  lock_sock
233       0.9617  kfree
229       0.9452  __up_read
227       0.9369  __down_read
223       0.9204  tcp_v4_rcv
207       0.8544  fput
194       0.8007  unlock_buffer
190       0.7842  thread_return
189       0.7801  math_state_restore
186       0.7677  release_sock
178       0.7347  __tcp_push_pending_frames
175       0.7223  __kmalloc
168       0.6934  inet_sendmsg
164       0.6769  dnotify_parent
164       0.6769  recalc_task_prio
158       0.6521  kmem_cache_free
154       0.6356  tcp_transmit_skb
153       0.6315  device_not_available
144       0.5944  tcp_init_tso_segs
140       0.5778  __brelse
139       0.5737  pfn_to_page
132       0.5448  kmem_cache_alloc
131       0.5407  file_update_time
131       0.5407  ip_output
128       0.5283  tcp_current_mss

---------------------------------------------------------------------------------------------------

I did notice something that can be related to those freeze periods: I
started to monitor the temperatures of the CPUs and noticed that the freeze
(I could reproduce only one freeze today) happened in the same interval as a
temperature spike ( around 50 degrees C ). My system is a 1U, 2-way Intel
Xeon 3.0 GHz blade ( IBM x336 ) and I think it has some kind of temperature
control that kicks in when the CPU temp reaches certain levels. AFAIK the
temperature control system will change the CPU speed in order to cool it
down.

Anyway, I will try to heat up the other system tomorrow (the stable one) to
see if I can bring it to the same temp. level and see how it responds. 

In the same time I will try to heat up again the unstable system to see if
there is really relation between the CPU temp. and system freezes (only one
match could be just a coincidence).

Is is possible that this kernel behavior could be related to temp. control
events?

Regards and thank you again,
Horia

-- 
View this message in context: http://www.nabble.com/Temporary-random-kernel-hang-tf2779860.html#a7800583
Sent from the linux-kernel mailing list archive at Nabble.com.

