Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVJKE3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVJKE3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJKE3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:29:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19149 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751036AbVJKE27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:28:59 -0400
Date: Mon, 10 Oct 2005 22:32:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: i386 spinlock fairness: bizarre test results
In-reply-to: <4WjCM-7Aq-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <434B404F.9020508@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4WjCM-7Aq-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>   After seeing Kirill's message about spinlocks I decided to do my own
> testing with the userspace program below; the results were very strange.
> 
>   When using the 'mov' instruction to do the unlock I was able to reproduce
> hogging of the spinlock by a single CPU even on Pentium II under some
> conditions, while using 'xchg' always allowed the other CPU to get the
> lock:

This might not necessarily be a win in all situations. If two CPUs A and 
  B are trying to get into a spinlock-protected critical section to do 5 
operations, it may well be more efficient for them to do AAAAABBBBB as 
opposed to ABABABABAB, as the second situation may result in cache lines 
bouncing between the two CPUs each time, etc.

I don't know that making spinlocks "fairer" is really very worthwhile. 
If some spinlocks are so heavily contented that fairness becomes an 
issue, it would be better to find a way to reduce that contention.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

