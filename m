Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVEQXuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVEQXuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVEQXs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:48:59 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:56975 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262034AbVEQXsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IpMBpdbMYA//OQIfJUg4nIdZ2naqlRGOtIBqtYa7uG71hhPY7+HZ42mjPl1PqEhiTdrK08xf43ZtnV2yIq/uw5S+DesdTgfRlFpC6hioG75nk2DrrC789crGidVjhh2a8Ub2Ir4mGGzvhuDSVwPMpgUEBHbkFPGKGrp6UZmL3UM=
Message-ID: <29495f1d0505171648455e6c1a@mail.gmail.com>
Date: Tue, 17 May 2005 16:48:15 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Cc: christoph <christoph@scalex86.org>, George Anzinger <george@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, shai@scalex86.org,
       akpm@osdl.org
In-Reply-To: <1116372341.32210.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	 <1116276689.28764.1.camel@mindpipe>
	 <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
	 <1116372341.32210.39.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-05-16 at 17:55 -0700, christoph wrote:
> >
> > Runtime? That seems to be a bad idea. It would be better to rewrite
> > the timer subsystem to be able to work tickless.
> >
> 
> I agree 100%, I think it's especially crazy to allow selecting 100, 250,
> 500, etc, whether at runtime or compile time.  Might as well just go
> tickless.
> 
> How do you expect application developers to handle not being able to
> count on the resolution of nanosleep()?  Currently they can at least
> assume 10ms on 2.4, 1ms on 2.6.  Seems to me that if you are no longer
> guaranteed to be able to sleep 5ms on 2.6, you would just have to
> busywait.  Is it me, or does that way lie madness?

>From my meager understanding of sys_nanosleep() in 2.6 -- we'd round
up currently, If you request a microsecond of sleep, we'll sleep for a
jiffy + 1 (or 2, maybe). I am not sure we want a syscall that allows
busy-waiting, but I'm not certain. If you're interesting, my patch
(just posted again to LKML) tries to divorce HZ and soft-timers
somewhat.

-Nish
