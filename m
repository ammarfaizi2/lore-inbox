Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFDBPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFDBPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFDBPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:15:00 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:3225 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261199AbVFDBO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:14:56 -0400
Date: Fri, 3 Jun 2005 18:14:48 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: linux-kernel@vger.kernel.org, for_spam@gmx.de
Subject: Re: maximum of 256 loop devices - not enough for cdrom server
Message-Id: <20050603181448.04085f82.rdunlap@xenotime.net>
In-Reply-To: <20050526201438.GA23028@localhost>
References: <013d01c5618f$2939d240$2000000a@schlepptopp>
	<20050526201438.GA23028@localhost>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005 22:14:38 +0200 Jose Luis Domingo Lopez wrote:

| On Thursday, 26 May 2005, at 03:06:34 +0200,
| roland wrote:
| 
| > I want to build a cd-rom server and want to use the loop-driver (loop.c) for that.
| > That server will be HUGE and I will need to loopback mount more than 256 .iso images in the near future.
| > Unfortunately, the loop driver doesn`t support >256 device nodes.
| > 
| > Is there a possible solution for this "problem" ?


First, let's understand the kernel version.  2.4.x or 2.6.y?
I'm only looking at 2.6.y.

Roland, have you tried increasing the max. value of max_loop yet?


| Beware: not a kernel hacker, not even a proficient programmer.
| 
| It seems it would be easy, just changing the max current loop device
| number value (256) to something higher (i.e., 4096). Note, however, that
| loop devices are described by an array of structs statically allocated at
| module load time, so expect memory usage to grow linearly and search operations 
| on the array become slower at least linearly.

The loop_device array is kmalloc-ed at load/init time.
On x86 (32-bit), struct loop_device is 336 bytes, and with kmalloc()
having an upper limit of 128 KB, the max. number of loop_devices that
can be allocated at one time is 128 * 1024 / 336 = 390, not a huge
improvement over 256 loopback devices.

I don't know of any reason that vmalloc() couldn't be used here
instead of kmalloc(), and once that hurdle is cleared (the 128 KB one),
since minor number on 2.6.y is 20 bits, there can be plenty of loopback
devices AFAIK.

I'm sure that Al or probably Andrew could answer this reliably.

| There is one thing that maybe would need some attetion: minor number
| allocation for loopback block devices. Now they are assigned at module
| initialization, but I don't know the current status in the Linux kernel
| with respect to (major,minor) sizes and allocation.
| 
| Hope someone more knowledgeable jumps into this :-)


---
~Randy
http://www.madrone.org/donate/RFD1.html
