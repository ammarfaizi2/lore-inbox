Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTJOSRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTJOSRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:17:37 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:53413 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263764AbTJOSRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:17:34 -0400
Message-ID: <3F8D8F3A.5040506@nortelnetworks.com>
Date: Wed, 15 Oct 2003 14:17:30 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on incoming packets and scheduler
References: <3F8CA55C.1080203@nortelnetworks.com> <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Tue, 14 Oct 2003, Chris Friesen wrote:

>>I have a long-running cpu hog background task, and a high-priority
>>critical task that waits on a socket for network traffic.  When a packet
>>comes in, I'd like the cpu hog to be swapped out ASAP, rather than
>>waiting for the end of the timeslice.  Is there any way to make this happen?


> What do you mean for high priority? Is it an RT task? The wakeup (AKA
> inserion in the run queue) happen soon :
> IRQ->do_IRQ->softirq->net_rx_action->ip_rcv->...
> but if your task is not RT there no guarantee that it'll preempt the
> current running.

Yes, it was an RT task.

It appears that 2.4.20 fixes this issue, but there is another one 
remaining that the latency appears to be dependent on the number of 
incoming packets.  See thread "incoming packet latency in 2.4.[18-20]" 
for details.  This behaviour doesn't show up in 2.6, and I'm about to 
test 2.4.22.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

