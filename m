Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUDBNQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDBNQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:16:16 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:50829 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263334AbUDBNQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:16:14 -0500
Date: Fri, 2 Apr 2004 15:15:52 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040402131551.GA10920@localhost>
References: <406D3E8F.20902@abbeynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <406D3E8F.20902@abbeynet.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 2nd 2004 Marco Fais wrote:

> [...] 
 
> When compiling with distcc the local system doesn't show any kernel
> panic, while the same system used as a "remote compiler system" dies
> very quickly.

> >>EIP; c01372ae <__free_pages_ok+26e/280>   <=====
> ... 
> Trace; e08d7eab <[8139too]rtl8139_rx_interrupt+6b/3b0>

> <0>Kernel panic: Aiee, killing interrupt handler!

>From a very superficial examination of your data, it looks like there is
something going wrong in the interrupt handling of the driver for (one
of) the network cards.

Distcc can generate a lot of network traffic. You might experiment with
switching the role of the two network cards (in case there might be
something wrong with the hardware of one of them) or use the '--listen'
directive in the distccd configuration to do so.

If the panic is indeed caused by the network driver, then it should also
be possible to trigger and debug this with a tool like netcat (listen on
the panicking box with 'nc -l someport' and send some stuff from another
box ('cat /dev/zero | nc panicker someport' or vice versa).

Sadly, nothing of this will solve your problem of course, but it might
pinpoint the cause somewhat more accurately, leading hopefully to a
solution!
-- 
Marco Roeland
