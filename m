Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267057AbUBMPfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbUBMPfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:35:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44928 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267057AbUBMPfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:35:03 -0500
Date: Fri, 13 Feb 2004 10:36:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert Woerle <robert@paceblade.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: serial.c - start looking from 0x220 iomem_base  ??
In-Reply-To: <402CE89F.9060404@paceblade.com>
Message-ID: <Pine.LNX.4.53.0402131025120.4338@chaos>
References: <402CE89F.9060404@paceblade.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Robert Woerle wrote:

> Hi
>
> I am having here a device  (Tablet PC ) sample with a serial resistive
> touchscreen  .
> Under Windows it comes up as COM1 at IO-Base 0x220 -0x227 IRQ 4 .
> Now it seems that in linux the serial driver doesnt look for so "low"
> I/O-Base `s .
>
> By hacking around by hardcoding the 0x220 somehwere in serial.c i get it
> to detect a standard 16550 , but
> unfortunately it then assumes that all ttySX have this base .
> This is because of my hardcoded hack and the driver not looking for all
> the rest mem bases.
>
> So the quesion is :
> Where do i tell serial.o  to start lower ( at 0x220 ) to look for
> controllers .. .??
>
>
>
> Pls also CC me directly since i am only monitoring this list .

There are 4 de facto standard serial ports:

COM1	0x3F8	IRQ4
COM2	0x2F8	IRQ3
COM3	0x3E8	IRQ4
COM4	0x2E8	IRQ3

If you have a port at 0x220, it is above the game-port area,
but not where the kernel should "look for" serial devices.
Therefore, you don't tell the kernel to, as you state, start
lower. Instead, you tell the kernel where they are by putting
them in the pnp_devices[] table.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


