Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSKGQKz>; Thu, 7 Nov 2002 11:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSKGQKz>; Thu, 7 Nov 2002 11:10:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21889 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261395AbSKGQKx>; Thu, 7 Nov 2002 11:10:53 -0500
Date: Thu, 7 Nov 2002 11:19:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Fernando Fraga e Silva <fernando.fraga@poli.usp.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel port misbehavior using kernel 2.4.19 and pcchips M810
In-Reply-To: <200211081038.21291.fernando.fraga@poli.usp.br>
Message-ID: <Pine.LNX.3.95.1021107104530.9080A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Fernando Fraga e Silva wrote:

> Hi Guys
> I'm working for 4 days on a parallel port misbehavior problem without having 
> any sucess. I have to control a device with SPP mode using a pcchips M810, a 
> Duron processor and a kernel 2.4.19.
> So I made the following simple code :
> --
> #include <asm/io.h> //i've tried <sys/io.h>  too
> int main ()
> {
> ioperm( 0x378, 3, 1);
> outb (0x01, 0x378 );
> ioperm (0x378, 3, 0);
> return 0;
> }
> --

I modified your code to check some things an to easily change
the port:

#include <stdio.h>
#include <asm/io.h> //i've tried <sys/io.h>  too
#define PORT 0x378
int main ()
{
ioperm( PORT, 3, 1);
outb (0xaa, PORT );
printf("%02x\n", inb(PORT));
outb (0x55, PORT );
printf("%02x\n", inb(PORT));
ioperm (PORT, 3, 0);
return 0;
}

It works here. You need to make sure that no printer-driver is
loaded since you are using the printer port. If you have two
or more printer ports, the port you use may be 0x278, 0x378, or
0x3bc. You may need to try them all to see what one actually
goes to your connector.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


