Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263383AbTDCNEF>; Thu, 3 Apr 2003 08:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTDCNEE>; Thu, 3 Apr 2003 08:04:04 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:44804 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263383AbTDCNED>; Thu, 3 Apr 2003 08:04:03 -0500
Message-Id: <200304031305.h33D5Lu15735@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Herbert Rosmanith <herp@wildsau.idv.uni.linz.at>
Subject: Re: linux->real mode-> boot other OS in protected mode
Date: Thu, 3 Apr 2003 15:01:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: kasperd@daimi.au.dk, kernel@wildsau.idv.uni.linz.at,
       linux-kernel@vger.kernel.org, root@chaos.analogic.com
References: <200303260807.h2Q87O4l024956@wildsau.idv.uni.linz.at>
In-Reply-To: <200303260807.h2Q87O4l024956@wildsau.idv.uni.linz.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 March 2003 10:07, Herbert Rosmanith wrote:
> > > I boot Linux via BIOS, then boot DOS via LINUX
> > > when I boot linux again via LINLD, the "Uncompressing Linux ..."
> > > takes a lot longer as compared to doing a LINLD from a DOS which
> > > was booted by BIOS. I think this has something to do with
> > > switching.... oh! I know .... machine_real_start() from linux
> > > turns off the cache, so this could be the reason. Ok, so I'll
> > > check this out by chaning CR0.
> >
> > It is utterly strange that you can boot DOS from Linux at all.
>
> well, not really.
>
> machine_real_start() from process.c switches into 16 bit mode. you
> can pass arbitrary code to that function. this code has to:
> reset some hardware ---
>   - reset 8259 interrupt controller, that is, IRQ mapping
> (IRQ0->INT8) - reset 8253 timer to 18,2 ticks per second (I think)
> and then:
>   - correctly initialize EBP, ESP to 0x7c0, SS to 0.
>   - also clear bits 16-31 of EAX, EBX ....
> and as a last step:
>   - reset harddisk via int10
>   - read sector 0 to 0x7c0
>   - copy sector 0 to 0x600
>   - far jmp to 0:0x7c0

It works if you boot Lunix straight from the BIOS. I habitually keep
at least smallish DOS partition for recovery operations and the like.
I boot Linux from DOS. It would be rather hard to boot DOS from this
"DOS-booted" Linux:

The missing part is: restoring interrupt table, BIOS data and interrupt
handlers to pre-Linux values. Pre-Linux DOS installed some handlers in low
640K of ram, now thrashed by Linux. BOOM. ;)

> another board, it unfortunately crashes as soon as it goes into
> protected mode, that is, the machine looks like its performing a
> cold-start (warm-start?). seems like a double- or triple-fault. any
> idea on how this can be debugged?

Compare pre-Linux and post-Linux machine state. You may start from comparing
low 640K of RAM....
--
vda
