Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUENKKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUENKKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbUENKKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:10:38 -0400
Received: from mailhost2.tudelft.nl ([130.161.180.2]:54717 "EHLO
	mailhost2.tudelft.nl") by vger.kernel.org with ESMTP
	id S264307AbUENKKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:10:37 -0400
Message-ID: <000601c439a3$f793af40$161b14ac@boromir>
From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
To: "Jakub Jelinek" <jakub@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
References: <000701c4399e$88a3aae0$161b14ac@boromir> <20040514095145.GC30909@devserv.devel.redhat.com>
Subject: Re: POSIX message queues should not allocate memory on send
Date: Fri, 14 May 2004 12:09:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 14, 2004 at 11:30:53AM +0100, Martijn Sipkema wrote:
> > The default mq_msgsize also seems a little large to me, but
> > I don't see why defaults are needed; if I understand the standard
> > correctly then creating a new message queue without mq_attr
> > should create an empty queue, which thus cannot be used to
> > pass messages.
>
> No idea where you found this.
>
> "If attr is NULL, the message queue shall be created with
> implementation-defined default message queue attributes."
>
> Empty queue means a message queue which has no messages in it, not
> that mq_msgsize and/or mq_maxmsg is 0.
> And mq_open with mq_msgsize 0 and/or mq_maxmsg 0 must fail (with EINVAL),
> so the implementation-defined defaults IMHO must be > 0 for both
> limits.
>
> "     The mq_open() function shall fail if:"
> ...
> "     [EINVAL]
>              O_CREAT was specified in oflag, the value of attr is not
NULL,
>      and either mq_maxmsg or mq_msgsize was less than or equal to zero."

You are correct; defaults are indeed needed. The current default value
for mq_msgsize seems rather large considering that mq_msgsize*mq_maxmsg
bytes will have to be allocated on queue creation. If variable sized large
payload messages are needed one might consider using shared memory in
combination with a message queue.

My main point was that mq_send()/mq_timedsend() may not return ENOMEM
and I am positive I did not misread the standard on that.

--ms




