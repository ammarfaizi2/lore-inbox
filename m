Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751110AbWFFESO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFFESO (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 00:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFFESO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 00:18:14 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:46252 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751110AbWFFESN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 00:18:13 -0400
Date: Tue, 6 Jun 2006 00:13:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: x86_64 system call entry points
To: Martin Bisson <bissonm@discreet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606060017_MC3-1-C1B2-81E5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44846210.4080602@discreet.com>

On Mon, 05 Jun 2006 12:55:44 -0400, Martin Bisson wrote:

> - sysenter/32 bits, executed on a 32 bit machine: I get a segfault on 
> the sysenter instruction.  I use the following code to enter the system 
> call:
> pid_t getpid32()
> {
>     pid_t resultvar;
> 
>     asm volatile (
>     "push    %%ebp\n\t"
>     "push    %%ecx\n\t"
>     "push    %%edx\n\t"
>     "mov     %%esp,%%ebp\n\t"
>     "sysenter\n\t"
>     ".space 20,0x90\n\t"
>     "pop     %%edx\n\t"
>     "pop     %%ecx\n\t"
>     "pop     %%ebp\n\t"
>     : "=a" (resultvar)   
>     : "0" (__NR_getpid)
>     : "memory");
> 
>     return resultvar;
> }

sysenter always returns to a fixed address (in the vdso) no matter
where you invoke it from.

-- 
Chuck

