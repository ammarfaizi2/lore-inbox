Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273893AbRI0UeZ>; Thu, 27 Sep 2001 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273895AbRI0UeP>; Thu, 27 Sep 2001 16:34:15 -0400
Received: from adsl-66-121-5-226.dsl.snfc21.pacbell.net ([66.121.5.226]:12348
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S273883AbRI0UeC>; Thu, 27 Sep 2001 16:34:02 -0400
Message-ID: <3BB38D4E.5000100@switchmanagement.com>
Date: Thu, 27 Sep 2001 13:34:22 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Wayne Cuddy <wcuddy@crb-web.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronization Techniques in 2.2 Kernel
In-Reply-To: <20010927141238.E5125@crb-web.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Cuddy wrote:

>If I understand wait_queues correctly the process has to be sleeping before a
>wake_up call will have any effect (I.E. they are not queued).  Can this be
>worked around with semaphores or some other method?  I am open to ideas here.
>
>Any and all help is appreciated.
>
>Wayne
>
I apologize in advance if this is not quite right, having only done 
"hello world" kernel modules thus far (plus a good deal of kernel source 
browsing).  I think you need to "unfold" the interruptible_sleep_on call 
and do it yourself by adding current to the wait queue before checking 
any cards, setting current->state = TASK_INTERRUPTIBLE, then checking 
all cards and if none has data, calling schedule.  When you get back 
from schedule (i.e. your ISR has received data and done a wake_up) or 
any card has data, remove yourself from the wait queue and set your 
state to runnable.  This hopefully gives you the "atomic check condition 
and sleep if not satisfied" behavior.

Regards,
Brian Strand



