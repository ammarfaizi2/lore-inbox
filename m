Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289183AbSANKQc>; Mon, 14 Jan 2002 05:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289182AbSANKQW>; Mon, 14 Jan 2002 05:16:22 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:2313 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289183AbSANKQP>;
	Mon, 14 Jan 2002 05:16:15 -0500
Message-ID: <3C42AF6B.6050304@debian.org>
Date: Mon, 14 Jan 2002 11:14:03 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <fa.dardpev.1m1emjp@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2002 10:16:13.0843 (UTC) FILETIME=[7EE3F630:01C19CE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:


> With this change, generating a report on ISA hardware and other
> facilities configured in at boot time would be trivial.  This would
> make the autoconfigurator much more capable.  Best of all, the only
> change required to accomplish this would be safe edits of print format
> strings.


Better: create a /proc/driver and every driver will register in it.
This file can help some bug report (and not only autoconfigurator).

BTW, my new tests for:
   memory (request_mem_region)
   io port (request_region)
   irq (request_irq)
   dma (request_dma)
are nearly completes.
I think every ISA card should registers one of
these resources.
With the check of register_blkdev, register_chrdev
and miscdevices we should have a complete list of the
old ISA devices.
(this would detect only already detected devices,
but autoconfigure is not yet designed for bootfloppies
makers).

With such new test: no patch to kernel and nearly automatic
generation of probes.

Some patch are still welcome. I.e.:
some people with copy+paste have not changes the driver
string. A kernel patch will help distinguish the two drivers.
watchdog: to many driver register as 'watchdog' (or 'serial',
or 'ps2mouse'. This will create some difficulties to
autoconfigurators. A patch will help us (but it would break
other userspace tools?)

	giacomo


