Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSGOKBd>; Mon, 15 Jul 2002 06:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSGOKBc>; Mon, 15 Jul 2002 06:01:32 -0400
Received: from holomorphy.com ([66.224.33.161]:60583 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317396AbSGOKBb>;
	Mon, 15 Jul 2002 06:01:31 -0400
Date: Mon, 15 Jul 2002 03:03:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: updated serial drivers
Message-ID: <20020715100310.GF23693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20020707010009.C5242@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020707010009.C5242@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 01:00:09AM +0100, Russell King wrote:
> I've been maintaining a serial driver "off the side" of the ARM port
> which cleans up the serial driver mess that we currently have, with
> many duplications of serial.c, each with subtle bugs.

global_cli() overhead on my testbox is a significant problem.

Profile info from tbench 1024 with ttyS0 as stdout, taken on a 16 cpu
i386 box with 16GB of RAM and irqbalance disabled, (needed to boot):

90372662 total                                    713.6412
44801051 default_idle                             861558.6731
36220921 mod_timer                                113190.3781
2510075 timer_bh                                 2764.3998
2344795 __global_cli                             8620.5699
1446315 __wake_up                                7693.1649
1370742 do_gettimeofday                          10078.9853
924996 schedule                                 831.8309
512368 do_softirq                               2328.9455
103136 tasklet_hi_action                        526.2041
 40640 system_call                              923.6364
 19238 do_page_fault                             14.2927
 12835 add_wait_queue                           103.5081
 10667 remove_wait_queue                         83.3359
  7990 bh_action                                 38.4135
  5303 pte_alloc_one                             27.6198
  4665 schedule_timeout                          29.1562
  4584 pgd_alloc                                 24.3830
  3870 syscall_call                             351.8182
  3633 try_to_wake_up                             6.3073
  3100 exit_notify                                3.5068
  2566 del_timer                                 14.9186

The disabling of irqbalance should make these profiling results valid.


Cheers,
Bill
