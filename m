Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSEWSPS>; Thu, 23 May 2002 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316975AbSEWSPS>; Thu, 23 May 2002 14:15:18 -0400
Received: from air-2.osdl.org ([65.201.151.6]:13573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316976AbSEWSPR>;
	Thu, 23 May 2002 14:15:17 -0400
Date: Thu, 23 May 2002 11:13:22 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [announce] 'kerneltop'
Message-ID: <Pine.LNX.4.33L2.0205231112260.4119-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is kerneltop version 0.5.

usage:  must be <root> to run it since it clears
/proc/profile every <N> seconds.

./kerneltop: usage: "./kerneltop [options]
  -m <mapfile>  (default = "/boot/System.map")
  -p <pro-file> (default = "/proc/profile")
  -l <lines>    set number of lines to print (def. = 20; max = 100)
  -s <seconds>  set sleep time in seconds (def. = 1)
  -t <ticks>    set threshold of number of ticks to print (def. = 1)
                  a function must have this many ticks to be printed
  -u print unsorted (skip the sort)
  -V print version and exit

Just unpack the tarball and run 'make' to build it.
It lives at <http://www.xenotime.net/linux/kerneltop/>.

Boot with "profile=N" (kernel command line option) to that
/proc/profile is created (e.g., profile=4).

Caveat emptor:
Using in-kernel profiling has a small side-effect.
Adding 'kerneltop' adds another side-effect to memory usage,
processor scheduling, cache usage, etc.

Does not profile modules.
Does not know window size; use -l to tell it if you want to print
more than 20 lines.

'kerneltop' is based on 'readprofile' with large changes.

BTW, does anyone know of another such program that
already exists (and that I missed somehow in my web search)?

Comments, feedback?

Thanks,
~Randy


Example with -s 5 (5-second intervals) and profile=4:
In this interval of 500 ticks (x86), 109 ticks were in the kernel
and the rest were in userspace ('make dep').


bin/kerneltop Version 0.5
Linux dragon.pdx.osdl.net 2.4.18 #1 Wed Apr 23 12:56:42 PST 2002 i686 unknown
Sampling_step: 16 | Address range: 0xc0105000 - 0xc020fbd2
----------------------------------------------------------------------
address  function    time:  2002-05-23/11:06:26    ticks
c0105380 default_idle                                 57
c012e8a0 si_swapinfo                                   8
c0111980 do_page_fault                                 5
c01254e0 file_read_actor                               5
c01225b0 do_anonymous_page                             4
c01228c0 pte_alloc                                     2
c0143b30 d_lookup                                      2
c020a4f0 __generic_copy_to_user                        2
c020a670 strnlen_user                                  2
c0106e90 system_call                                   1
c010b930 old_mmap                                      1
c0121160 zap_page_range                                1
c0121eb0 do_wp_page                                    1
c0122680 do_no_page                                    1
c0122a20 vm_enough_memory                              1
c0123c80 __insert_vm_struct                            1
c0125000 do_generic_file_read                          1
c0129af0 kmem_cache_alloc                              1
c0129b50 kmalloc                                       1
c012c380 __free_pages_ok                               1
00000000 total                                       109

