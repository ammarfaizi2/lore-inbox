Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTDSUEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTDSUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:04:50 -0400
Received: from wotug.org ([194.106.52.201]:18760 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S263447AbTDSUEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:04:49 -0400
Message-Id: <5.2.0.9.0.20030419211356.024884a8@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 19 Apr 2003 21:16:41 +0100
To: root@chaos.analogic.com, Jeff Garzik <jgarzik@pobox.com>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: [TRIVIAL] kstrdup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0304181512220.22901@chaos>
References: <3EA0469D.7090602@pobox.com>
 <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
 <3EA02E55.80103@pobox.com>
 <Pine.LNX.4.53.0304181323400.22493@chaos>
 <3EA0469D.7090602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:29 18/04/2003, Richard B. Johnson wrote:
> > > A lot of persons who are unfamiliar with tools other than 'C' think
> > > that strcpy() is made like this:
> > >
> > >     while(*dsp++ = *src++)
> > >                    ;
> >
> > In fact, that's basically the kernel's non-arch-specific implementation :)
> >
> >       Jeff
>
>Yep. Naive code looks so 'simple', must be "optimum", no? ;^).


Well, actually on ARM at least it is optimal, given the likely short length 
of strings. To do any better at all you have to assume stringlength of many 
tens of words, which is unlikely. For comparison, this is what armcc 
produces for the above code:

                   strdup PROC
                   |L1.0|
000000  e4d12001          LDRB     a3,[a2],#1            ;1
000004  e4c02001          STRB     a3,[a1],#1            ;1
000008  e3520000          CMP      a3,#0                 ;1
00000c  1afffffb          BNE      |L1.0|                ;1
000010  e1a0f00e          MOV      pc,lr                 ;1


AFAICT there is no better solution.

Ruth

