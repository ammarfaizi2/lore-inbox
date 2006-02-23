Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWBWVG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWBWVG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWBWVGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:06:55 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:30245 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbWBWVGx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:06:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkPUk8uyKJETtprOh5r3U6P5QarvVObB3nvcutvHH7ghkeMmW9MJy13q6Azfhsgeo2HRqKEUrAVhUeLMdynb8eB7nac0PUHM/vm34gAzMLc/fTjxfrv1V4TLg2GOXvpXoJfrTb8T8+FhpiQ1gBt9yLKAQCdqP/YwtdNnEFRdqPQ=
Message-ID: <29495f1d0602231306o55d759d5v9600b070a4b485e3@mail.gmail.com>
Date: Thu, 23 Feb 2006 13:06:52 -0800
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Cc: "Gautam H Thaker" <gthaker@atl.lmco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060223205851.GA24321@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Gautam H Thaker <gthaker@atl.lmco.com> wrote:
>
> > ::::::::::::::
> > top:  2.6.15-rt15-smp.out   # REAL_TIME KERNEL
> > ::::::::::::::
>
> >  2906 root     -66   0 18624 2244 1480 S 41.4  0.1  27:11.21 nalive.p
> >     6 root     -91   0     0    0    0 S 32.3  0.0  21:04.53 softirq-net-rx/
> >  1379 root     -40  -5     0    0    0 S 14.5  0.0   9:54.76 IRQ 23
>
> One effect of the -rt kernel is that it shows IRQ load explicitly -
> while the stock kernel can 'hide' it because there interrupts run
> 'atomically', making it hard to measure the true system overhead. The
> -rt kernel will likely show more overhead, but i'd not expect this
> amount of overhead.
>
> To figure out the true overhead of both kernels, could you try the
> attached loop_print_thread.c code, and run it on: an idle non-rt kernel,
> and idle -rt kernel, a busy non-rt kernel and a busy -rt kernel, and
> send me the typical/average loops/sec value you are getting?
>
> Furthermore, there have been some tasklet related fixes in 2.6.15-rt17,
> which maybe could improve this workload. Maybe ...

Would it make more sense to compare 2.6.15 and 2.6.15-rt17, as opposed
to 2.6.12-1.1390_FC4 and 2.6.15-rt17? Seems like the closer the two
kernels are, the easier it will be to isolate the differences.

Thanks,
Nish
