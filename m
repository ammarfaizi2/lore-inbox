Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbUCPQYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbUCPQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:20:53 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:2564 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263965AbUCPQQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:16:53 -0500
Message-ID: <40572C09.5080208@techsource.com>
Date: Tue, 16 Mar 2004 11:32:09 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: -O3.... again
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this has been beat to death, but I was wondering about something, 
and google isn't being forthcoming.

I understand that the biggest problem with -O3 is the automatic function 
inlining.  It tends to make things worse, due to cache misses.

Well, the default maximum for automatic inlining for GCC (--param 
max-inline-insns-auto=n) is 300 pseudo instructions, which sounds 
awfully high to me (although I don't know what a pseudo instruction 
quite corresponds to).

Has anyone tinkered with different values for -finline-limit, or 
specifically max-inline-insns-auto to see if they could actually get any 
benefit out of it?

It seems to me that as a function grows beyond a certain size, the value 
of inlining it diminishes rapidly.  Only when the function-call overhead 
is a significant part of the over-all run-time of the rest of the 
function does it really help to inline.  Well, if the kernel isn't 
getting benefit from the defaults for -O3, then perhaps the defaults are 
wrong and need to be tweaked.

Anyone experiment with this?  Any thoughts?


I doubt this would apply well right off to the kernel, but right now, 
I'm doing gentoo emerges of GCC with varying CFLAGS settings.  First, I 
emerge GCC with the experimental values of CFLAGS.  Then I change the 
CFLAGS to a standard setting and time it (the timed run must always have 
the same parameters for the target).  My objective is to determine the 
MINIMUM value of max-inline-insns-auto which yields an improvement over -O2.

