Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVCWHh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVCWHh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVCWHh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:37:26 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:55162 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262846AbVCWHhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:37:20 -0500
Message-ID: <42411CAC.5000808@yahoo.com.au>
Date: Wed, 23 Mar 2005 18:37:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arun Srinivas <getarunsri@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related
 questions?
References: <BAY10-F5987CA2A1E1D6C406F5371D94F0@phx.gbl>
In-Reply-To: <BAY10-F5987CA2A1E1D6C406F5371D94F0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Srinivas wrote:
> If the SMT (apart from SMP) support is enabled in the  .config file, 
> does the kernel recogonize the 2 logical processor as 2 logical or 2 
> physical processors?
> 

You shouldn't be able to select SMT if SMP is not enabled.
If SMT and SMP is selected, then the scheduler will recognise
the 2 processors as logical ones.

> Also, as the hyperthreaded processor may schedule 2 threads in the 2 
> logical cpu's, and it may not necessarily be form the same process i.e., 
> the 2 thread it schedules may be from the same or from the different 
> process.
> 

Yes.

> So, is there any way I can tell the scheduler (assuming I make the 
> scheduler recogonize my 2 threads..i.e., it knows their pid) to schedule 
> always my 2 threads @ the same time? How do I go abt it?
> 

Use sched_setaffinity to force each thread onto the particular
CPU. Use sched_setscheduler to acquire a realtime scheduling
policy. Then use mutexes to synchronise your threads so they
run the desired code segment at the same time.

