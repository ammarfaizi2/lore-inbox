Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUBLTeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUBLTeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:34:07 -0500
Received: from buserror-extern.convergence.de ([212.84.236.66]:29574 "EHLO
	heck") by vger.kernel.org with ESMTP id S266558AbUBLTbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:31:45 -0500
Date: Thu, 12 Feb 2004 20:31:38 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] bogus __KERNEL_SYSCALLS__ usage
Message-ID: <20040212193137.GE28768@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040212162856.GU12634@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212162856.GU12634@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> I just did a mini-audit of users of __KERNEL_SYSCALLS and turned
> up a bunch of uglies. The patch below is the easy ones
> (nothing to fix, they were defining it and including unistd.h for no reason).
> The remainders will need more work.
...
> 	drivers/media/dvb/frontends/tda1004x.c:#define __KERNEL_SYSCALLS__
> 	drivers/media/dvb/frontends/sp887x.c:#define __KERNEL_SYSCALLS__
> 	drivers/media/dvb/frontends/alps_tdlb7.c:#define __KERNEL_SYSCALLS__
> 
> Joy joy. Implementing their own firmware loaders by directly
> reading files into kernel space. Icky.

Old code, implemented before request_firmware() existed.

The problem is that the current dvb_i2c stuff has no direct access
to a sysfs struct device, which is necessary for request_firmware().
Possible solutions have briefly been discussed on the linux-dvb list,
one of them ditching dvb_i2c in favor of the kernel i2c subsystem.

So please be patient, work is under way. See also
Documentation/dvb/firmware.txt.


Johannes
