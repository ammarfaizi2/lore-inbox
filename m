Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbTIILkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTIILkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:40:33 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:39663
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264031AbTIILkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:40:25 -0400
Message-ID: <3F5DBC1F.8DF1F07A@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 21:40:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: serio config broken?
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In -test4 I have:

CONFIG_SERIO=m
CONFIG_SERIO_I8042=m
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m

but -test5 insists on:

CONFIG_SERIO=m
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m

Removing the I8042 line and doing 'make oldconfig' does not even
ask about it but sets it to '=y'. As a result I get:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `atkbd_interrupt':
drivers/built-in.o(.text+0x6d10f): undefined reference to `serio_rescan'
drivers/built-in.o: In function `atkbd_disconnect':
drivers/built-in.o(.text+0x6d726): undefined reference to `serio_close'
drivers/built-in.o: In function `atkbd_connect':
drivers/built-in.o(.text+0x6d84e): undefined reference to `serio_open'
drivers/built-in.o(.text+0x6d883): undefined reference to `serio_close'
drivers/built-in.o: In function `atkbd_init':
drivers/built-in.o(.init.text+0x5fd6): undefined reference to
`serio_register_de
vice'
drivers/built-in.o: In function `atkbd_exit':
drivers/built-in.o(.exit.text+0x196): undefined reference to
`serio_unregister_d
evice'
make: *** [.tmp_vmlinux1] Error 1

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
