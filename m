Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbULIX7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbULIX7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbULIX7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:59:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32750 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261680AbULIX7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:59:50 -0500
Message-ID: <41B8E6F1.4070007@mvista.com>
Date: Thu, 09 Dec 2004 15:59:45 -0800
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: RCU question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on VST code.  This code is called from the idle loop to check for 
future timers.  It then sets up a timer to interrupt in time to handle the 
nearest timer and turns off the time base interrupt source.  As part of 
qualifying the entry to this state I want to make sure there is no pending work 
so, from the idle task I have this:

	if (local_softirq_pending())
		do_softirq();

	BUG_ON(local_softirq_pending());

I did not really expect to find any pending softirqs, but, not only are there 
some, they don't go away and the system BUGs.  The offender is the RCU task. 
The question is: is this normal or is there something wrong?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

