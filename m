Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131556AbRAJMqz>; Wed, 10 Jan 2001 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRAJMqp>; Wed, 10 Jan 2001 07:46:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132787AbRAJMqd>; Wed, 10 Jan 2001 07:46:33 -0500
Date: Wed, 10 Jan 2001 07:46:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.0 Network device incompatibility
Message-ID: <Pine.LNX.3.95.1010110074439.19676A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Testing Linux version 2.4.0
	(Linux chaos 2.4.0 #4 SMP Tue Jan 9 10:20:29 EST 2001 i686)

.. shows some compatibility problems with previous software and
De-facto standards.

(1)	The netmask of the loop-back device can no longer be set 
	using:
	socket(PF_INET, SOCK_DGRAM, IPPROTO_IP)
	ioctl(SIOCSIFNETMASK)
(2)	The broadcast address of the loop-back device can no longer
	be set using:
	socket(PF_INET, SOCK_DGRAM, IPPROTO_IP)
	ioctl(SIOCSIFBRDADDR)

The errors returned are EADDRNOTAVAIL (cannot assign requested address)

This breaks embedded software that has to do everything itself, i.e.,
does not use 'ifconfig', but instead executes the ioctl()s.

A new `ifconfig`, that came with Red Hat 7, will not set these
addresses eitherB. However, an old `ifconfig` that uses two different
kinds of sockets, SOCK_PACKET and SOCK_RAW, is sucessful.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
