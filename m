Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUEAX1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUEAX1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEAX1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:27:16 -0400
Received: from zero.aec.at ([193.170.194.10]:41997 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262634AbUEAX1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:27:02 -0400
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
References: <1PMQ9-5K6-3@gated-at.bofh.it> <1PVTx-4rY-25@gated-at.bofh.it>
	<1R9hC-6rC-3@gated-at.bofh.it> <1Rbjr-7Y5-17@gated-at.bofh.it>
	<1RbW9-8sE-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 02 May 2004 01:26:59 +0200
In-Reply-To: <1RbW9-8sE-17@gated-at.bofh.it> (Andrew Morton's message of
 "Sun, 02 May 2004 01:20:09 +0200")
Message-ID: <m3llkbybi4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> Maybe we should change __syscall_return() to return the -ve errno rather
> than -1?
>
>
> diff -puN include/asm-i386/unistd.h~a include/asm-i386/unistd.h
> --- 25/include/asm-i386/unistd.h~a	2004-05-01 16:09:35.115389384 -0700
> +++ 25-akpm/include/asm-i386/unistd.h	2004-05-01 16:09:49.513200584 -0700
> @@ -295,10 +295,6 @@
>  
>  #define __syscall_return(type, res) \
>  do { \
> -	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
> -		errno = -(res); \
> -		res = -1; \
> -	} \
>  	return (type) (res); \
>  } while (0)

Don't do that please. That will break all the user space
programs who use asm/unistd.h to define own system calls
(it is quite common).

Make it conditional on __KERNEL__

-Andi
  

