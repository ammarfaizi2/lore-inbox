Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVKTKs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVKTKs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKTKs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:48:26 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:50170 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751210AbVKTKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:48:25 -0500
In-Reply-To: <200511202139.01299.kernel@kolivas.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OFADF30D19.6C548DAE-ONC22570BF.003B5172-C22570BF.003B9597@il.ibm.com>
From: Marcel Zalmanovici <MARCEL@il.ibm.com>
Date: Sun, 20 Nov 2005 12:50:49 +0200
X-MIMETrack: Serialize by Router on D12ML102/12/M/IBM(Release 6.5.1| March 5, 2004) at
 20/11/2005 12:48:24
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                                                   
                      Con Kolivas                                                                                                  
                      <kernel@kolivas.o        To:       Muli Ben-Yehuda <mulix@mulix.org>                                         
                      rg>                      cc:       Marcel Zalmanovici/Haifa/IBM@IBMIL, linux-kernel@vger.kernel.org          
                                               Subject:  Re: Inconsistent timing results of multithreaded program on an SMP        
                      20/11/2005 12:39          machine.                                                                           
                                                                                                                                   
                                                                                                                                   
                                                                                                                                   










On Sun, 20 Nov 2005 21:35, Muli Ben-Yehuda wrote:
> On Sun, Nov 20, 2005 at 09:28:13PM +1100, Con Kolivas wrote:
> > Ok I've had a look at the actual program now ;) Are you timing the time
> > it takes to completion of everything?
> >
> > This part of your program:
> >          for (i= 0; i<8; i++)
> >                      pthread_join(tid[i], NULL);
> >
> > Cares about the order the threads finish. Do you think this might be
> > affecting your results?
>
> I don't see why it should matter. Depending on the order the threads
> finish, we will always wait in pthread_join until the last one
> finishes, and then do between 0 and 7 more pthread_joins that should
> return immediately (since the last one has already finished).

If it was instant it shouldn't matter. I'm aware of that in theory, but
there
have certainly been reports of pthread_join taking quite a while happening
in
a sort of lazy/sloppy way. I don't know why this is the case but I wondered

if it was showing up here.

I've looked through the detailed run results and found this:

Thread DS 0, TID = 7646
Thread DS 0, TID = 7645
Thread DS 1, TID = 7648
Thread DS 1, TID = 7650
Thread DS 2, TID = 7651
Thread DS 2, TID = 7652
Thread DS 3, TID = 7653
Thread DS 3, TID = 7654
Main exit ...
real 23.25

As you can see except the first 2 threads all finished in order they were
created. With the average being at about 16.5 this is a high result and
thread order was almost ideal.

Cheers,
Con


