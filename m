Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbTHTE6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTHTE6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:58:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:15830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261715AbTHTE6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:58:47 -0400
Message-ID: <32801.4.4.25.4.1061355525.squirrel@www.osdl.org>
Date: Tue, 19 Aug 2003 21:58:45 -0700 (PDT)
Subject: Re: Console on USB
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <zaitcev@redhat.com>
In-Reply-To: <200308200446.h7K4kW211793@devserv.devel.redhat.com>
References: <mailman.1061346549.9440.linux-kernel2news@redhat.com>
        <200308200446.h7K4kW211793@devserv.devel.redhat.com>
X-Priority: 3
Importance: Normal
Cc: <tmolina@cablespeed.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   So I ordered a USB to serial converter, configured a 2.6.0-test3
>> kernel, added a console=/dev/ttyUSB0 to the kernel command line and
>> connected this to my desktop with a null modem adapter.
>
> What made you think this will work?!

Maybe the drivers/usb/serial/Kconfig file?

config USB_SERIAL_CONSOLE
        bool "USB Serial Console device support (EXPERIMENTAL)"
        depends on USB_SERIAL=y && EXPERIMENTAL

>> Is there any advice I might be able to use to get this going?
>
> You'd have to write it. Grep for register_console for starters.
> But I do not advise it, see below.

usb/serial/console.c:255:         register_console(&usbcons);

>>  I really want to be able to catch some oops output.
>
> If oops happens with interrupts closed, forget about it.
> USB needs interrupts to work. This is one of the reasons nobody
> bothered to implement console over USB serial.

The call to register_console() also happens very late in the boot
sequence, so if your oops is early, USB console won't help.

> You will have a better chance using Ingo's netconsole, if a patch
> for your Ethernet driver exists.

Certainly, I agree.

~Randy



