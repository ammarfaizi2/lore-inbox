Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVFQGit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVFQGit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 02:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVFQGit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 02:38:49 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:15785 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261754AbVFQGir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 02:38:47 -0400
Message-ID: <42B26FF8.6090505@bredband.net>
Date: Fri, 17 Jun 2005 08:38:48 +0200
From: =?ISO-8859-1?Q?Patrik_H=E4gglund?= <patrik.hagglund@bredband.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
References: <42B199FF.5010705@bredband.net> <42B19F65.6000102@nortel.com>
In-Reply-To: <42B19F65.6000102@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Patrik Hägglund wrote:
>
>> Kernel threads seems to generally be scheduled in the SCHED_OTHER 
>> class (with the 'migration' thread as an exception).
>
>
> This is on purpose.  The idea is that realtime processes get all the 
> time they request.  If the kernel threads are interrupting the 
> realtime app, then the latency of the realtime app is degraded.

Don't you get the problem with priority inversion? I.e., if you have two 
processes, P1 and P2, scheduled with SCHED_FIFO, where P1 has higer 
priority than P2. Now, if P1 gets blocked and needs some kernel thread 
to execute to get unblocked, then P2 is scheduled before the kernel 
thread, and can execute without any time limit.

That is, you should be much better off if the kernel threads has a 
_high_ priority. Then the execution progress can only be blocked by 
kernel threads, not by user space threads and processes. Or have I 
missed something?

(Besides that, as I see it, SCHED_RR/SCHED_FIFO are scheduling 
abstractions on their own, not necessarily  connected to  "low latency " 
or "realtime".)
