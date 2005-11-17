Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVKQTRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVKQTRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVKQTRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:17:51 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:3032 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964776AbVKQTRu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:17:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hfdWQX06f/CBucjrHBum/OwNciMd4Vamz0VG5ccE/xyHmrWcccFoZrfLRAl4eNGqFtlaI1+QDkq0+8WkD903y7fhEWb9yIYeUF4/xvLQTB0R+moZx/khzxIIJgc46deO+vaLO4WQi5YsK6V2LjntSUuHayJrrEmx7ShMBEytEF4=
Message-ID: <29495f1d0511171117veebf091ja2277a73ec40af2f@mail.gmail.com>
Date: Thu, 17 Nov 2005 11:17:48 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Dag Nygren <dag@newtech.fi>
Subject: Re: nanosleep with small value
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051117191119.15126.qmail@dag.newtech.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <nish.aravamudan@gmail.com>
	 <29495f1d0511171051q6088099drfe094817a01668e4@mail.gmail.com>
	 <20051117191119.15126.qmail@dag.newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:
> > On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:
>
> > > The man page for nanosleep saya that times under 2 us are implemented
> > > by a busywait and  this is why I expected it to work.
> >
> > Update your manpages. You're depending on 2.4 behavior in a 2.6 kernel.
>
> You are right. The system is one I have upgraded piece by piece and the
> manpages
> weren't upgraded.

No problem.

> But what is the point of having a nanosleep() in that case when you could do
> just fine with usleep() ?

Check the usleep() manpage:

This function is obsolete. Use nanosleep(2) or setitimer(2) instead.

And in any case, I think usleep() just ends up calling nanosleep()?
It's not a sys-call in an of itself, like sys_nanosleep().

> > > OK, in that case the manpage should be changed. And an alternative
> > > has to be worked out by me ;-).
> >
> > My man-pages are quite clear on what nanosleep() does. Nothing needs
> > to be changed there.
> >
> > Alternative wise, I'm not sure, but you might want to look into the
> > HRT stuff that's going on in Ingo's -RT tree. I don't know if / what
> > changes have been made to sys_nanosleep(), but low-latency is most
> > likely to occur there.
>
> I will look into that.
> Quite annoying that software that worked just fine in 2.4 doesn't
> work in 2.6.

Well, your general resolution also was improved quite a bit in 2.6
(HZ=1000 vs. HZ=100 is a 10-fold improvement). But I agree, is a big
difference if you depend on that udelay() functionality -- but it was
a delay of up to 2 milliseconds, which is generally frowned upon in
the kernel.

> What does POSIX say about nanosleep()?

Not sure, but I think the only requirement is that we don't return
early (i.e. request 2 milliseconds, return in 1 millisecond).

Thanks,
Nish
