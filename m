Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSEMQSN>; Mon, 13 May 2002 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEMQSM>; Mon, 13 May 2002 12:18:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29181 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314096AbSEMQSK>; Mon, 13 May 2002 12:18:10 -0400
Subject: Re: error : preempt_count 1
From: Robert Love <rml@tech9.net>
To: Oliver Kowalke <oliver.kowalke@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1779HB-01zk0WC@fwd06.sul.t-online.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 May 2002 09:18:07 -0700
Message-Id: <1021306688.18799.2564.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-12 at 23:25, Oliver Kowalke wrote:

> after shutdown (kernel 2.5.15) I've got :
> 
> erro: halt[8635] exited with preempt_count 1
> 
> What does it mean?

Absolutely nothing bad.  It is a debugging check to catch bad code that
does funny things with locks.  Ideally, every program should call unlock
for each instance it called lock - balancing everything out and giving a
preempt_count of zero.

Some code in the kernel, knowing it is shutting down, does not bother to
drop any held locks and subsequently you see that message.

Since it is triggering false positives, I will remove it eventually. 
For now it is incredibly useful for catching real problems.  And the
above, while harmless, could be fixed for "cleanliness" concerns.

	Robert Love

