Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTD3Rsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTD3Rsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:48:37 -0400
Received: from watch.techsource.com ([209.208.48.130]:65515 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262253AbTD3Rsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:48:36 -0400
Message-ID: <3EB00FD2.5000008@techsource.com>
Date: Wed, 30 Apr 2003 14:02:58 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: naive questions about thrashing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel version 2.4.18-26.7.x under Red Hat 7.2.

I wrote a CPU-intensive program which attempts to use over 700 megs of 
RAM on a 512-meg box, therefore it thrashes.

One thing I noticed was that 'top' reported that the kernel ("system") 
was using 68% of the CPU.  (The offending process was getting about 9%.) 
  How much CPU involvement is there in sending I/O requests to the drive 
and waiting on an interrupt?  Maybe I don't understand what's going on, 
but I would expect the CPU involvement in disk I/O to be practically 
NIL, unless it's trying to be really smart about it.  Is it?  Or maybe 
the kernel isn't using DMA... this is a Dell Precision 340.  I'm not 
sure what drive is in it, but I would be surprised if it weren't using DMA.

The next thing has to do with interactivity.  I don't know how much 
interactivity code is in the 2.4 kernel, but as I understand it, it's 
based on a process giving up its timeslice.  Well, if a process is 
causing numerous page faults, is it not, in effect, giving up its 
timeslice?  Is it therefore being scheduled as an interactive process? 
If so, the process scheduler is very mistaken.  In my naive opinion, 
causing a page fault should NOT be an indication of interactivity.  It 
seemed to me that the process was getting too much attention from the 
process scheduler.  The thrashing process was getting run while other 
processes (like X, etc.) were being almost completely starved.

Does causing a page fault get interpreted as interactivity?

Going under the assumption that disk I/O should require almost no CPU 
involvement, it seems to me that memory could be managed so that 
processes which behave themselves should feel no effect from the 
thrashing, while the thrashing process continues to thrash and therefore 
have little opportunity to use the CPU.  This would require that the VM 
not swap out pages which are being used heavily by well-behaved 
processes.  Instead, it seems that the thrashing process is being 
allowed to completely trash everything else running in the system.

Now, I'm not stupid.  Someone's going to tell me that the problem is in 
user space, and that I should fix the user space program.  (I am doing 
that.)  I can certainly understand that perspective, but it seems to me 
that the fairest result of a process misbehaving is that it should only 
punish itself, not every other process in the system.

