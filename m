Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270586AbTGUQ5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270582AbTGUQz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:55:29 -0400
Received: from pop.gmx.net ([213.165.64.20]:24974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270624AbTGUQxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:53:46 -0400
Message-Id: <5.2.1.1.2.20030721175652.01bb4868@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 21 Jul 2003 19:13:04 +0200
To: <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [NOTAPATCH] Re: [PATCH] O6int for interactivity 
Cc: Davide Libenzi <davidel@xmailserver.org>, Valdis.Kletnieks@vt.edu
In-Reply-To: <5.2.1.1.2.20030721143309.01bb95f8@pop.gmx.net>
References: <Pine.LNX.4.55.0307201715130.3548@bigblue.dev.mcafeelabs.co m>
 <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:39 PM 7/21/2003 +0200, Mike Galbraith wrote:
>...  Comments on the attached [kiss] approach?

In case anyone decides to take a look, there's a line missing which was 
supposed to advance the timeout in the case where we haven't yet timed out, 
and the task is not interactive.  A better way to do what I intended is to 
change...

      if (rq->idx && TASK_INTERACTIVE(p))
           rq->interval_ts++
to
      if (!rq->idx - !TASK_INTERACTIVE(P) == 0)
            rq->interval_ts++;

With this diff in place, and with bonnie and a make bzImage sharing my cpu 
with irman2, I see no terminal starvation.  Both the make and bonnie are 
proceeding just fine.

         ciao,

         -Mike 

