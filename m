Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbQKISSv>; Thu, 9 Nov 2000 13:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQKISSl>; Thu, 9 Nov 2000 13:18:41 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:51974 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129886AbQKISSX>; Thu, 9 Nov 2000 13:18:23 -0500
Message-ID: <3A0AEB32.D7EBE448@mvista.com>
Date: Thu, 09 Nov 2000 10:21:38 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mkravetz@sequent.com, linux-kernel@vger.kernel.org
Subject: Re: test9: running tasks not in run-queue
In-Reply-To: <20001108151148.B25050@w-mikek.des.sequent.com> <200011090104.RAA17535@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date:        Wed, 8 Nov 2000 15:11:49 -0800
>    From: Mike Kravetz <mkravetz@sequent.com>
> 
>    The following code in __wake_up_common() is then
>    executed:
> 
>            if (best_exclusive)
>                    best_exclusive->state = TASK_RUNNING;
>            wq_write_unlock_irqrestore(&q->lock, flags);
> 
> test10 fixes this error, now it sets TASK_RUNNING and
> adds the task back to the runqueue all under the runqueue
> lock.

In our preemptable kernel work we often put (or leave) tasks on the run
queue that are not in state TASK_RUNNING and want to treat them as if
they are in state TASK_RUNNING.  We thus changed the test in schedule()
to "task_on_runqueue(prev)"....

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
