Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288753AbSANEsX>; Sun, 13 Jan 2002 23:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288760AbSANEsN>; Sun, 13 Jan 2002 23:48:13 -0500
Received: from mnh-1-02.mv.com ([207.22.10.34]:10765 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288753AbSANEr7>;
	Sun, 13 Jan 2002 23:47:59 -0500
Message-Id: <200201140449.XAA06402@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: The O(1) scheduler breaks UML 
In-Reply-To: Your message of "Sun, 13 Jan 2002 18:55:35 PST."
             <Pine.LNX.4.40.0201131853550.937-100000@blue1.dev.mcafeelabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Jan 2002 23:49:16 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidel@xmailserver.org said:
> Yes, this should work :
>     if (likely(prev != next)) {
>         rq->nr_switches++;
>         rq->curr = next;
>         next->cpu = prev->cpu;
>         spin_unlock_irq(&rq->lock);
>         context_switch(prev, next);
>     } else
>         spin_unlock_irq(&rq->lock);
> and there's no need for barrier() and rq reload in this way.

Yup, UML works much better with that.

			Jeff

