Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbRFYQtP>; Mon, 25 Jun 2001 12:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRFYQtF>; Mon, 25 Jun 2001 12:49:05 -0400
Received: from [32.97.182.101] ([32.97.182.101]:25227 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264875AbRFYQsz>;
	Mon, 25 Jun 2001 12:48:55 -0400
Importance: Normal
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
To: Jeff Dike <jdike@karaya.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Stevenson <mistral@stev.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF831FC2D7.C211A862-ON85256A76.005AEC98@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Mon, 25 Jun 2001 12:48:46 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/25/2001 12:47:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>abali@us.ibm.com said:
>> I am running in to a problem, seemingly a deadlock situation, where
>> almost all the processes end up in the TASK_UNINTERRUPTIBLE state.
>> All the process eventually stop responding, including login shell, no
>> screen updates, keyboard etc.  Can ping and sysrq key works.   I
>> traced the tasks through sysrq-t key.  The processors are in the idle
>> state.  Tasks all seem to get stuck in the __wait_on_page or
>> __lock_page.
>
>I've seen this under UML, Rik van Riel has seen it on a physical box, and
we
>suspect that they're the same problem (i.e. mine isn't a UML-specific
bug).

Can you give more details?  Was there an aic7xxx scsi driver on the box?
run_task_queue(&tq_disk) should eventually unlock those pages
but they remain locked.  I am trying to narrow it down to fs/buffer
code or the SCSI driver aic7xxx in my case. Thanks. /bulent



