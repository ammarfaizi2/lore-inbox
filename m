Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWCHBxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWCHBxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWCHBxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:53:05 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:60779 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751507AbWCHBxE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:53:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dsV/3E6YtiYtnB67GinJ7ltIisHq8CfqFAmYmmCLEYFRlrc7t1qUsX7Mz95xzMwWCtu8r7lpj5S6eX5pdOJBGa5Zhmdk95eAFNyrmuYC7sywkZGS77wys2SQr8Jp3m4tbx6XfHt0NXUfz1hp+PCblhTGa5w4gDGfC/VmKcPuqC0=
Message-ID: <aec7e5c30603071753x6c6b413dj135d6589003d0229@mail.gmail.com>
Date: Wed, 8 Mar 2006 10:53:02 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: SMP and 101% cpu max?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
	 <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/7/06, Magnus Damm <magnus.damm@gmail.com> wrote:
> > Hi guys,
> >
> > I'm doing some memory related hacking, and part of that is testing the
> > current behaviour of the Linux VM. This testing involves running some
> > simple tests (building the linux kernel is one of the tests) while
> > varying the amount of RAM available to the kernel.
> >
> > I've tested memory configurations of 64MB, 128MB and 256MB on a Dual
> > PIII machine. The tested kernel is 2.6.16-rc5, and user space is based
> > on debian-3.1. I run 5 tests per memory configuration, and the machine
> > is rebooted between each test.
> >
> > Problem:
> >
> > With 128MB and 256MB configurations, a majority of the tests never
> > make it over 101% CPU usage when I run "make -j 2 bzImage", building a
> > allnoconfig kernel. With 64MB memory, everything seems to be working
> > as expected. Also, running "make bzImage" works as expected too.
> >
> Hmm, I wonder if it's related to the problem I reported here :
> http://lkml.org/lkml/2006/2/28/219
> Where I need to run make -j 5 or higher to load both cores of my Athlon X2.

Yeah, the problem looks kind of related. But I doubt it is the CPU
scheduler only that plays tricks on us, because in the my 64MB case
things seem to work ok at all times. But maybe it's just random.

I've spent this morning testing 2.6.15, and that version seems to work
ok. And just to double check I rebuilt and retested 2.6.16-rc5. This
round gives me the similar results - now it fails to go above 101% CPU
load in one case.

Results for "make -j 2 bzImage", 2.6.15:

time: 123.527 220.11 20.27, cpu: 195, ram: 126896, swap: 125944
time: 123.823 219.48 20.57, cpu: 194, ram: 126896, swap: 125944
time: 123.867 221.1 19.35, cpu: 194, ram: 126896, swap: 125944
time: 124.6 220.49 20.25, cpu: 193, ram: 126896, swap: 125944
time: 124.96 222.14 20.18, cpu: 194, ram: 126896, swap: 125944

Results for "make -j 2 bzImage", 2.6.16-rc5:

time: 125.045 220.02 18.71, cpu: 191, ram: 126876, swap: 125944
time: 125.052 221.93 18.35, cpu: 192, ram: 126876, swap: 125944
time: 125.598 220.16 19.34, cpu: 191, ram: 126876, swap: 125944
time: 125.7 220.07 19.32, cpu: 190, ram: 126876, swap: 125944
time: 229.316 212.86 17.72, cpu: 101, ram: 126876, swap: 125944

/ magnus
