Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318411AbSGaRdy>; Wed, 31 Jul 2002 13:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318414AbSGaRdy>; Wed, 31 Jul 2002 13:33:54 -0400
Received: from www.transvirtual.com ([206.14.214.140]:40717 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318411AbSGaRdx>; Wed, 31 Jul 2002 13:33:53 -0400
Date: Wed, 31 Jul 2002 10:37:15 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: devfs and tty layer.
Message-ID: <Pine.LNX.4.44.0207311026580.13905-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   As you already seen there has been a issue with devfs and the VT code.
I have moved the tty registeration later for VTs so the TTY_DRIVER_NO_DEVFS
flag was no longer needed. Because I removed this now tty_register_driver
calls tty_register_devfs instead of con_init_devfs. Now when con_init_devfs
was calling tty_register_devfs it was passing a different flag to devfs
then the default tty_register_driver does. So I have been thinking about
different approachs to the problem.

1) The first approach is to change the tty_register_devfs function to pass
   in the flag.

2) Add a devfs flag field to struct tty_driver.

3) Remove tty_register_devfs from tty_register_driver and have each tty
   driver call tty_register_devfs its self.


What solution would you do?

