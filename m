Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWBXCfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWBXCfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWBXCfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:35:24 -0500
Received: from web31605.mail.mud.yahoo.com ([68.142.198.151]:25484 "HELO
	web31605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751810AbWBXCfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:35:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fMozqfMEmlIXfNJTjY2UupXKwddKuncRNmpoomi04lSmtufmzUbFTaV8eah6XWs263jcE3Q8J41XeIK5Tm+A/Rx9mXTrorXNiBgD7t6BEyMvZLEEgf+3ARY3oDW55oHdiXHYMZNzWv4cyuygubz8CpjuL8CrB5rsfuXVLPW88WI=  ;
Message-ID: <20060224023522.43019.qmail@web31605.mail.mud.yahoo.com>
Date: Thu, 23 Feb 2006 18:35:22 -0800 (PST)
From: Mohit Jaggi <jaggi_mohit@yahoo.com>
Subject: latency measurements on 2.4.21 (EL 3.0) on SMP (4-cpu)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
I am testing a PCI card that accelerates and offloads
certain functions. I have a multi-threaded real-time
priority (SCHED_FIFO) process to send data to the card
and receive the results. Sending is done by a an
ingress thread(priority=25) and receiving is handled
by an egress thread(priority=35). Using affinity calls
I have made sure that they run concurrently on two
different CPUs. My goal is get the lowest possible
latency from the card. I am measuring it using the
delta of the values returned by gettimeofday() from
ingress thread just before I send the data to the card
and from egress thread just after I receive it. 
While trying various scenarios I noticed that if the
ingress thread send a few messages and then sleeps for
time 't' using usleep(t), then depending on 't' I see
that the latency measured as described above is
different. For example, for t=20k I observe latency of
around 20ms. If I use t=50k I observe 60ms. For 40k  I
see 40ms. Since my delta is not counting this sleep I
find this behaviour quite surprising. I would
appreciate if anyone can venture an explanation.

I have been trying to find out how gettimeofday()
works on SMP linux. Any pointers?

Is there a catch to using real-time priority processes
that I should be aware of? Because the latency
measurements I am doing are of the order of
microseconds I believe I have to have real time
scheduling otherwise time-slicing which is of the
order of milliseconds will mess it up.

Thanks,
Mohit.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
