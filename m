Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282808AbRK0Gt3>; Tue, 27 Nov 2001 01:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRK0GtT>; Tue, 27 Nov 2001 01:49:19 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:27912 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282808AbRK0GtG>; Tue, 27 Nov 2001 01:49:06 -0500
Message-Id: <5.0.2.1.2.20011127014025.009e8c90@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 27 Nov 2001 01:50:25 -0500
To: <mingo@elte.hu>
From: Linux maillist account <l-k@mindspring.com>
Subject: Re: a nohup-like interface to cpu affinity
Cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111270921020.3061-100000@localhost.localdom
 ain>
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:26 AM 11/27/01 +0100, Ingo Molnar wrote:
>On Mon, 26 Nov 2001, Linux maillist account wrote:
> > A nohup-like interface to the cpu affinity service would be useful.  It
> > could work like the following example:
> >
> >     $ cpuselect -c 1,3-5 gcc -c module.c
>
>yep, this can be done via the chaff utility i posted:
>         gcc -c module.c & ./chaff $! 0x6


This of course is subject to a race -- the chaff may not execute before the 
gcc has spun off a child or two.

>or, it can be done by changing the affinity of the current shell, every
>new child process will inherit it:
>
>         ./chaff $$ 0x6; gcc -c module.c


I like this one *much* better, it is functionally equivalant to  cpuselect, 
if one puts parens
around the whole thing to keep  chaff from infecting with a bias subsequent 
commands.

It ideal solution might be to add nohup-like capability to the existing 
chaff command:

        ./chaff 0x6 $$ 1234 43213 ... lots of other pids ...  (note my 
proposed reversal of pid & bias)
        ./chaff 0x6 -c gcc -c module.c

Joe

