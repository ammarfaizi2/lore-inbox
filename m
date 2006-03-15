Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWCOOkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWCOOkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCOOkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:40:36 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:8628 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932322AbWCOOkg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:40:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lvTh+0xjGOsx30ZNcJt2O8IbnvlYWi1ah5hee1S0zb3tCDeCaq63FlHIZ6/86M6q+BRNgkBqj4JHcbuiw/xtmvnyy3kn2WXf20I9+9MGoqeBPITfrpTlGv8f3hpRON+DGKH2r+HjHOhqBsn51o8MWo54Yi65MGFNX9OGvZLCR/o=
Message-ID: <3f250c710603150640y95617e3sfa7c8f8db005290b@mail.gmail.com>
Date: Wed, 15 Mar 2006 10:40:34 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: Jiffy is not able to measure the fraction of time a process runs a processor
Cc: linux-kernel <linux-kernel@vger.kernel.org>, craig.lkml@gmail.com
In-Reply-To: <y0mveugagsm.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3f250c710603130549w6ccdf14cu73a0d7d2999fd4ee@mail.gmail.com>
	 <y0mveugagsm.fsf@ton.toronto.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have managed to measure the cpu time in nanoseconds. On i386 I have used
the monotonic_clock() to measure the cpu time accurately.

The cpu time measurements were based on t->sched_info.cpu_time, but
instead of accumulate
the all cpu time, I needed just the diff=jiffies
-t->sched_info.last_arrival in the sched_info_depart().

The problem was most of time the diff was zero. So to solve this
problem I used the monotonic_clock() function that provides more accurate
way to measure cpu time.

Any comments?

On 14 Mar 2006 15:54:17 -0500, Frank Ch. Eigler <fche@redhat.com> wrote:
> "Mauricio Lin" <mauriciolin@gmail.com> writes:
>
> >  I am trying to measure the fraction of time a process runs on a
> > processor, but the jiffies is not able to provide an accurate value.
>
> See sched_clock().

I have checked it. It helped me to reach the monotonic_clock()
function after hacking the code.

>
> >  The example below [...]
> > PID  : NAME : LAST ARRIVAL : CPU TIME : CALLER
> > 4544 : kmix : 6170433 : 0 : work_resched+0x6c
> > 4078 : lpd : 6170433 : 0 : __down_interruptible+0x5
> > 4544 : kmix : 6170433 : 0 : schedule_timeout+0xb8
>
> What tool/patchset are you using to generate this trace?

I am using the relayfs to report the information I need among the
processors. I just put some klog in some key points in the code.

BR,

Mauricio Lin.
