Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbSLEVH1>; Thu, 5 Dec 2002 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbSLEVGy>; Thu, 5 Dec 2002 16:06:54 -0500
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:52888 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267450AbSLEVG1>; Thu, 5 Dec 2002 16:06:27 -0500
Message-ID: <010c01c29ca4$01d43810$6501a8c0@titan>
From: "Bill Beebe" <wbeebe@cfl.rr.com>
To: "David Ashley" <dash@xdr.com>, <linux-kernel@vger.kernel.org>
References: <200212051721.gB5HLpb07596@xdr.com>
Subject: Re: 2.5.40 compile errors with my CONFIG options (included)
Date: Thu, 5 Dec 2002 16:19:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this same problem with 2.5.4x in general, and got this very helpful clue
from Rusty Lynch:

The problem is that when Virtual Terminal support is built into the kernel
(not a module) then Input support also needs to be built into the kernel
because it is making function calls that are implemented in the VT section.

To fix this, change the build input support to be built in the kernel instead
of building it as a module.  This can be done from "make xconfig" by
clicking on the "Input device support" on the left, and then change the "Input
devices (needed for keyboard, mouse, ...)" so that it has
a check mark instead of a dot.

Hope this helps.
----- Original Message -----
From: "David Ashley" <dash@xdr.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 05, 2002 12:21 PM
Subject: 2.5.40 compile errors with my CONFIG options (included)


> drivers/built-in.o: In function `kd_nosound':
> drivers/built-in.o(.text+0x110b0): undefined reference to `input_event'
> drivers/built-in.o(.text+0x110cd): undefined reference to `input_event'
> drivers/built-in.o: In function `kd_mksound':
> drivers/built-in.o(.text+0x1117a): undefined reference to `input_event'
> drivers/built-in.o: In function `kbd_bh':
> drivers/built-in.o(.text+0x1200a): undefined reference to `input_event'
> drivers/built-in.o(.text+0x12018): undefined reference to `input_event'
> drivers/built-in.o(.text+0x12029): more undefined references to
`input_event' follow
> drivers/built-in.o: In function `kbd_connect':
> drivers/built-in.o(.text+0x1245f): undefined reference to
`input_open_device'
> drivers/built-in.o: In function `kbd_disconnect':
> drivers/built-in.o(.text+0x12477): undefined reference to
`input_close_device'
> drivers/built-in.o: In function `kbd_init':
> drivers/built-in.o(.init.text+0x216e): undefined reference to
`input_register_handler'
[snip]

