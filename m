Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313984AbSDQAdZ>; Tue, 16 Apr 2002 20:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313985AbSDQAdY>; Tue, 16 Apr 2002 20:33:24 -0400
Received: from fmr01.intel.com ([192.55.52.18]:62914 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S313984AbSDQAdX>;
	Tue, 16 Apr 2002 20:33:23 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB913D03D4C@FMSMSX38>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>, davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Why HZ on i386 is 100 ?
Date: Tue, 16 Apr 2002 17:33:06 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you change HZ to 1000, you need to change PROC_CHANGE_PENALTY
accordingly.  Otherwise, process would get preempted before its time slice
gets expired.  The net effect is more context switch than necessary, which
could explain the 10% difference.


-----Original Message-----
From: Davide Libenzi [mailto:davidel@xmailserver.org]
Sent: Tuesday, April 16, 2002 11:10 AM
To: davidm@hpl.hp.com
Cc: Linus Torvalds; Linux Kernel Mailing List
Subject: Re: Why HZ on i386 is 100 ?


On Tue, 16 Apr 2002, David Mosberger wrote:

> >>>>> On Tue, 16 Apr 2002 10:18:18 -0700 (PDT), Davide Libenzi
<davidel@xmailserver.org> said:
>
>   Davide> i still have pieces of paper on my desk about tests done on
>   Davide> my dual piii where by hacking HZ to 1000 the kernel build
>   Davide> time went from an average of 2min:30sec to an average
>   Davide> 2min:43sec. that is pretty close to 10%
>
> Did you keep the timeslice roughly constant?

it was 2.5.1 time and it was still ruled by TICK_SCALE that made the
timeslice to drop from 60ms ( 100HZ ) to 21ms ( 1000HZ ).




- Davide


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
