Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTEWGFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTEWGFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:05:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:51145 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263638AbTEWGFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:05:20 -0400
Date: Thu, 22 May 2003 23:18:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
Message-ID: <17990000.1053670694@[10.10.2.4]>
In-Reply-To: <20030522021652.6601ed2b.akpm@digeo.com>
References: <20030522021652.6601ed2b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
> 
> . One anticipatory scheduler patch, but it's a big one.  I have not stress
>   tested it a lot.  If it explodes please report it and then boot with
>   elevator=deadline.
> 
> . The slab magazine layer code is in its hopefully-final state.
> 
> . Some VFS locking scalability work - stress testing of this would be
>   useful.

Well, unsure about the problems I reported earlier - seems to be related
to modem disconnects during SDET runs ... the hung session seems to lock
up the system somehow. But that could have been around for ages - I'll
try to be more scientific about reproducing it at some point.

SDET results are about the same, kernel compile is down a bit on systime
(16-way NUMA-Q)

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.69-mm7       46.58      117.00      578.47     1492.00
               2.5.69-mm8       46.09      115.11      570.74     1487.25

      1004     2.0% default_idle
       272     8.3% __copy_from_user_ll
       129     1.7% __d_lookup
        79     7.5% link_path_walk
...
       -50    -1.3% find_get_page
       -55    -1.5% zap_pte_range
       -66    -6.5% file_move
       -74    -1.2% page_add_rmap
       -80    -0.6% do_anonymous_page
      -110    -6.9% schedule
      -139    -7.0% atomic_dec_and_lock
      -698    -0.4% total
     -1139    -4.6% page_remove_rmap

Not sure quite what that's all about, but there it is ;-)

