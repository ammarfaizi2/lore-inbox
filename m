Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTDKUMQ (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTDKUMQ (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:12:16 -0400
Received: from [203.197.168.150] ([203.197.168.150]:30473 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S261702AbTDKUMO (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:12:14 -0400
Message-ID: <3E972414.9090607@tataelxsi.co.in>
Date: Sat, 12 Apr 2003 01:52:44 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GFP_KERNEL doubt!! <was Tasklet doubt!>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

The problem of allocating more than 2.5 MB was actually more or less 
related to the physical memory left in the kernel.
But I moved the task which allocated the memory from the tasklet to the 
keventd and used kmalloc (GFP_KERNEL).

The first time I ran my module, it failed at the same 2.5 MB limit.
I restarted the system and tried it again, and I was able to allocate 5 
MB successfully.
I restarted the system and ran "free".
The report is as follows:
             total       used       free     shared    buffers     cached
Mem:         62264      30624      31640          0       8072      16096
-/+ buffers/cache:       6456      55808
Swap:       192772          0     192772

Then I ran gcc and compiled my code and then for the "free" report again.
The report is as follows:
             total       used       free     shared    buffers     cached
Mem:         62264      45320      16944          0       9256      28384
-/+ buffers/cache:       7680      54584
Swap:       192772          0     192772

I was able to notice that the physical memory had gone down though "gcc" 
had completed.
The time I ran my application, I had about 2.5M physical memory left, so 
I was able to allocate 2.5M.

What is happening ? What is the buffers/cache column and is there any 
way I could force the kernel to release the cached memory back to free 
physical ?
Is there any way I can allocate more than what is left free from the 
physical memory ?

Any pointers or suggestions would be very helpful.

Thank you.
Regards,
Sriram

