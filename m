Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSHEKKG>; Mon, 5 Aug 2002 06:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHEKKG>; Mon, 5 Aug 2002 06:10:06 -0400
Received: from mail1.commerzbank.com ([212.149.48.99]:49073 "EHLO
	mail1.commerzbank.com") by vger.kernel.org with ESMTP
	id <S317849AbSHEKKF>; Mon, 5 Aug 2002 06:10:05 -0400
Message-ID: <A1081E14241CD4119D2B00508BCF80410843F2A6@SV021558>
From: "Zeuner, Axel" <Axel.Zeuner@partner.commerzbank.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: AW: Thread group exit
Date: Mon, 5 Aug 2002 12:10:56 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-08-05 at 09:58, Zeuner, Axel wrote:
> > I would expect, that changes of the parent of one member of 
> the thread group
> > do not affect the interactions between the members of the group. 
> > Corrections are welcome.
> 
> I agree with your diagnosis I'm not convinced by your change. 
> The thread
> groups are only used by NGPT not by glibc pthreads while the 
> problem is
> true across both.
> 
> Possibly the right fix is to remove the reparent to init increment of
> self_exec_id and instead explicitly check process 1 in the 
> signal paths.
> 
> Opinions ?
The idea not to change the self_exec_id seems to be the more general 
solution: less work in the loop in the forget_original_parent function 
and only changes in do_notify_parent kernel/signal.c are required:
One could check for tsk->p_pptr/parent == child_reaper and force a SIGCHLD
in this case. Changes in the self_exec_id because of exec's are 
catched by the code in exit_notify already.
The difference between self_exec_id and parent_exec_id would become 
a real exec counter.

Axel
