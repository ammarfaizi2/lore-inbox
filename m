Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUKPTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUKPTkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKPTih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:38:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51642 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262124AbUKPTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:36:19 -0500
Date: Tue, 16 Nov 2004 20:36:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bob Gill <gillb4@telusplanet.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure, 2.6.10-rc2
In-Reply-To: <1100632116.4388.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0411162025180.24131@yvahk01.tjqt.qr>
References: <1100632116.4388.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi.  When booting 2.6.10-rc2, I get
>Warning: unable to open an initial console
>(and the boot process then stalls).
>
>My system has the following already configured:
>crw-------  1 bob root 5, 1 Nov 16 10:10 /dev/console

Are you sure /dev/console exists when the kernel boots?
(It is thy duty to ask this...)

I wonder, because there is no configurator (menuconfig) option to en-/disable
the driver for /dev/console -- it's *always* in. In 2.6.8, and I have not seen
any changes to drivers/char/tty_io.c:tty_init() - where it is added - in
further kernels yet.

>My kernel configuration includes the following:
>CONFIG_UNIX98_PTYS=y
>CONFIG_LEGACY_PTYS=y
>CONFIG_LEGACY_PTY_COUNT=256

Initial console has nothing to do with ptys.
The console driver will always be compiled in, it is not wrapped into any
#if..#endif in drivers/char/tty_io.c.
But to be on the safe side, enable:

CONFIG_VT=y
CONFIG_VT_CONSOLE=y

>I have appended console=/sbin/bash to the kernel boot line (which does
>not meet with success).

The one that takes a program is init=, but that will probably also not work
because you ain't got no console.

As I read from kernel/printk.c, the console= parameter seems to set up a
-serial line-, also see Documentation/serial-console.txt and
kernel-parameters.txt.

>If it makes any difference, my system is FC3.  Is there anything special
>I have to do to udev (or a particular version I have to get in order to
>start a console after the kernel is loaded (and the memory is freed
>after it's shuffled from himem to lomem)?

How, after all, did you run into this error? Directly after upgrading (if
applicable)?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
