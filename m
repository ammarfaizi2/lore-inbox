Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbSJOFyP>; Tue, 15 Oct 2002 01:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbSJOFyP>; Tue, 15 Oct 2002 01:54:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41105 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262495AbSJOFyO>; Tue, 15 Oct 2002 01:54:14 -0400
Message-ID: <3DABAEDB.9070207@us.ibm.com>
Date: Mon, 14 Oct 2002 22:59:55 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] x86 transition to 4k stacks (0/3)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently uses an 8k stack, per task.  Here is the 
infrastructure needed to allow us to halve that at some point in the 
future.

This is a port of work Ben LaHaise did around 2.5.20 time.  I split it
up and updated it for the new preempt_count semantics.

I split the original patch up into 3 pieces (apply in this order):
* clean thread info infrastructure (1/3)
   - take out all instances of things like (8191&addr) to get
     current stack address.
* stack checking (3/3)
   - use gcc's profiling features to check for stack overflows upon
     entry to functions.
   - Warn if the task goes over 4k.
   - Panic if the stack gets within 512 bytes of overflowing.
* interrupt stacks (3/3)
   - allocate per-cpu interrupt stacks.  upon entry to
     common_interrupt, switch to the current cpu's stack.
   - inherit the interrupted task's preempt count

Any suggestions on how to deal with "gcc -p" and old, buggy versions
of gcc would be appreciated.
-- 
Dave Hansen
haveblue@us.ibm.com

