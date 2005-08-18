Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVHRCjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVHRCjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVHRCjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:39:05 -0400
Received: from web54406.mail.yahoo.com ([206.190.49.136]:16021 "HELO
	web54406.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932103AbVHRCjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:39:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z/IWZYNKDIysTXlQA3YvHoMqQSFoHk3Ic8KV5DV7hL++XdfgcW0dcxJtNcQe2LUWpS8aKsrSj2nzLzOnoq95x4W5oDt3LYzgh+DKvBnT2RGAxS6tP++R/Crel7kZ8fj6ec02q/8otDcIAI7pDkhgTIOmDEc7/t+tItMVuR6mho0=  ;
Message-ID: <20050818023853.48406.qmail@web54406.mail.yahoo.com>
Date: Wed, 17 Aug 2005 19:38:53 -0700 (PDT)
From: Sundar Narayanaswamy <sundar007@yahoo.com>
Subject: Latency with Real-Time Preemption with 2.6.12
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to experiment using 2.6.12 kernel with the realtime-preempt 
V0.7.51-38 patch to determine the kernel preemption latencies with the 
CONFIG_PREEMPT_RT mode. The test program I wrote does the following on
a thread with highest priority (99) and SCHED_FIFO policy to simulate
a real time thread.

t1 = gettimeofday
nanosleep(for 3 ms)
t2 = gettimeofday

I was expecting to see the difference t2-t1 to be close to 3 ms. However, 
the smallest difference I see is 4 milliseconds under no system load, 
and the difference is as high as 25 milliseconds under moderate to 
heavy system load (mostly performing disk I/O).

Based on the articles and the mails I read on this list, I understand that 
worst case latencies of 1 ms (or less) should be possible using the RT 
Preemption patch, but I am unable to get anything less than 4 millseconds 
even with sleep times smaller than 3 ms. I am running the tests on a SBC 
with a 1.4G Pentium M, 512M RAM, 1GB compact flash (using IDE). 

I believe I have the high resolution timer working correctly, because if I 
comment out the sleep line above t2-t1 is consistenly 0 or 1 microsecond.

Following earlier discussions (in July) in this list, I tried to set kernel 
configuration parameters like CONFIG_LATENCY_TRACE to get tracing/debug 
information, but I didn't find these parameters in my .config file.

I appreciate your suggestions/insights into the situation and steps that I 
should try to get more debug/tracing information that might help to understand 
the cause of high latency.

Thanks for your help,
sundar.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
