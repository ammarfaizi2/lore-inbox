Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVFUWkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVFUWkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVFUWju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:39:50 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:51914 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261809AbVFUWRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:17:52 -0400
Message-ID: <42B89227.6050501@bredband.net>
Date: Wed, 22 Jun 2005 00:18:15 +0200
From: =?ISO-8859-1?Q?Patrik_H=E4gglund?= <patrik.hagglund@bredband.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Steven Rostedt <rostedt@goodmis.org>, Chris Friesen <cfriesen@nortel.com>
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
References: <42B199FF.5010705@bredband.net> <42B19F65.6000102@nortel.com>	 <42B26FF8.6090505@bredband.net> <1119011872.4846.12.camel@localhost.localdomain> <42B3D7E2.2070600@bredband.net>
In-Reply-To: <42B3D7E2.2070600@bredband.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, Ingo's patch didn't made any difference for my problem with kernel 
starvation.

As expected, the workaround of raising the priority of the 'events' 
kernel thread made it possible to switch VT or switch windows in X (as 
described in my first mail), when running a simple infinite loop. When 
running arbitrary programs, I expect that all kernel threads needs 
higher priority.

I guess that the point with kernel threads is to push heavy kernel 
requests "backwards in the queue", thereby lowering the mean latency for 
SHED_OTHER processes. Therefore, using high priorities for kernel 
threads was not an option. However, this comes at the price of breaking 
SCHED_FIFO/SCHED_RR.

The only clean solution is probably to have priorities that are 
exclusively reserved for use by the kernel. I saw that kernel threads in 
LynxOS may use a priority of 1/2 above of the user-space tasks it 
serves. This seems like a good solution to the problem.

Any other patches out there, ready for a test?

/Patrik Hägglund
