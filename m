Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUHPLud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUHPLud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUHPLud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:50:33 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:4311 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S267555AbUHPLuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:50:17 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <andrea@suse.de>
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
Date: Mon, 16 Aug 2004 13:49:22 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040816101241.6315F2FC2C@illicom.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSBXhRCgfKy+w6USDGgDhs63iBGowCGXQ1gAAOJXgA=
Message-Id: <20040816115014.87D532FC2C@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello,

Unfortunately, the system has just frozen again a few minutes ago.

I had a top console opened I was looking at when it happened. Kswapd began
to go mad, was eating up to 100% of one CPU. The 1 minute load has gone to
17/18. Then the system was completely frozen.

I was able to reset and gather some /proc/profile informations during the
freeze :

12752 total                                      0.0085
  3415 .text.lock.filemap                         4.4993
  2436 shrink_cache                               2.3244
  1864 .text.lock.vmscan                          8.0345
  1709 .text.lock.inode                           2.5584
   959 prune_icache                               1.8163
   619 .text.lock.swap                           10.6724
   431 inode_has_buffers                          8.2885
   406 invalidate_inode_pages                     2.4167
   220 swap_out                                   0.1746
   159 __wake_up                                  0.8112
   157 statm_pgd_range                            0.3043
   103 .text.lock.ioctl                           2.4524
    22 try_to_free_buffers                        0.0671
    19 schedule                                   0.0145
    14 default_idle                               0.2692
    14 .text.lock.namei                           0.0112
    12 .text.lock.sched                           0.0253
    12 .text.lock.memory                          0.0504
    12 .text.lock.dquot                           0.0408
    12 .text.lock.buffer                          0.0189
     9 fget                                       0.1250
     7 __alloc_pages                              0.0107
     7 .text.lock.super                           0.1228
     6 unlock_page                                0.0577
     6 unix_poll                                  0.0405
     6 rmqueue                                    0.0102
     6 pipe_poll                                  0.0600
     6 __free_pages_ok                            0.0086
     5 sys_poll                                   0.0066
     5 sock_poll                                  0.1250
     5 __free_pages                               0.1562
     4 get_pid                                    0.0101
     4 do_poll                                    0.0182
     4 do_page_fault                              0.0030
     4 __pollwait                                 0.0278
     4 __generic_copy_to_user                     0.0556
     4 .text.lock.fcntl                           0.0317
     3 zap_page_range                             0.0027
     3 try_to_release_page                        0.0417
     3 system_call                                0.0536
     3 poll_freewait                              0.0441
     3 fput                                       0.0123
     3 do_pollfd                                  0.0221
     2 handle_IRQ_event                           0.0147
     2 do_gettimeofday                            0.0161
     2 balance_dirty_state                        0.0250
     2 atomic_dec_and_lock                        0.0278
     2 alloc_inode                                0.0067
     1 tcp_rcv_established                        0.0005

10 minutes later, I saw my terminal back to life for a few seconds. The load
was around 75 (for one minute avg). I was again able to capture some profile
informations :

230650 total                                      0.1529
 97605 .text.lock.filemap                       128.5968
 42396 .text.lock.inode                          63.4671
 36755 shrink_cache                              35.0716
 20108 prune_icache                              38.0833
  9117 inode_has_buffers                        175.3269
  8156 invalidate_inode_pages                    48.5476
  7298 .text.lock.vmscan                         31.4569
  3500 __wake_up                                 17.8571
  1618 swap_out                                   1.2841
  1221 default_idle                              23.4808
  1065 .text.lock.swap                           18.3621
   334 try_to_free_buffers                        1.0183
   237 statm_pgd_range                            0.4593
   160 .text.lock.ioctl                           3.8095
   145 .text.lock.buffer                          0.2287
   116 unlock_page                                1.1154
    68 do_softirq                                 0.3091
    62 schedule                                   0.0473
    48 __free_pages                               1.5000
    35 .text.lock.dquot                           0.1190
    29 fget                                       0.4028
    27 .text.lock.sched                           0.0570
    23 __free_pages_ok                            0.0329
    22 nr_free_buffer_pages                       0.1833
    19 .text.lock.namei                           0.0152
    16 sock_poll                                  0.4000
    15 system_call                                0.2679
    15 rmqueue                                    0.0255
    15 .text.lock.super                           0.2632
    14 unix_poll                                  0.0946
    14 pipe_poll                                  0.1400
    13 fput                                       0.0533
    13 .text.lock.memory                          0.0546
    12 do_flushpage                               0.2727
    12 balance_dirty_state                        0.1500
    11 try_to_release_page                        0.1528
    11 megaraid_isr_memmapped                     0.1447
    11 get_pid                                    0.0278
    11 do_pollfd                                  0.0809
    10 __alloc_pages                              0.0153
     9 __generic_copy_to_user                     0.1250
     8 sys_poll                                   0.0106
     8 __wake_up_sync                             0.0317
     8 __pollwait                                 0.0556
     7 timer_bh                                   0.0072
     7 poll_freewait                              0.1029
     7 invalidate_bdev                            0.0188
     7 do_poll                                    0.0318
     7 d_lookup                                   0.0246

This just lasted a few seconds before the terminal freeze again.

And so on ... I think I'll have to reboot soon ...

Hopefully, this will help.


Regards,
Sylvain.

