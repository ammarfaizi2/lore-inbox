Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264518AbUENJbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbUENJbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUENJbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:31:45 -0400
Received: from mailhost2.tudelft.nl ([130.161.180.2]:55536 "EHLO
	mailhost2.tudelft.nl") by vger.kernel.org with ESMTP
	id S264518AbUENJbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:31:43 -0400
Message-ID: <000701c4399e$88a3aae0$161b14ac@boromir>
From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: POSIX message queues should not allocate memory on send
Date: Fri, 14 May 2004 11:30:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with the current POSIX message queue
implementation. mq_send()/mq_timedsend() may not return
ENOMEM and this means memory for mq_maxmsg*mq_msgsize
will have to be allocated on queue creation. I think POSIX MSG
message passing being part of the REALTIME extensions this
makes sense. I've already mentioned this once to the implementors
of the current implementation, but they did not agree with my
reading of the standard.

The default mq_msgsize also seems a little large to me, but
I don't see why defaults are needed; if I understand the standard
correctly then creating a new message queue without mq_attr
should create an empty queue, which thus cannot be used to
pass messages.

--ms




