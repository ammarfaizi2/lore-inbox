Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTAGWEQ>; Tue, 7 Jan 2003 17:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTAGWEP>; Tue, 7 Jan 2003 17:04:15 -0500
Received: from robur.slu.se ([130.238.98.12]:4109 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267505AbTAGWEP>;
	Tue, 7 Jan 2003 17:04:15 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15899.21204.884559.523678@robur.slu.se>
Date: Tue, 7 Jan 2003 23:21:08 +0100
To: Steffen Persvold <sp@scali.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steffen Persvold writes:

 > True, but it doesn't say that if you have two applications loaded on 
 > a SMP box, one which is for example constantly receiving and sending data 
 > from/to the network and doing computations on the data (100 % CPU) while 
 > some other app is only doing computations (also 100 % CPU), the ksoftirqd 
 > which should receive packets and refill the TX and RX rings will be put 
 > last in the queue because of its low nice level (19), thus the network 
 > dependent application has very much lower performance than what could be 
 > achieved with a nice level of 0 or even running the interrupt based 
 > mechanism. A nice level of 0 on ksoftirqd is still a heck of a lot better 
 > than interrupt context isn't it ?


 Yes my scripts test/production has even been setting -19 to ksoftirq just
 for that reason so I almost forgot this issue so I'm happy you brought
 this up. But dev->poll is not the only user of ksoftirq but for heavy
 networking it's gets pretty dominant. So we add something to NAPI_HOWTO 
 and pass the question about ksoftirq default priority to others.

>From a GIGE router in production.

USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
root         3  0.2  0.0     0     0  ?  RWN Aug 15 602:00 (ksoftirqd_CPU0)
root       232  0.0  7.9 41400 40884  ?  S   Aug 15  74:12 gated 

Cheers.
						--ro
