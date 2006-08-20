Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWHTTb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWHTTb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWHTTb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:31:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:39160 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751170AbWHTTb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:31:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Sun, 20 Aug 2006 21:31:44 +0200
User-Agent: KMail/1.9.1
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201913.39989.arnd@arndb.de> <200608201237.13194.chase.venters@clientec.com>
In-Reply-To: <200608201237.13194.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608202131.45946.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 19:36, Chase Venters wrote:

> Unless there's some TLS kernel magic that I've totally missed, using errno in 
> this manner is totally unsafe anyway. So I would NAK the above because your 
> kernel_execve() function gives an unsafe errno value significance it should 
> not have by turning it into a return value.

It has always resulted in an unsafe errno value, my patch just fixes it on
a few architectures and makes it safe there. Note that never even noticed
execve returning -1 on some architectures and -errno on others, and if
execve succeeds, errno is never assigned anyway.

> (As an aside, shouldn't that have read [ ret = -errno; ] anyway?)

Right, thanks for pointing this out.
 
> Unless 'errno' has some significant reason to live on in the kernel, I think 
> it would be better to kill it and write kernel syscall macros that don't muck 
> with it.

The direction in which this patch goes is to kill off kernel syscalls
entirely. The main problem there is that kernel_execve needs an architecture
specific implementation (calling sys_execve does the wrong thing), so doing
it all in one step would require knowing how to do it on all 20 architectures.
Once the execve kernel syscall is gone, errno can die with it.

	Arnd <><
