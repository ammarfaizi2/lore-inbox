Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269111AbRG3Wq1>; Mon, 30 Jul 2001 18:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269106AbRG3WqS>; Mon, 30 Jul 2001 18:46:18 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:15630 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269099AbRG3WqD>; Mon, 30 Jul 2001 18:46:03 -0400
Date: Mon, 30 Jul 2001 18:46:11 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Bizarre multithread open/close problem
In-Reply-To: <3B65CD09.000001.33392@be1.prserv.net>
Message-ID: <Pine.LNX.4.33.0107301844570.13779-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 isnkrnl@attglobal.net wrote:

> I'm not sure if this is a bug or not but my
> coworker has a wierd one.
>
> He has 2 threads, main and helper.
>
> main:
> f=open(/dev/brcmrec) does some work and then
>
> spawns helper:
>
> helper spins forever doing various ioctls, read
> and writes on f which was opened in main. Every
> time through it looks at a "amIDone" flag which is
> set by main.  pthreads are the threads.
>
> Then at some point main wants to end helper and
> close f.  Main sets "amIDone" which tells helper
> to terminate and then successfully closes f.
>
> Now here is the problem, our brcmrec driver has a
> close() function which isn't getting called when
> main does the close, at least not all of the
> time.
> We're beginning to think that if the helper thread
> is in the middle of an ioctl or something then the
> close works but it doesn't call the close on the
> driver.
>
>
> I don't even know what kind of help to ask for
> here, so feel free to poke at this any ways you
> like.  I guess the bothersome part is that we have
> a thread that doesn an open (did I mention it was
> an exclusive open?) and then spawns a thread and
> then does a close and we can't reopen the device
> and the close part of our driver is never called.
>
> Any ideas or hints?
>
> thanks,
> Ian Nelson

What if you use a semaphore to prevent the parent from close()ing it until the
child is done?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


