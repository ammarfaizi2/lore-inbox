Return-Path: <linux-kernel-owner+w=401wt.eu-S1751836AbWLNKER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWLNKER (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWLNKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:04:17 -0500
Received: from il.qumranet.com ([62.219.232.206]:40634 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbWLNKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:04:16 -0500
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 05:04:16 EST
Message-ID: <45811D0F.2070705@argo.co.il>
Date: Thu, 14 Dec 2006 11:44:47 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com>
In-Reply-To: <20061214010608.GA13229@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> A large number of people have expressed interest recently in the
> userspace i/o driver core which allows userspace drivers to be written
> to handle some types of hardware.
>
> Right now the UIO core is working and in the -mm releases.  It's been
> rewritten from the last time patches were posted to lkml and is much
> simpler.  It also includes full documentation and two example drivers
> and two example userspace programs that test those drivers.
>
> But in order to get this core into the kernel tree, we need to have some
> "real" drivers written that use it.  So, for anyone that wants to see
> this go into the tree, now is the time to step forward and post your
> patches for hardware that this kind of driver interface is needed.
>
>   
[...]

> If anyone has any questions on how to use this interface, or anything
> else about it, please let me and Thomas know.
>
>   

I understand one still has to write a kernel driver to shut up the irq.  
How about writing a small bytecode interpreter to make event than 
unnecessary?

The userspace driver would register a couple of bytecode programs: 
is_interrupt_pending() and disable_interrupt(), which the uio framework 
would call when the interrupt fires.

The bytecode could reuse net/core/filter.c, with the packet replaced by 
the mmio or ioregion, or use something new.

-- 
error compiling committee.c: too many arguments to function

