Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTD2MrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTD2MrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:47:04 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:14749 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261863AbTD2Mq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:46:56 -0400
Date: Tue, 29 Apr 2003 14:59:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chandrasekhar <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stack Trace dump in do_IRQ
Message-ID: <20030429125904.GA7949@wohnheim.fh-wedel.de>
References: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 April 2003 18:04:28 +0530, Chandrasekhar wrote:
> 
> We have a custom driver which runs on Red Hat Advanced Server 2.1(kernel
> version 2.4.9-e.3).
> On loading  the driver (using insmod) and running our configuration program,
> we got folowing warning message "do_IRQ: stack overflow: 1786" and along
> with the stack trace.
> 
> The configuration program, however, ran successfully.
> 
> On going through the do_IRQ code in arch/i386/kernel/irq.c we found that is
> is used for debugging check for stack overflow i.e if the stack size is less
> than 2KB free.
> There is no similar debugging check in other kernels like 2.4.7-10,2.4.18-3
> and 2.4.18-14.
> What is the significance of this debugging information and why other kernels
> dont have the same check? Also, if the stack overflow can cause future
> problems, then
> how can we increase the stack size? Thanks in advance for any information on
> this.

I don't know those kernel versions, they appear to be redhat-specific.
But current mainline kernels, both 2.4 and 2.5 have had this check for
a while already. You have to set a config option to enable them.

In principle, there is absolutely no way how linux can tell when the
check will spill over. The check in do_irq simply checks if the kernel
was close, at the time of that interrupt. This is enough to catch
dangerous code paths and fix them, before any real problems occur.

"close" for mainline kernels means, there is less than 1k of free
stack left. Your redhat kernel seems to use 2k, I even go as far as
5k, but that definitely fills my logs. 1786 is the number of bytes
still free on the stack. Should be enough for you.

If you can reproduce something as low as 1786 for a recent 2.4 or 2.5
kernel, I'd be interested in the backtrace. For 2.4.9, I just don't
care. :)

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
