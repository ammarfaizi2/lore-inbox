Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWCNWu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWCNWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCNWu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:50:58 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:1167 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751299AbWCNWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:50:57 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
Date: Wed, 15 Mar 2006 09:50:40 +1100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
References: <200603131906.11739.kernel@kolivas.org> <200603150926.52064.kernel@kolivas.org> <44174791.7090905@bigpond.net.au>
In-Reply-To: <44174791.7090905@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603150950.40677.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 09:45, Peter Williams wrote:
> Con Kolivas wrote:
> > I haven't checked but gcc may well inline weighted_cpuload anyway?
>
> It may be doing so for internal uses inside sched.c but I'm pretty sure
> that it won't for external calls.

Hmm I investigated briefly and only C99 inlining (whatever that means) will 
allow me to locally inline and export as well. It would do so if I specified 
-finline-functions which is not our default at all in the kernel (we only 
recently disable -fnoinline-functions I believe). Anyway checking positively 
shows me this on gcc 4.1.0:

0xc0111283 <find_busiest_queue+83>:     call   0xc0110dc0 <weighted_cpuload>

So no, it doesn't get inlined.

> > The way you're suggesting adds a function that is never used by anything
> > but swap prefetch which would then need to be 'ifdef'ed out to not be
> > needlessly built on every system. Adding ifdefs is frowned upon already,
> > and to have an mm/ specific ifdef in sched.c would be rather ugly.
>
> Sometimes ugliness is the best option.

I spent quite some time trying to find the least cost way to do this without 
uglifying code. I don't feel strongly about just how to do it though. 
Comments from Andrew and Ingo would be most welcome on this matter.

Cheers,
Con
