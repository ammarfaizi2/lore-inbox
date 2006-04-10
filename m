Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWDJE4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWDJE4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 00:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWDJE4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 00:56:47 -0400
Received: from bureau14.utcc.utoronto.ca ([128.100.132.42]:20895 "EHLO
	bureau14.utcc.utoronto.ca") by vger.kernel.org with ESMTP
	id S1750966AbWDJE4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 00:56:47 -0400
Message-ID: <4439E507.6060000@utoronto.ca>
Date: Mon, 10 Apr 2006 00:54:31 -0400
From: Marek Olszewski <m.olszewski@utoronto.ca>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: JIT based dynamic instrumentation in the linux kernel.  We need your
 help!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For a class project we have built an x86 kernel module which can 
dynamically instrument system calls with very fine granularity.  It does 
so (explained a bit below) in a similar fashion to Valgrind, Pin, and 
DynamoRio, except that it runs in the kernel.  It's interface is quite 
similar to Pin except that the "tools" or plugins (that dictate the kind 
of instrumentation) are written as kernel modules.  Our goal is to open 
source the project after the class for everyone to enjoy.

This is not a probe based instrumentation tool such as kprobes.  Our 
tool instruments code by copying dynamic basic blocks over to a code 
cache while instrumenting them according to the wishes of a user written 
plugin.  This plugin can look at all the instructions being executed and 
decide (the first time they are encountered) whether to instrument them 
or not.  This allows users to write tools that can instrument branches, 
memory references or just about any type of instruction without 
specifying the exact instruction locations.  Instrumentation is provided 
in the form of a function, however, our tool will try to inline for 
improved performance.  The end result is a simple to use, fast 
(hopefully, we haven't gotten around to performance tests) 
instrumentation tool to help kernel hackers debug, profile, monitor, and 
annotate system calls (instrumenting arbitrary kernel code is future 
work).  We believe that the size and complexity of the Linux kernel 
motivates such a tool.

We are hoping to publish our work in the near future, and to that end, 
we are looking for plugin ideas from real kernel hackers.  We ourselves 
are not kernel hackers (maybe one day) and therefore are not aware of 
the needs of the potential users of our tool (please don't flame us for 
this, it's only a class project).  These ideas should require fine 
grained instrumentation making them not suitable for probed based 
instrumentation.

To give you a rough idea of what's possible: we are currently working on 
a plugin that would find branches with hint prefixes and monitor their 
directions at runtime.  Hence, for a given workload, the plugin will be 
able to check for branches that are incorrectly hinted (possibly with 
the likely() macro) and report these back to the user.  We are thinking 
that a similar plugin that monitors all branches to detect whether a 
hint could be profitable might also be useful.

If you think that you might have a nice idea, please let us know.  We 
will try to write it and include it in our paper.  It will also be 
available for all to use when we release the tool.

Thank you!

Marek

