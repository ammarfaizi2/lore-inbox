Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTJ3XgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTJ3XgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:36:24 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48557 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263015AbTJ3XgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:36:22 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 30 Oct 2003 15:36:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.56.0310301534330.1136@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
 <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Ben Mansell wrote:

> On Thu, 30 Oct 2003, Ben Mansell wrote:
>
> > On Wed, 29 Oct 2003, Davide Libenzi wrote:
> >
> > > Can you try the patch below and show me a dmesg when this happen?
> >
> > Ok, patch applied. (I changed DEBUG_EPOLL to 10 however, otherwise
> > nothing would be printed). Now, epoll appears to behave perfectly and I
> > can't re-create the problem :(
>
> Got it! I was missing the problem because I had removed some debug
> messages in my own code. Here's another run, this time the
> final epoll_wait() call of the child process brings back 2 events:
>  Event 0 fd: 7 events: 17
>  Event 1 fd: -2095926561 events: 0
>
> I've added the debug to the end of this message.
>
> If I modify the code so there are several 'child' processes, all
> monitoring the same sockets with their own epolls, they all seem to get
> the same results from epoll_wait().
>
> > > Also, it shouldn't change a whit, but are you able to try on a x86 UP?
>
> On a UP x86, 2.6.0-test9, I can't reproduce the problem at all.

Could you try to poison the event buffer before an epoll_wait() to see how
many bytes are effectively written by the function?

	memset(events, 'e', num * sizeof(epoll_event));




- Davide

