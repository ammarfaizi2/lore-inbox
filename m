Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLUPR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTLUPR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:17:57 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:44162 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263488AbTLUPRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:17:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Dec 2003 07:17:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Jamie Lokier <jamie@shareable.org>, <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <Pine.LNX.4.44.0312210701330.12172-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0312210716220.12172-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003, Davide Libenzi wrote:

> On Sun, 21 Dec 2003, Manfred Spraul wrote:
> 
> > >What about killing fasync_helper altogether and using the method that
> > >epoll uses to register "listeners" which send a signal when the poll
> > >state of a device changes?
> > >
> > I think it would be a step in the wrong direction: poll should go away 
> > from a simple wake-up to an interface that transfers the band info 
> > (POLL_IN, POLL_OUT, etc). Right now at least two passes over the f_poll 
> > functions are necessary, because the info which event actually triggered 
> > is lost. kill_fasync transfers the band info, thus I don't want to 
> > remove it.
> 
> It is my plan to propose (Linus is not contrary, in principle) a change of 
> the poll/wake infrastructure for 2.7. There are two areas that can be 
> improved. First, f_op->poll() does not allow you to send and event mask, 

Sorry, poll_wait() does not allow you to specify an event mask ...



- Davide


