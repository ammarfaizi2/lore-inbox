Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVFBM23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVFBM23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFBM23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:28:29 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:42950 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261391AbVFBM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:28:26 -0400
Message-ID: <429EFB66.8030909@stud.feec.vutbr.cz>
Date: Thu, 02 Jun 2005 14:28:22 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu>
In-Reply-To: <20050601091344.GB11703@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020101080209030105000806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101080209030105000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> indeed it was broken - i fixed x64 LATENCY_TRACE in the -47-16 kernel.

There's a minor bug in it. Syscalls are numbered from zero, so there's 
__NR_syscall_max + 1 of them. Patch attached.
Nonetheless the latency tracing still doesn't work for me on x86_64. It 
compiles but hotplug starts to segfault in an infinite loop during 
booting up. When I disable CONFIG_LATENCY_TRACE, it works.

Michal

--------------020101080209030105000806
Content-Type: text/plain;
 name="rt-latency-NR_syscalls.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-latency-NR_syscalls.diff"

--- linux-RT.mich/kernel/latency.c.orig	2005-06-02 14:16:12.000000000 +0200
+++ linux-RT.mich/kernel/latency.c	2005-06-02 14:15:37.000000000 +0200
@@ -850,7 +850,7 @@ static int notrace l_show_cmdline(struct
 }
 
 #ifdef CONFIG_X86_64
-# define NR_syscalls __NR_syscall_max
+# define NR_syscalls (__NR_syscall_max+1)
 #endif
 
 extern unsigned long sys_call_table[NR_syscalls];

--------------020101080209030105000806--
