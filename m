Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTIMC5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTIMC5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:57:23 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:61772 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261996AbTIMC5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:57:22 -0400
Date: Fri, 12 Sep 2003 22:56:55 -0400
From: Iker <iker@computer.org>
Subject: Re: [lkml] RE: self piping and context switching
To: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Reply-to: Iker <iker@computer.org>
Message-id: <03f501c379a2$b14b49b0$3203a8c0@duke>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <MDEHLPKNGKAHNMBLJOLKCECHGIAA.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More specifically, I was wondering if the write to the pipe or the call back
into poll involved anything that might prompt the scheduler to replace the
thread in this scenario.

> It's reasonable to expect that this will be the most common case and the
> one to optimize. It is unreasonable to fail if this doesn't happen, since
> it's not guaranteed to happen. Note that if by "without a context switch"
> you really mean without another thread getting a chance to run, then it is
> totally unreasonable.

Are you referring to transitions to/from kernel space? If so, wouldn't the
write
on the pipe and the call to poll both result in transitions?

Regards,
Iker


----- Original Message -----
From: "David Schwartz" <davids@webmaster.com>
To: "Iker" <iker@computer.org>; <linux-kernel@vger.kernel.org>
Sent: Friday, September 12, 2003 10:04 PM
Subject: [lkml] RE: self piping and context switching


>
> > Assume a thread is monitoring a set of fd's which include both ends of
> > a pipe (using poll, for example). If the thread writes to the pipe (in
> > order to notify itself for whatever reason) is it reasonable to expect
> > that it will be able to return to its poll loop and get the event
> > without a context switch? (provided it quickly returns to the poll
> > loop).
>
> It's reasonable to expect that this will be the most common case and the
> one to optimize. It is unreasonable to fail if this doesn't happen, since
> it's not guaranteed to happen. Note that if by "without a context switch"
> you really mean without another thread getting a chance to run, then it is
> totally unreasonable. On SMP systems and with hyper-threading, threads can
> run concurrently.
>
> DS
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

