Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSKRWYT>; Mon, 18 Nov 2002 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265184AbSKRWXt>; Mon, 18 Nov 2002 17:23:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12278 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265140AbSKRWXL>;
	Mon, 18 Nov 2002 17:23:11 -0500
Message-ID: <3DD969B6.9D221DB1@mvista.com>
Date: Mon, 18 Nov 2002 14:29:10 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dipankar Sarma <dipankar@gamebox.net>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Run timers as softirqs, not tasklets
References: <Pine.LNX.4.44.0211172108160.12550-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 18 Nov 2002, Dipankar Sarma wrote:
> 
> > I wrote that part of smptimers to run the per-CPU lists from per-CPU
> > tasklets while porting Ingo's code to 2.5 and Ingo just included it. At
> > that time, it didn't seem necessary to use up a softirq vector when it
> > could be easily done using tasklets.
> 
> i think a separate timer softirq is justified, timers are important
> enough.
> 
>         Ingo
> 
So then, is there any reason to not put them ahead of
HI_SOFTIRQ?  I.e.:

 enum
 {
        TIMER_SOFTIRQ=0,
      	HI_SOFTIRQ
        NET_TX_SOFTIRQ,
        NET_RX_SOFTIRQ,
        SCSI_SOFTIRQ,
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
