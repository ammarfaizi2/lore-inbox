Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTHaUmL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTHaUmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:42:11 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:12931 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261376AbTHaUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:42:09 -0400
Date: Sun, 31 Aug 2003 13:41:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
Message-ID: <1807550000.1062362498@[10.10.2.4]>
In-Reply-To: <1806700000.1062361257@[10.10.2.4]>
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernbench: (make -j vmlinux, maximal tasks)
>                               Elapsed      System        User         CPU
>               2.6.0-test4       45.87      116.92      571.10     1499.00
>        2.6.0-test4-nick10       46.91      114.03      584.16     1489.25

Actually, now looks like you have significantly more idle time, so perhaps
the cross-cpu (or cross-node) balancing isn't agressive enough:

      4583    10.0% default_idle
      2246     1.4% total
       377    12.0% zap_pte_range
       210    15.2% free_hot_cold_page
       161     9.3% buffered_rmqueue
       138    47.4% __set_page_dirty_buffers
       102     0.7% do_anonymous_page
        54     4.9% clear_page_tables
...
       -51    -4.3% file_move
       -63    -7.9% pte_alloc_one
       -63    -3.4% path_lookup
       -69   -18.5% .text.lock.file_table
       -70    -8.2% strnlen_user
       -76    -1.0% __d_lookup
       -96    -1.5% page_add_rmap
      -104   -16.8% copy_process
      -109    -2.9% find_get_page
      -118   -28.2% release_task
      -267   -18.8% schedule
      -357    -6.7% __copy_to_user_ll
      -531   -15.2% __copy_from_user_ll
      -809    -3.4% page_remove_rmap

