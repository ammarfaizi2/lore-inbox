Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSEUTlW>; Tue, 21 May 2002 15:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316516AbSEUTlV>; Tue, 21 May 2002 15:41:21 -0400
Received: from [66.105.142.142] ([66.105.142.142]:9478 "EHLO
	exchange1.FalconStor.Net") by vger.kernel.org with ESMTP
	id <S315472AbSEUTlU>; Tue, 21 May 2002 15:41:20 -0400
Message-ID: <E79B8AB303080F4096068F046CD1D89B934D5E@exchange1.FalconStor.Net>
From: Ron Niles <Ron.Niles@falconstor.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Oops from local semaphore race condition 
Date: Tue, 21 May 2002 15:41:19 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ron.Niles@falconstor.com said:
>> Then I realized it can possibly go corrupt, due to a race condition
>> which lets down() continue before up() is complete:

From: David Woodhouse [mailto:dwmw2@infradead.org]

>This is what completions were added for.

Thanks, struct completion is the best way; it's gonna be tough to maintain
backward compatibility though.

One comment; it looks like the implementation in sched.c should more
properly be using wq_write_lock_irqsave on the lock.

