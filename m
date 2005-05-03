Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVECSiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVECSiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVECSg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:36:58 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:26287 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261559AbVECSfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:35:55 -0400
Message-Id: <200505031846.AAA19043@harvest.india.hp.com>
From: "Amanulla G" <amanulla@india.hp.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <jdp@india.hp.com>
Subject: RE: /proc on 2.4.21 & 2.6 kernels....
Date: Wed, 4 May 2005 00:05:44 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU6AJoeO0CnzZ/OS5+I/5oC0NMKxgWDWJ6Q
In-Reply-To: <1112718903.6275.75.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
Sorry for the late follow up on this.

Re:
>> My second part of question was:
>> On 2.6 kernels, we have  /proc/<tgid>/task/xxx 
>> My question is /proc/<tgid> stats reflect resource utilization of the
>> threads it has created? 

> yes afaik it's cumulative over the threads there.


I just wrote a small program which creates a thread. The thread just hogs
cpu and does nothing else.

***********************************************
#include <pthread.h>
#include <stdio.h>
void *foo(void *p)
{
  printf ("Thread ");
  fflush(stdout);
    while (1);
}
int main(void){
    int ret;
    pthread_t p1 ;
    ret = pthread_create(&p1, NULL, foo, NULL);
    pthread_join(p1,NULL);
} 
***********************************************

I checked the above program on a machine with 2.6.9-5.EL running.

I checked the top output, it says, global cpu util is 99.% but the cpu
utilization of a.out is 0.0!!

None of the processes that top showed has had more than 0.2% of CPU
utilization, but still global cpu utilization is 99.9%.
Interestingly, /proc/pid related to a.out process had two entries under
/proc/pid/task directory
1) Entry related to a.out
2) Entry related to thread created by a.out

But the statistics under /proc/pid/stat related to a.out process do not
reflect the resource utilization of the thread it has created. 

Could you please look into this issue? 

With Best Regards,
Amanulla




-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Tuesday, April 05, 2005 10:05 PM
To: Amanulla G
Cc: linux-kernel@vger.kernel.org; jdp@india.hp.com
Subject: RE: /proc on 2.4.21 & 2.6 kernels....

On Tue, 2005-04-05 at 21:52 +0530, Amanulla G wrote:
>  Hi, 
> Thanks for the mail.
> May be I didn't put my question correctly.
> On 2.4.21 based kernels /proc has got hidden directories which has got the
> thread related statistics.

I understood your question. 
However 2.4.21 kernels from kernel.org do not have such hidden
directories.

> My second part of question was:
> On 2.6 kernels, we have  /proc/<tgid>/task/xxx 
> My question is /proc/<tgid> stats reflect resource utilization of the
> threads it has created? 

yes afaik it's cumulative over the threads there.




