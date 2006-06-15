Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWFOCud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWFOCud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 22:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWFOCud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 22:50:33 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:7586 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1751288AbWFOCud (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 22:50:33 -0400
Message-Id: <5.1.1.5.2.20060615115356.033acde0@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 15 Jun 2006 12:50:23 +1000
To: Erik Mouw <erik@harddisk-recovery.com>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: Introduce a New Metrics to measure Load average.
Cc: linux-Kernel@vger.kernel.org
In-Reply-To: <20060614124816.GD11542@harddisk-recovery.com>
References: <5.1.1.5.2.20060614150410.0465ceb0@brain.sedal.usyd.edu.au>
 <5.1.1.5.2.20060614150410.0465ceb0@brain.sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

(1) Yes layout was just like you have mentioned, yet I put user names so 
that it is easy read in the e-mail

-Why do you want to tell the load per user? Just the CPU and disk load
-should be sufficient.

This is the answer:
The reason for the division of load signal along the "user lines" is that 
in the Grid computing the users submit jobs separately.
Therefore if we are to collect a historical data of a particular user, then 
we have to collect it separately free from system/root load.

In a grid, which is implemented through Globus, a user will have to 
register himself with the provider and needs to be allocated a separate 
login account. Thus the user is only allowed to submit his HPC jobs to this 
particular account. Therefore if we can measure the load under that 
particular user-login, such collection of historical load profiles could 
show very high epochal behavior, which is related to the user's operational 
habits. This fact further emphasizes the importance of the Division of the 
load signal.
After applying the Division of load at the kernel level, we have developed 
a Prediction model called "Free load profile model for load and run time 
prediction"
Erik our load prediction system has given very good results as well.
(2) Now about the tests
As I have documented all this yet need to perform some standard tests for 
the sake of completion.
What tests should I carry out to prove that the system is still intact?

Please tell me whether the below is correct?

(a) As suggested by the http://kernel-perf.sourceforge.net/ the lmbench and 
re-aim-7 test packages can be used to test the performance of the kernel 
before making changes and after. (Not done as yet)

(b) Further tests have been carried out to check the response time of short 
tasks before making changes and after making changes. The results indicated 
that there was no difference in the response time after introducing the 
changes to the kernel (done)

(c) Thereafter the tests have been carried out to check the runtime of long 
tasks before and after making changes. The results of the tests revealed 
that there is no change in reported runtime in both occasions.(done)

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia






At 02:48 PM 6/14/2006 +0200, you wrote:
>On Wed, Jun 14, 2006 at 03:12:29PM +1000, sena seneviratne wrote:
> > The  problem with the load metric of current Linux/Unix is that it 
> measures
> > CPU load and Disk load without indicating the true nature of the load,
> > thereby creating some confusion among the readers. For example, if a CPU
> > bound task switches on to read a large chunk of disk data, then the load
> > average value would still continue to indicate this activity as a load, 
> yet
> > the true CPU load during this period would have been zero.
>
>Right, we've seen such things with busy servers.
>
> > This situation
> > triggered us to make necessary additions to the kernel so that CPU load 
> and
> > Disk load could be reported separately. Further the specialisation of load
> > helped our model to perform predictions when there is interference between
> > CPU and Disk IO loads.
>
>OK.
>
> > In the user mode, a new proc file called /proc/loadavgus would collect the
> > new data according to a new format which would look like the following,
> >
> >                 CPU    Disk
> > Root            0.7     0
> > User1   0.9     1
> > User2   0.9     0
> > User3   1.03    1
> > User4   0.93    0
> > User5   1.0     0
>
>The kernel doesn't know about user names, only uids. So the layout
>should be something like:
>
>                 CPU     Disk
>0               0.7     0
>500             0.9     1
>501             0.9     0
>
> > What do you think about this change?
>
>Why do you want to tell the load per user? Just the CPU and disk load
>should be sufficient.
>
>
>Erik
>
>--
>+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
>| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

