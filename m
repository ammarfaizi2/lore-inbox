Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbULHT7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbULHT7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULHT7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:59:04 -0500
Received: from alog0178.analogic.com ([208.224.220.193]:8832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261342AbULHT6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:58:35 -0500
Date: Wed, 8 Dec 2004 14:57:14 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: krishna <krishna.c@globaledgesoft.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure  flow of time using Time Stamp Counter on i386
 machines
In-Reply-To: <41B75638.5020109@globaledgesoft.com>
Message-ID: <Pine.LNX.4.61.0412081449120.15951@chaos.analogic.com>
References: <41B75638.5020109@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, krishna wrote:

> Hi all,
>
>   Can anyone tell me how to measure flow of time using Time Stamp Counter on 
> pentium machines.
>   Which documentation could help me in understanding it.
>
> Regards,
> Krishna Chaitanya
> -

The rdtsc instruction returns the CPU clocks that have occurred
since the time the machine was started. If you assemble the
provided code as:

as -o tim.o tim.S

... then link this with your code, it will return the CPU clocks
that have occurred between two successive calls..

extern long long tim(void);

code()
{
     long long total;

     (void)tim();         // Initialize
     do_something();      // Some code to measure
     total = tim();       // Get measurement

    printf("Total CPU clocks are %lld\n", total);

}


-------------
#
#	This is free software written by Richard B. Johnson. No
#	copyright is claimed. It is also not guaranteed to do anything
#	useful.
#
#

.data
lastl:	.long	0
lasth:	.long	0
.text
.align	8 
.globl	tim
.type 	tim@function

#
#  Return the CPU clock difference between successive calls.
#
tim:	pushl	%ebx
 	rdtsc
 	movl	(lastl), %ebx		# Get last low longword
 	movl	(lasth), %ecx		# Get last high longword
 	movl	%eax, (lastl)		# Save current low longword
 	movl	%edx, (lasth)		# Save current high longword
 	subl	%ebx, %eax		# Current - last
 	sbbl	%ecx, %edx		# Same with borrow
 	popl	%ebx
 	ret
.end
--------------------



Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
