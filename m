Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTH1DRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 23:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTH1DRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 23:17:54 -0400
Received: from bosvwl02.itlinfosys.com ([216.52.49.36]:56581 "HELO
	bosvwl02.infosys.com") by vger.kernel.org with SMTP id S263481AbTH1DRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 23:17:52 -0400
Message-ID: <021901c36d13$b174bd90$edbccac6@itlpc5228>
Reply-To: "Tariq Firoz" <tariq_firoz@infosys.com>
From: "Tariq Firoz" <tariq_firoz@infosys.com>
To: "Andrew Morton" <akpm@osdl.org>, "Con Kolivas" <kernel@kolivas.org>
Cc: <warudkar@vsnl.net>, <linux-kernel@vger.kernel.org>
References: <200308272138.h7RLciK29987@webmail2.vsnl.net><200308272137.42632.kernel@kolivas.org> <20030827125310.15ebf8f9.akpm@osdl.org>
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Date: Thu, 28 Aug 2003 08:53:04 +0530
Organization: Infosys
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
x-mimeole: Produced By Microsoft MimeOLE V5.50.4910.0300
X-OriginalArrivalTime: 28 Aug 2003 03:19:24.0368 (UTC) FILETIME=[2E372D00:01C36D13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I faced a similar problem with 2.6.0-test4-mm2 while using unstable kde
3.1.9x(?)
In fact I was not able to do anything and my system became unresponsive,
with kswapd0
hogging 60% CPU. Later X got killed ... I did not face such a situation in
any of the previous
releases (I have been using 2.5 since 2.5.70 )

[ I have 256 MB RAM and 256 SWAP with P4 2.0 GHz]

Tariq Firoz


----- Original Message -----
From: "Andrew Morton" <akpm@osdl.org>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <warudkar@vsnl.net>; <linux-kernel@vger.kernel.org>
Sent: Thursday, August 28, 2003 1:23 AM
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!


> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > On Thu, 28 Aug 2003 07:38, warudkar@vsnl.net wrote:
> > > Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org,
Rational
> > > Rose and Konsole at a time. All of these take extremely long time to
> > > startup. (approx > 5 minutes). Kswapd hogs the CPU all the time. X
becomes
> > > unusable till all of them startup, although I can telnet and run top.
Same
> > > thing run under 2.4.18 starts up in 3 minutes, X stays usable and
kswapd
> > > never take more than 2% CPU.
> >
> > Yes I can reproduce this with a memory heavy load as well on low memory
> > (linking at the end of a big kernel compile is standard problem).
>
> It could be that recent changes to page reclaim which improve I/O
> scheduling have exacerbated this.
>
> Does this make a difference?
>
> diff -puN mm/vmscan.c~a mm/vmscan.c
> --- 25/mm/vmscan.c~a Wed Aug 27 12:51:36 2003
> +++ 25-akpm/mm/vmscan.c Wed Aug 27 12:51:48 2003
> @@ -360,8 +360,6 @@ shrink_list(struct list_head *page_list,
>   * See swapfile.c:page_queue_congested().
>   */
>   if (PageDirty(page)) {
> - if (referenced)
> - goto keep_locked;
>   if (!is_page_cache_freeable(page))
>   goto keep_locked;
>   if (!mapping)
>
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

