Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVGQUTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVGQUTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVGQUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:19:52 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:44003 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261373AbVGQUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:19:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm1: mount problems w/ 3ware on dual Opteron
Date: Sun, 17 Jul 2005 22:20:06 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org>
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507172220.07299.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 15 of July 2005 10:36, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> 
> (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
> kernel.org syncs up)

Apparently, mount does not work with partitions located on a 3ware RAID
(8006-2PL controller) in a dual-Opteron box (64-bit kernel).

If the kernel is configured with preemption and NUMA, it cannot mount any
"real" filesystems and the output of "mount" is the following:

rootfs on / type ext3 (rw)
/dev/root on / type ext3 (rw)
proc on /proc type proc (rw,nodiratime)
sysfs on /sys type sysfs (rw)
tmpfs on /dev/shm type tmpfs (rw)

(hand-copied from the screen).  I have tried some other combinations (ie.
preemption w/o NUMA, NUMA w/o preemption etc.) and it seems that it works
better with CONFIG_PREEMPT_NONE set, although even it this case some
filesystems are mounted read-only.

The mainline kernels (ie. -rc3 and -rc3-git[1-4]) have no such problems.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
