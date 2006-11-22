Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756200AbWKVSG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbWKVSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbWKVSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:06:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756200AbWKVSG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:06:56 -0500
Message-ID: <45649166.8060209@redhat.com>
Date: Wed, 22 Nov 2006 13:05:26 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, phil.el@wanadoo.fr, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@redhat.com>,
       oprofile-list@lists.sourceforge.net,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.19-rc5: known regressions (v3)
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>	<20061115102122.GQ22565@stusta.de>	<200611151135.48306.dada1@cosmosbay.com> <200611221128.05769.dada1@cosmosbay.com>
In-Reply-To: <200611221128.05769.dada1@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------040404030003050606060700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404030003050606060700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> On Wednesday 15 November 2006 11:35, Eric Dumazet wrote:
> 
>>On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:
>>
>>>Subject    : x86_64: oprofile doesn't work
>>>References : http://lkml.org/lkml/2006/10/27/3
>>>Submitter  : Prakash Punnoor <prakash@punnoor.de>
>>>Status     : unknown
>>
> 
> I hit the same problem on i386 architecture too, if CONFIG_ACPI is not set.
> 
> # opcontrol --setup --event=RESOURCE_STALLS:1000 --vmlinux=$VMFILE
> # opcontrol --start
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/enabled: No such file or 
> directory
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/event: No such file or directory
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/count: No such file or directory
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/kernel: No such file or 
> directory
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/user: No such file or directory
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/unit_mask: No such file or 
> directory
> Using 2.6+ OProfile kernel interface.
> Reading module info.
> Using log file /var/lib/oprofile/oprofiled.log
> Daemon started.
> Profiler running.
> 
> # ls -l /dev/oprofile/
> total 0
> drwxr-xr-x 1 root root 0 Nov 22 11:18 1
> -rw-r--r-- 1 root root 0 Nov 22 11:18 backtrace_depth
> -rw-r--r-- 1 root root 0 Nov 22 11:18 buffer
> -rw-r--r-- 1 root root 0 Nov 22 11:18 buffer_size
> -rw-r--r-- 1 root root 0 Nov 22 11:18 buffer_watershed
> -rw-r--r-- 1 root root 0 Nov 22 11:18 cpu_buffer_size
> -rw-r--r-- 1 root root 0 Nov 22 11:18 cpu_type
> -rw-rw-rw- 1 root root 0 Nov 22 11:18 dump
> -rw-r--r-- 1 root root 0 Nov 22 11:18 enable
> -rw-r--r-- 1 root root 0 Nov 22 11:18 pointer_size
> drwxr-xr-x 1 root root 0 Nov 22 11:18 stats
> # dmesg | grep oprofile
> oprofile: using NMI interrupt.
> # opcontrol --version
> opcontrol: oprofile 0.9.2 compiled on Nov 22 2006 11:24:09
> 
> Eric

You will also need another patch checked into the oprofile cvs last week mentioned:

http://sourceforge.net/mailarchive/message.php?msg_id=35422937

-Will


--------------040404030003050606060700
Content-Type: text/x-patch;
 name="opalloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opalloc.diff"

Index: libop/op_alloc_counter.c
===================================================================
RCS file: /cvsroot/oprofile/oprofile/libop/op_alloc_counter.c,v
retrieving revision 1.6
diff -u -r1.6 op_alloc_counter.c
--- libop/op_alloc_counter.c	1 Oct 2003 21:53:46 -0000	1.6
+++ libop/op_alloc_counter.c	17 Nov 2006 17:03:04 -0000
@@ -130,7 +130,7 @@
 		counter_arc const * arc = list_entry(pos, counter_arc, next);
 
 		if (allocated_mask & (1 << arc->counter))
-			return 0;
+			continue;
 
 		counter_map[depth] = arc->counter;
 

--------------040404030003050606060700--
