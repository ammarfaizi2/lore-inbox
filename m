Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUL2Kkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUL2Kkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 05:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUL2Kkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 05:40:36 -0500
Received: from kidushin.jct.ac.il ([147.161.1.19]:41361 "HELO
	kidushin.jct.ac.il") by vger.kernel.org with SMTP id S261438AbUL2KkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 05:40:24 -0500
Message-ID: <41D289A6.7050805@jct.ac.il>
Date: Wed, 29 Dec 2004 12:40:38 +0200
From: Michael Tewner <tewner@jct.ac.il>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux SMT question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry if this has been covered before. If it has, please direct me 
on where to look.

Over the year, our university started acquiring dual Xeon servers. I 
havn't been able to find consistent information regarding how linux 
deals with the SMT (HT?). I have checked the source code, and am getting 
a few hints, but perhaps someone could help me. People both in and out 
of the university are asking me for help.

Our setup assumes a dual XEON HT IBM x335.

As far as I understand it, HT CPU's are 2 processing units sharing 
memory; a forked process runs in parallel accessing the same text 
segment, but each side maintiaining it's own Program Counter (and 
registers?), etc. Is this correct?

Does this mean that if the scheduler puts different processes on the 
same physical CPU they'll start context switching between them, 
providing slower performance than had they been on 2 physical CPU's?

Some linux releases were showing 2 CPU's, while others were showing 4. 
Was there a point where HT was incorporated in the kernel? And before 
then, what did the scheduler do?

Are the following logs related to the SMT?
mapping CPU#0's runqueue to CPU#2's runqueue.
mapping CPU#1's runqueue to CPU#3's runqueue.

What (where?) does the scheduler do to run processes on separate 
physical CPUs. I seem to remember hearing something about allocating a 
process to separate physical CPU's BEFORE using logical CPU's but 
something there doesn't sound right... I mean, if 5 processes are all 
waiting, are 4 going to be allocated (2 on each CPU) or would only 2 be 
allocated unless there are forked processes (that can run together on 2 
sibling logical CPU's). Can the scheduler know that 2 processes are related?

Finally, is there a way to force an application to run an separate 
physical CPU's? Perhaps a MOSIX-like /proc interface (where each PID has 
a special file with preferences such as keep-local)?

I'm sorry for all the questions. I havn't seen this covered in Kernel 
Traffic. The only solid information I found was at 
http://kerneltrap.org/node/391 where Ingo Molnar explains the 
requirements. What *has* been implemented?

Please CC replies. (I'll eventually join the kernel list....)

Thank you very much for your help,
    -tewner
