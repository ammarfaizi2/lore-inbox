Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUHaV4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUHaV4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUHaVx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:53:26 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:60569 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S268013AbUHaVwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:52:05 -0400
Date: Tue, 31 Aug 2004 23:51:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] fix f_version optimization for get_tgid_list
Message-ID: <20040831215130.GA20844@k3.hellgate.ch>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
References: <4134DEFB.2070607@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4134DEFB.2070607@colorfullife.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test: top -d 0 -b -n 10 > /dev/null

==> 2.6.8 <==
real    0m19.092s
user    0m5.013s
sys     0m12.622s

CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
6338     35.9379  vmlinux                  get_tgid_list
1742      9.8775  vmlinux                  pid_alive
1264      7.1672  libc-2.3.3.so            _IO_vfscanf_internal
940       5.3300  vmlinux                  number
625       3.5439  vmlinux                  proc_pid_stat
532       3.0166  libc-2.3.3.so            _IO_vfprintf_internal
398       2.2567  vmlinux                  __d_lookup
297       1.6841  vmlinux                  vsnprintf
268       1.5196  vmlinux                  link_path_walk
266       1.5083  libc-2.3.3.so            __i686.get_pc_thunk.bx
214       1.2134  libc-2.3.3.so            ____strtoul_l_internal
210       1.1907  vmlinux                  task_statm
209       1.1851  libc-2.3.3.so            _IO_default_xsputn_internal
199       1.1284  libc-2.3.3.so            _IO_putc_internal
172       0.9753  libc-2.3.3.so            ____strtol_l_internal
135       0.7655  libc-2.3.3.so            _IO_sputbackc_internal
130       0.7371  libncurses.so.5.4        _nc_outch
124       0.7031  vmlinux                  pid_revalidate
115       0.6521  top                      task_show
112       0.6351  libc-2.3.3.so            __find_specmb
103       0.5840  vmlinux                  atomic_dec_and_lock
98        0.5557  libc-2.3.3.so            __funlockfile
76        0.4309  libncurses.so.5.4        tputs
73        0.4139  vmlinux                  system_call
72        0.4083  libc-2.3.3.so            _IO_str_overflow_internal
72        0.4083  libc-2.3.3.so            __GI___printf_fp
66        0.3742  vmlinux                  may_open
65        0.3686  libc-2.3.3.so            __GI_strrchr
61        0.3459  vmlinux                  path_lookup
60        0.3402  libc-2.3.3.so            __GI___errno_location
58        0.3289  libc-2.3.3.so            __flockfile
55        0.3119  vmlinux                  __might_sleep

==> 2.6.8 + patch-tgid-bugfixes <==
real    0m10.062s
user    0m5.042s
sys     0m4.111s

CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
1330     14.5292  libc-2.3.3.so            _IO_vfscanf_internal
931      10.1704  vmlinux                  number
618       6.7511  vmlinux                  proc_pid_stat
494       5.3965  libc-2.3.3.so            _IO_vfprintf_internal
307       3.3537  vmlinux                  __d_lookup
296       3.2336  vmlinux                  vsnprintf
233       2.5453  libc-2.3.3.so            _IO_putc_internal
216       2.3596  libc-2.3.3.so            _IO_default_xsputn_internal
212       2.3159  libc-2.3.3.so            ____strtoul_l_internal
208       2.2722  libc-2.3.3.so            __i686.get_pc_thunk.bx
200       2.1848  libc-2.3.3.so            ____strtol_l_internal
199       2.1739  vmlinux                  link_path_walk
198       2.1630  vmlinux                  task_statm
156       1.7042  libc-2.3.3.so            _IO_sputbackc_internal
128       1.3983  libncurses.so.5.4        _nc_outch
122       1.3328  top                      task_show
110       1.2017  vmlinux                  pid_revalidate
84        0.9176  libc-2.3.3.so            __funlockfile
81        0.8849  libc-2.3.3.so            __find_specmb
72        0.7865  libncurses.so.5.4        tputs
68        0.7428  vmlinux                  system_call
65        0.7101  libc-2.3.3.so            __GI___errno_location
64        0.6991  libc-2.3.3.so            _IO_str_overflow_internal
63        0.6882  libc-2.3.3.so            __flockfile
63        0.6882  vmlinux                  get_tgid_list
61        0.6664  libc-2.3.3.so            __strnlen
59        0.6445  libc-2.3.3.so            __GI___printf_fp
57        0.6227  vmlinux                  atomic_dec_and_lock
55        0.6008  libc-2.3.3.so            __GI_strrchr
54        0.5899  vmlinux                  may_open
52        0.5681  libproc-3.2.3.so         escape_str
51        0.5571  libc-2.3.3.so            _IO_str_init_static_internal
51        0.5571  libc-2.3.3.so            __GI___strtoul_internal

