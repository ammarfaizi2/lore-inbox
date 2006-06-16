Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWFPGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWFPGsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWFPGsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:48:43 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:49377 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1751094AbWFPGsn (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:48:43 -0400
Message-Id: <5.1.1.5.2.20060616160901.04554dc0@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 16 Jun 2006 16:48:38 +1000
To: Peter Williams <pwil3058@bigpond.net.au>, linux-Kernel@vger.kernel.org
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: New Metrics to measure Load average
Cc: vatsa@in.ibm.com, Zoltan.Menyhart@bull.net, nagar@watson.ibm.com,
       vlobanov@speakeasy.net, david@dworf.com, nacc@us.ibm.com,
       balbir@in.ibm.com, akpm@osdl.org
In-Reply-To: <449244D4.8000003@bigpond.net.au>
References: <5.1.1.5.2.20060616110033.04483890@brain.sedal.usyd.edu.au>
 <5.1.1.5.2.20060616110033.04483890@brain.sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

(1) Yes it would be a good idea to separate them for each CPU. The we have 
that as an information too.

Out project is as follows:

Our project which is conducted as part of CEL(and CSIRO) requires to 
separate the load along individual user lines.
This project is a GRID computing project.

We have developed a prediction  model called "Free Load Profile Model for 
Load Profile Prediction" for the purpose of scheduling in the Grid.

Irrespective of number of CPUs in  the system we need to know the total 
load which has been exerted on all CPUs (on the system) by individual users 
and system/root.

As  required by the prediction  model then we need to know the break down 
of that load along the user lines.

It is up to the prediction model to handle the issues with number CPUs as 
it has such a capability.

(2) I am working at Electrical Engineering. My number until next Tuesday 
would be 93517227.
IF you are living close to the Sydney Uni we will be able to discuss things 
later.

I had a discussion with Rusty Russel  and he had few suggestions for me too.

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia


At 03:42 PM 6/16/2006 +1000, you wrote:
>sena seneviratne wrote:
>>Hi Shailabh,Vadim,
>>Zoltan, Peter Williams,
>>David Osojnik, Nishanth Aravamudan,
>>Balbir Singh, Andrew Morton
>>
>>(1) Please give us your valuable comments on this important change to 
>>introduce a new Metric to measure Load average.
>>Currently /proc/loadavg reports only the resultant value.
>>We have done the scheduling in a Grid project. As a part of that we had 
>>to do some changes to the Linux kernel as well.
>>The  problem with the load metric of current Linux/Unix is that it 
>>measures CPU load and Disk load without indicating the true nature of the 
>>load, thereby creating some confusion among the readers. For example, if 
>>a CPU bound task switches on to read a large chunk of disk data, then the 
>>load average value would still continue to indicate this activity as a 
>>load, yet the true CPU load during this period would have been zero. This 
>>situation triggered us to make necessary additions to the kernel so that 
>>CPU load and Disk load could be reported separately. Further the 
>>specialisation of load helped our model to perform predictions when there 
>>is interference between CPU and Disk IO loads.
>>In the user mode, a new proc file called /proc/loadavgus would collect 
>>the new data according to a new format which would look like the following,
>>                 CPU    Disk
>>500             0.7     0
>>501             0.9     1
>>502             0.9     0
>>503             1.03    1
>>504             0.93    0
>>505             1.0     0
>>What do you think about this change?
>
>I think that it is useful to have the separate components (cpu and disk 
>I/O) of the load average available but, while I have no objection to the 
>data being made available on a per user basis, I think that it should 
>primarily be provided on a per CPU and total system basis.  This is 
>because most people are only interested in the loads for the system as a 
>whole while per CPU data is a good indication of how well load balancing 
>is working.
>
>This latter observation leads me to suggest that "weighted" CPU load per 
>CPU would also be useful.  So output like:
>
>CPU0  0.3 0.45 0.9
>CPU1  0.4 0.5 0.8
>TOTAL 0.7 0.95 1.7
>
>would be nice to have where the columns were raw CPU load, weighted CPU 
>load and disk I/O load respectively.
>
>In summary, I like the idea but think that you should do it properly and 
>provide the data that will interest most users and then add the per user 
>data that meets your specific needs as an optional extra.
>
>Peter
>PS I live very close to Sydney University if you want to discuss these 
>ideas in person.
>--
>Peter Williams                                   pwil3058@bigpond.net.au
>
>"Learning, n. The kind of ignorance distinguishing the studious."
>  -- Ambrose Bierce

