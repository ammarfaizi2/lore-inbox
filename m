Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268923AbRG0SFA>; Fri, 27 Jul 2001 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbRG0SEu>; Fri, 27 Jul 2001 14:04:50 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:21517 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268917AbRG0SEi>;
	Fri, 27 Jul 2001 14:04:38 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271804.WAA22016@ms2.inr.ac.ru>
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 27 Jul 2001 22:04:13 +0400 (MSK DST)
Cc: samudrala@us.ibm.com, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, lartc@mailman.ds9a.nl,
        diffserv-general@lists.sourceforge.net, rusty@rustcorp.com.au
In-Reply-To: <E15QBMf-00066p-00@the-village.bc.nu> from "Alan Cox" at Jul 27, 1 06:25:29 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> How is this different from having a single userspace thread in your
> application which accepts connections as they come in and then hands them
> out in an order it chooses, if need be erorring and closing some ?

Seems, I can answer. Because closing some would break the service.

The idea is that when kernel accept queue is full we stop to
move open requests to established state and hence spurious
aborts are not generated. So, accepting cannot be artificially
speed up and extension of accept queue to user space is impossible.
The similar problem was open with TUX, which relays requests
to slow path. I do not know how Ingo solved it, by the way,
but it looked terrible: either massive socket leak (no limit on accept queue)
or massive aborts. :-)


Another question to author: missing prioritization of drops.
"Low priority" connections will clog accept queue, so that no room
for high priority connections remains. It is not good.
Any scheme with priority reserves some room for each high priority band
or does dropping based on priority.

Alexey
