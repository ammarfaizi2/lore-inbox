Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTF3Hep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTF3Hep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:34:45 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:28975 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263722AbTF3Hej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:34:39 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: =?iso-8859-1?q?R=E9mi=20Colinet?= <remi.colinet@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 / Speedtouch USB modem / configuration problem
Date: Mon, 30 Jun 2003 09:48:52 +0200
User-Agent: KMail/1.5.9
References: <3EFF3D04.9060208@wanadoo.fr>
In-Reply-To: <3EFF3D04.9060208@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306300948.55455.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to use the Alcatel Speedtouch USB modem with 2.5.73. I'm
> facing a configuration problem and couldn't find a solution using Google.

Hi Remi, it looks like you are trying to use the user space driver (the one
from http://speedtouch.sourceforge.net/), but have the kernel driver loaded
(the speedtch module; see http://www.linux-usb.org/SpeedTouch/).  These
two drivers do not play nicely together.

> The firmware is loaded and the modem is initialized correctly using the
> following command :
>
>     /usr/local/bin/modem_run -v 1 -d /proc/bus/usb/001/002 -f
> /usr/local/bin/mgmt.o -s -m

You can use modem_run with the kernel driver, but you need to add
-k to the switches you pass to it.

> Gotcha, I found your ADSL ALCATEL SpeedTouch USB modem!
> best offset   6463 with probability  87%
> best offset 532634 with probability 100%
> BLOCK1 :    991 bytes   uploaded : OK
> BLOCK2 :    511 bytes downloaded : OK
> BLOCK3 : 526187 bytes   uploaded : OK
> BLOCK4 :    511 bytes downloaded : OK
> Reference     : 3EC 18607CDAA 02(see under your modem box)
> ADSL line is blocked?
> ADSL line is synchronising
> ADSL line is synchronising
> ADSL line is up, downstream at 608 kbit/s, upstream at 160 kbit/s
> ADSL link goes UP
>
> Then, I'm using the following command :
>
>     pppd call adsl

The ppp config file for the kernel mode and user mode drivers differ.
See the web pages.

> But I'm getting the following message :
>
> [root@tigre01 src]#
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't set tty to PPP discipline: Invalid argument
> Couldn't get channel number: Input/output error
> Couldn't get channel number: Input/output error
> Couldn't set tty to PPP discipline: Invalid argument
> [root@tigre01 src]#

Yeah.

> I have the following modules loaded :
>
> [root@tigre01 src]# lsmod
> Module                  Size  Used by
> n_hdlc                 14852  0
> 3c59x                  43944  0
> speedtch               21936  0
> crc32                   8576  1 speedtch
> usbmouse                9472  0
> usbkbd                 11264  0
> hid                    29440  0
> uhci_hcd               40968  0
> usbcore               124756  7 speedtch,usbmouse,usbkbd,hid,uhci_hcd
> [root@tigre01 src]#

The kernel mode driver is loaded.

> May be, it is a configuration problem.

Yup.

> Does anyone has an idea about what is wrong in my configuration?
> What modules are necessary (ppp-async, n_hdlc, speedtch)?
> May be something is missing in my modprobe.conf or .config file?

Both drivers work fine.  You just need to decide which one you want!

All the best,

Duncan.
