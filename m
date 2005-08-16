Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVHPWYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVHPWYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVHPWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:24:40 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:18852 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751125AbVHPWYj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:24:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tiPQaWPsrHmalWwrTpIEsyjahUX9YvcnWP4h1fcJ2I26NFG3XWI+PpM1Y9+dR4xViCMlyfz+20/6kZtD26ETr52DYGxluyMIb7SiNVnu4MdQlKnOx0FtLiVC20xx5t6BL7zqYLRJOyM0iwQGxIpmpM0OMacHVkr4dshVoosimLQ=
Message-ID: <29495f1d0508161524260a856c@mail.gmail.com>
Date: Tue, 16 Aug 2005 15:24:34 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [rfc][patch] API for timer hooks
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43024ADA.8030508@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FDF744.2070205@aknet.ru>
	 <1124126354.8630.3.camel@cog.beaverton.ibm.com>
	 <43024ADA.8030508@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Stas Sergeev <stsp@aknet.ru> wrote:
> Hello.
> 
> john stultz wrote:
> > Interesting. Could you explain why the soft-timer interface doesn't<>
> > suffice?
> I'll try to explain why *I think*
> it doesn't suffice, please correct
> me if my assumptions are wrong.
> 
> There are two (bad) things about the
> PC-Speaker driver:
> 1. It needs the higher interrupt frequency.
> Since there seem to be no API to change
> the timer frequency at runtime, the driver
> does this itself. Now I have googled out
> the thread
> [PATCH] i386: Selectable Frequency of the Timer Interrupt
> but it doesn't look like it ended up
> with some patch applied, or where is it?

This thread resulted in CONFIG_HZ. You get to choose between 100, 250
or 1000. It was not meant to allow runtime HZ modifications.

> 2. It needs its handler to be executed
> first in the chain. Otherwise the quality
> is poor because of the latency.

Yeah, that's a tougher one :)

> My approach solves both problems by
> introducing the grabbing ability.
> This is a rather simple patch, and since
> it allows to do some cleanup, I though
> it could be usefull not only for the
> speaker driver.
> But if you can tell me how to achieve
> at least the point 1 (that is, speed up the
> timer at run-time quite arbitrary) without
> the kernel mods, then it would be a real
> salvation.

Does the dynamic-tick patch help you at all? I'm not sure if it's
meant to, admittedly. I'm also not sure if it has any cap on the
maximum HZ it attempts to reprogram the hardware to... Mucking with HZ
at run-time is going to break lots of stuff, though...well, not
necessarily, depends on how you muck with jiffies :)

Thanks,
Nish
