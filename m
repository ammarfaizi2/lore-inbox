Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDHRVt>; Sun, 8 Apr 2001 13:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDHRVj>; Sun, 8 Apr 2001 13:21:39 -0400
Received: from colorfullife.com ([216.156.138.34]:10000 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132574AbRDHRVX>;
	Sun, 8 Apr 2001 13:21:23 -0400
Message-ID: <001301c0c050$69f69be0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200104081658.UAA15180@ms2.inr.ac.ru>
Subject: Re: softirq buggy [Re: Serial port latency]
Date: Sun, 8 Apr 2001 19:21:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <kuznet@ms2.inr.ac.ru>
> Hello!
>
> > + if (softirq_active(smp_processor_id()) &
softirq_mask(smp_processor_id())) {
> > + do_softirq();
> > + return 0;
>
> BTW you may delete do_softirq()... schedule() will call this.
>

But with a huge overhead. I'd prefer to call it directly from within the
idle functions, the overhead of schedule is IMHO too high.

>
> > + *
> > + * Isn't this identical to default_idle with the 'no-hlt' boot
> > + * option? <manfred@colorfullife.com>
>
> Seeems, it is not. need_resched=-1 avoids useless IPIs.
>
I already wondered why need_resched is set to -1 ;-)

I'll remove that comment and repost the patch.

--
    Manfred

