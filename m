Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTGHPF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTGHPF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:05:26 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:18820 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263295AbTGHPFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:05:21 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 08:12:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Con Kolivas <kernel@kolivas.org>
cc: Szonyi Calin <sony@etc.utt.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
In-Reply-To: <200307081759.39215.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.55.0307080806400.4544@bigblue.dev.mcafeelabs.com>
References: <200307070317.11246.kernel@kolivas.org>
 <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
 <Pine.LNX.4.55.0307080007200.3648@bigblue.dev.mcafeelabs.com>
 <200307081759.39215.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Con Kolivas wrote:

> On Tue, 8 Jul 2003 17:46, Davide Libenzi wrote:
> > On Tue, 8 Jul 2003, Szonyi Calin wrote:
> > > In the weekend i did some experiments with the defines in kernel/sched.c
> > > It seems that changing in MAX_TIMESLICE the "200" to "100" or even "50"
> > > helps a little bit. (i was able to do a make bzImage and watch a movie
> > > without noticing that is a kernel compile in background)
> >
> > I bet it helps. Something around 100-120 should be fine. Now we need an
> > exponential function of the priority to assign timeslices to try to
> > maintain interactivity. This should work :
>
> This is still decreasing the timeslices. Whether you do it linearly or
> exponentially the timeslices are smaller, which just about everyone will
> resist you doing.

Maybe you (and this Mr Everyone) might be interested in knowing that the
interactivity is not given by the absolute length of the timeslice but by
the ratio between timeslices. If you have three processes running with
timeslices :

A = 400
B = 200
C = 100

the interactivity is the same of the one if you have :

A = 100
B = 50
C = 25

What changes is the maxiomum CPU blackout time that each task has to see
before re-emerging again from the expired array. In the first case in
"only" 700ms while in the first case is 175ms.



- Davide

