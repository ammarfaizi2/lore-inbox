Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRBVSXA>; Thu, 22 Feb 2001 13:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130518AbRBVSWt>; Thu, 22 Feb 2001 13:22:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35203 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130515AbRBVSWf>; Thu, 22 Feb 2001 13:22:35 -0500
Date: Thu, 22 Feb 2001 13:22:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marcus Ramos <marcus@ansp.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Building a new module from an existing one
In-Reply-To: <3A95470B.E273C637@ansp.br>
Message-ID: <Pine.LNX.3.95.1010222131112.6084A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Marcus Ramos wrote:

> Hello,
> 
> I plan to make a few changes to 3c90x.c (Ethhernet driver) located at
> /usr/src/linux-2.2.16/drivers/net, in RH7. Since the correspondent
> object file 3c90x.o resides in /lib/modules/2.2.16-20/net, I ask: how
> shall I proceed in order to have the C file properly compiled and placed
> in the right place, so that the modified version replaces the previous
> one after system boot up ?
> 
> Thanks in advance,
> Marcus.
> 

I assume this is serious. Therefore, I answer.

cd /usr/src/linux-2.2.16
make modules
make modules_install

You should be able to test your changes without having to reboot
and without overwriting the existing (working) driver. If you are
doing a lot of work, I suggest you make a script:

#!/bin/bash
ifconfig eth0 down
rmmod 3c90x
insmod /usr/src/linux-2.2.16/drivers/net/3c90x.o
ifconfig eth0 xx.xx.xx.xx netmask mm.mm.mm.mm broadcast bb.bb.bb.bb
route add -net xx.xx.xx.0 netmask mm.mm.mm.mm broadcast dev eth0
route add default gw (etc)


Once you have verified that your revised driver works as intended,
then you do `make modules_install` to put it into the correct place
for the next boot.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


