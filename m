Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWEVGGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWEVGGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWEVGGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:06:32 -0400
Received: from bay117-f36.bay117.hotmail.com ([207.46.8.116]:30308 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932150AbWEVGGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:06:31 -0400
Message-ID: <BAY117-F36BE13D62A2687992A9540DD9A0@phx.gbl>
X-Originating-IP: [68.126.209.147]
X-Originating-Email: [talibalm@hotmail.com]
In-Reply-To: <200605201402.35875.mulyadi.santosa@gmail.com>
From: "Talib Alim" <talibalm@hotmail.com>
To: mulyadi.santosa@gmail.com, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: signal handling (clarification needed)
Date: Mon, 22 May 2006 06:06:27 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 May 2006 06:06:31.0308 (UTC) FILETIME=[DEFF4CC0:01C67D65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hello talib..
>
> > if (signal_pending)
> >   {
> >    return -EINTER
> >   }
>
>I think this is the problem. You return -EINTR no matter what signal is 
>currently pending. try to study next_signal() in kernel/signal.c, I think 
>by using this function, you can get the signal number of the
>pending signal(s), thus you can act accordingly.
>
I understand this is the problem, but I do not want to get in the business 
of handling signals in my driver. If I dequeue the signal, than It has to be 
resent (by my driver) when process is goes to user space, what if that 
signal has signal handler ? than I have to run that too.

As I mentioned earlier, accept also does same thing, i.e. it  returns on 
signal_pending true.

My point is what is the correct way of taking care of this situation, i.e. 
driver operating on behave of user process (in kernel context), how should 
suspend signal handled ? if I do not check for signal_pending, than ctrl-c 
will not work, and if e.g. read (or accept) does not get any data 
(connection) than this program will be struck in kernel mode.

I think I am missing some some point, I hope that somebody can help me 
understand this.

Talib Alim

>Since I am not sure if this function is exported, maybe you can use 
>dequeue_signal() instead (also defined in kernel/signal.c).
>
>Good luck...
>
>regards,
>
>Mulyadi

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

