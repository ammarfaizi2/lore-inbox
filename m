Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752202AbWJ0PuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbWJ0PuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbWJ0PuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:50:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:23529 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752202AbWJ0PuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:50:03 -0400
Message-ID: <45422A94.1040402@watson.ibm.com>
Date: Fri, 27 Oct 2006 11:49:40 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: David Rientjes <rientjes@cs.washington.edu>
CC: Martin Tostrup Setek <martitse@student.matnat.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated correctly
References: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no> <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Fri, 27 Oct 2006, Martin Tostrup Setek wrote:
> 
>> from: Martin T. Setek <martitse@ifi.uio.no>
>>
>> cpu_count in struct taskstats should be the same as the corresponding (third)
>> value found in /proc/<pid>/schedstat
> 
> I disagree in favor of Documentation/accounting/taskstats-struct.txt.
> cpu_count is the number of delay values recorded, so accumulating them is 
> appropriate.
> 
> 		David


David's right. The delay accounting field cpu_count
is measuring how many delay values are recorded in the field cpu_delay_total
(so that one can divide one by the other to get an average if needed).

For the delays reported for a single task (ie. __delayacct_add_tsk called only
once for a given task), the effect will be what Martin wants i.e. cpu_count will be
the same as /proc/pid/schedstat's third field (sched_info->pcnt)

But when the delays are reported for a tgid, where *accumalation* of delays for
all constituent pids is being done (by calling __delayacct_add_tsk repeatedly), what
is desired is to accumalate both cpu_count and cpu_delay_total.

So the patch proposed by Martin is incorrect.

--Shailabh
