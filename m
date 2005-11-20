Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVKTKjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVKTKjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKTKjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:39:19 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:60900 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751205AbVKTKjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:39:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
Date: Sun, 20 Nov 2005 21:39:00 +1100
User-Agent: KMail/1.8.3
Cc: Marcel Zalmanovici <MARCEL@il.ibm.com>, linux-kernel@vger.kernel.org
References: <OF5AC87F24.6CC16082-ONC22570BF.00387722-C22570BF.0038A482@il.ibm.com> <200511202128.13308.kernel@kolivas.org> <20051120103536.GB12997@granada.merseine.nu>
In-Reply-To: <20051120103536.GB12997@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202139.01299.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 21:35, Muli Ben-Yehuda wrote:
> On Sun, Nov 20, 2005 at 09:28:13PM +1100, Con Kolivas wrote:
> > Ok I've had a look at the actual program now ;) Are you timing the time
> > it takes to completion of everything?
> >
> > This part of your program:
> > 	for (i= 0; i<8; i++)
> > 		pthread_join(tid[i], NULL);
> >
> > Cares about the order the threads finish. Do you think this might be
> > affecting your results?
>
> I don't see why it should matter. Depending on the order the threads
> finish, we will always wait in pthread_join until the last one
> finishes, and then do between 0 and 7 more pthread_joins that should
> return immediately (since the last one has already finished).

If it was instant it shouldn't matter. I'm aware of that in theory, but there 
have certainly been reports of pthread_join taking quite a while happening in 
a sort of lazy/sloppy way. I don't know why this is the case but I wondered 
if it was showing up here. 

Cheers,
Con
