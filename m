Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135529AbRARUqp>; Thu, 18 Jan 2001 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbRARUqf>; Thu, 18 Jan 2001 15:46:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:13075 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S135529AbRARUqX>;
	Thu, 18 Jan 2001 15:46:23 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101182030.XAA08626@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: raj@cup.hp.COM (Rick Jones)
Date: Thu, 18 Jan 2001 23:30:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <3A6733E0.6286A388@cup.hp.com> from "Rick Jones" at Jan 18, 1 09:45:03 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So if I understand  all this correctly...
> 
> The difference in ACK generation 

CORK does not affect receive direction and, hence, ACK geneartion.
The problem is that TCP does not know, when full request is received
and it must ack instantly at connection start and after some idle
period to allow client to open congestion window. Hence, it has to send
redundant ACKs.

Some control on this is possible only from level parsing requests,
i.e. from httpd in this case.

Actually, TUX-1.1 (Ingo, do I not lie, did you not kill this code?)
does this. It does not ack quickly, when complete request is received
and still not answered, so that all the redundant acks disappear.

This feature is still unaccessible from user level though.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
