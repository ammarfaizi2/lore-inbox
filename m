Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUCKXOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCKXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:14:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:55520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbUCKXOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:14:03 -0500
Date: Thu, 11 Mar 2004 15:15:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-Id: <20040311151559.72706624.akpm@osdl.org>
In-Reply-To: <20040311152728.GA11472@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson <rpeterso@mtholyoke.edu> wrote:
>
> I didn't reboot sam like I said I would.  I decided I'd let it spiral
> down.  I'm still collecting profile data every fifteen minutes.  I
> haven't posted any more graphs.  They look the same as all the others: a
> monotonically increasing ping latency (w/ a corresponding slow increase
> in system load averages - which I'm logging, if anyone wants more data).
> 
> http://depot.mtholyoke.edu:8080/tmp/sam-profile/
> 
> I've been perusing fa.linux.kernel, and saw Brad Laue's thread.  FWIW,
> it smells similar.  When my machines finally go down, ksoftirqd is
> always at the top of the process list.
> 
> Any ideas at all about what might be happening?

The profiles tell a story:

c0217fb0 wait_for_packet                               2   0.0063
c0256660 arpt_do_table                                 2   0.0019
c0265ca0 __generic_copy_to_user                        2   0.0278
c0106bd0 system_call                                   3   0.0536
c0107e8c handle_IRQ_event                              3   0.0326
c014bf10 statm_pgd_range                               3   0.0077
c0120ed4 do_wp_page                                    5   0.0101
c024c0d4 ip_conntrack_expect_related                  47   0.0368
c0105250 default_idle                               2817  70.4250
c024bae0 init_conntrack                             3053   3.7232
00000000 total                                      5962   0.0041

It appears that netfilter has gone berzerk and is taking your machine out.

Are you really sure that nothing is sitting there injecting new rules all
the time?

