Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTAGXza>; Tue, 7 Jan 2003 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAGXza>; Tue, 7 Jan 2003 18:55:30 -0500
Received: from elin.scali.no ([62.70.89.10]:46608 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267609AbTAGXz3>;
	Tue, 7 Jan 2003 18:55:29 -0500
Date: Wed, 8 Jan 2003 01:07:19 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <15899.21204.884559.523678@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0301080059060.1128-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Robert Olsson wrote:

> 
> Steffen Persvold writes:
> 
>  > True, but it doesn't say that if you have two applications loaded on 
>  > a SMP box, one which is for example constantly receiving and sending data 
>  > from/to the network and doing computations on the data (100 % CPU) while 
>  > some other app is only doing computations (also 100 % CPU), the ksoftirqd 
>  > which should receive packets and refill the TX and RX rings will be put 
>  > last in the queue because of its low nice level (19), thus the network 
>  > dependent application has very much lower performance than what could be 
>  > achieved with a nice level of 0 or even running the interrupt based 
>  > mechanism. A nice level of 0 on ksoftirqd is still a heck of a lot better 
>  > than interrupt context isn't it ?
> 
> 
>  Yes my scripts test/production has even been setting -19 to ksoftirq just
>  for that reason so I almost forgot this issue so I'm happy you brought
>  this up. But dev->poll is not the only user of ksoftirq but for heavy
>  networking it's gets pretty dominant. So we add something to NAPI_HOWTO 
>  and pass the question about ksoftirq default priority to others.
> 
> >From a GIGE router in production.
> 
> USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
> root         3  0.2  0.0     0     0  ?  RWN Aug 15 602:00 (ksoftirqd_CPU0)
> root       232  0.0  7.9 41400 40884  ?  S   Aug 15  74:12 gated 
> 

I'm happy that atleast someone can agree on something these days, looking 
at the latest discussions regarding binary only drivers and GPL could make 
one think that all that kernel developers do is to argue about who is 
right (allright, most of the quarrelsome people arent't really kernel 
developers) ;) So, who takes the decission regarding the ksoftirqd and 
when ?


Best regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

