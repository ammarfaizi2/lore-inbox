Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBLVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBLVeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWBLVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:34:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:37862 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751005AbWBLVeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:34:14 -0500
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:33:03 +1100
Message-Id: <1139779983.5247.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 17:13 +0000, Roger Leigh wrote:
> Hi folks,
> 
> When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
> Freescale 7447A):
> 
> $ date && touch f && ls -l f && rm -f f && date
> Sun Feb 12 12:20:14 GMT 2006
> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
> Sun Feb 12 12:20:14 GMT 2006
> 
> Notice the timestamp is 3 minutes in the future compared with the
> system time.  "make" is not a very happy bunny running on this kernel
> due to every touched file being 3 minutes in the future.
> 
> When the same command is run on 2.6.15.3:
> 
> $ date && touch f && ls -l f && rm -f f && date
> Sun Feb 12 14:27:27 GMT 2006
> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 14:27
> Sun Feb 12 14:27:27 GMT 2006
> 
> In this case the times are identical, as you would expect.
> 
> In both these cases, the chrony NTP daemon is running, if that might
> be a problem.

Can you strace vs. ltrace and see if the gettimeofday or clock_gettime
syscalls are ever called ? I wonder if you have a glibc new enough to
use the vDSO to obtain the time or if it's using the syscall... The vDSO
on ppc32 is very new.

Also, are your kernels built with ARCH=ppc or ARCH=powerpc ?

Ben.


