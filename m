Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVKTKvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKTKvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKTKvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:51:07 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:57046 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751215AbVKTKvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:51:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
Date: Sun, 20 Nov 2005 21:50:49 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>
References: <OFADF30D19.6C548DAE-ONC22570BF.003B5172-C22570BF.003B9597@il.ibm.com>
In-Reply-To: <OFADF30D19.6C548DAE-ONC22570BF.003B5172-C22570BF.003B9597@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202150.49702.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 21:50, Marcel Zalmanovici wrote:
> On Sun, 20 Nov 2005 21:35, Muli Ben-Yehuda wrote:
> > On Sun, Nov 20, 2005 at 09:28:13PM +1100, Con Kolivas wrote:
> > > Ok I've had a look at the actual program now ;) Are you timing the time
> > > it takes to completion of everything?
> > >
> > > This part of your program:
> > >          for (i= 0; i<8; i++)
> > >                      pthread_join(tid[i], NULL);
> > >
> > > Cares about the order the threads finish. Do you think this might be
> > > affecting your results?
> >
> > I don't see why it should matter. Depending on the order the threads
> > finish, we will always wait in pthread_join until the last one
> > finishes, and then do between 0 and 7 more pthread_joins that should
> > return immediately (since the last one has already finished).
>
> If it was instant it shouldn't matter. I'm aware of that in theory, but
> there
> have certainly been reports of pthread_join taking quite a while happening
> in
> a sort of lazy/sloppy way. I don't know why this is the case but I wondered
>
> if it was showing up here.
>
> I've looked through the detailed run results and found this:
>
> Thread DS 0, TID = 7646
> Thread DS 0, TID = 7645
> Thread DS 1, TID = 7648
> Thread DS 1, TID = 7650
> Thread DS 2, TID = 7651
> Thread DS 2, TID = 7652
> Thread DS 3, TID = 7653
> Thread DS 3, TID = 7654
> Main exit ...
> real 23.25
>
> As you can see except the first 2 threads all finished in order they were
> created. With the average being at about 16.5 this is a high result and
> thread order was almost ideal.

Ok, but how long does pthread_join actually take to complete?

Cheers,
Con

P.S. Lotus notes is terrible for a mailer isn't it?
