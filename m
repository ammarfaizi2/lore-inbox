Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUGMFwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUGMFwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUGMFwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:52:23 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:9143 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263962AbUGMFwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:52:22 -0400
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <cone.1089687290.911943.12958.502@pc.kolivas.org> <20040712210107.1945ac34.akpm@osdl.org>
Message-ID: <cone.1089697919.186986.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: devenyga@mcmaster.ca, ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: Preempt Threshold Measurements
Date: Tue, 13 Jul 2004 15:51:59 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>> Certainly the do_munmap and exit_mmap seem to be repeat offenders on my 
>> machine too (more the latter in my case).
>> 
> 
> This is a false positive.  Nothing is setting need_resched(), so
> unmap_vmas() doesn't bother dropping the lock.

Ok well excluding do_munmap and exit_mmap the ones that have shown up 
(some more frequently than others) are: 

6ms at ksoftirqd+0x6b
2ms at sys_ioctl+0x47
2ms at b44_open
6ms at fget+0x28
2ms at write_ordered_buffers+0x37
4ms at blkdev_put+0x48
5ms at add_wait_queue+0x21
4ms at blkdev_put+0x48

and you were right; eventually the reiserfs ones showed up again at 6-8ms

Now which of the above are not false positives and should I try to extract 
the exact locations of them?

Con

