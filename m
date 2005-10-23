Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVJWUtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJWUtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVJWUtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:49:45 -0400
Received: from maggie.cs.pitt.edu ([130.49.220.148]:40334 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750763AbVJWUto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:49:44 -0400
From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Task profiling in Linux
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Date: Sun, 23 Oct 2005 22:49:38 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510232249.39236.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I need some help to make profiling of an application on Linux. I need to 
measure the computation time between different points of my program, 
considering only the CPU time that the task has actually executed (i.e. 
without the intervals of time that the task has been preempted by other 
tasks).

To accomplish that, I can't just read the current time in different parts of 
the program, nor I can set and use a timer, because this wouldn't consider 
preemptions...

I found out that Linux provides the getrusage() syscall which provides the 
information that I need. This syscall also says both user and system times 
used by the task, which is a very useful thing.

However, it has two main drawbacks:

- its precision is very low: I'm working with real-time tasks on a Athlon-64  
and I need a more accurate estimation

- it can't be invoked by a generic task to know the execution time of another 
task

The only idea that I had is to insert some hooks in the kernel functions and 
use some high resolution timer to compute the time that my task has 
actually executed. This timer starts whenever the task obtains the CPU, and is 
stopped whenever the task yields the CPU.

Therefore, I just need to know which functions are invoked when a task starts  
executing on the CPU and when it looses the CPU.

May somebody tell me which are those functions ?

If somebody has suggestions about how doing this profiling, let me know. 

Many thanks,

            Claudio
