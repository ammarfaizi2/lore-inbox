Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVA0QsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVA0QsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVA0QsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:48:00 -0500
Received: from alog0435.analogic.com ([208.224.222.211]:45440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262659AbVA0Qrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:47:53 -0500
Date: Thu, 27 Jan 2005 11:47:08 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Rahul Karnik <deathdruid@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Flashing BIOS of a PCI IDE card (IT8212F)
In-Reply-To: <5b64f7f050127081948af7a31@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0501271145340.22577@chaos.analogic.com>
References: <5b64f7f050127081948af7a31@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Rahul Karnik wrote:

> Hello,
>
> I was just wondering if it is possible to flash the BIOS of a PCI IDE
> card from within Linux. I have an OEM IT8212 card with a really old
> BIOS which the vendor does not support with a BIOS flashing tool. ITE
> Tech's flashing tool appears to work, but it fails to verify that the
> flash was successful and indeed the ROM is unchanged.
>
> How is the BIOS on such cards different from the firmware on other
> cards? Is it possible to use the kernel firmware loader to load a
> different image at runtime?
>
> Thanks for the help,
> Rahul
> -

Simple answer: forget it.

But... If you know the part number of the flash-RAM,
it is possible to use one of the flash-RAM writers
that may exist in your version of the kernel or to
write your own. Basically you write some unlock codes
at specified offsets (0x55, 0xaa, etc.), then you
write a command-code, then some data at its offset.

Writing to flash requires erasing it first. Therefore
if the write fails, you are in deep dodo. Typically
flash RAM exists in 64k pages. Something as small as
a BIOS probably uses only one 64k page, but you
need to know what one inside the chip is actually
used.

There are other types of flash (micro-wire) that
are accessed only one bit at a time. There is such
code in several of the Ethernet Controllers. Although
writing code to read/erase/write any of these devices
is not difficult, you need to be able to experiment
to get it right. Because of different implementation
details, some flash can only be accessed in 32-bit
longs, some in 16-bit shorts, etc. Some single-bit
flash requires you to write an unused bit, with
some, the extra bit goes on the end, some it
goes first. Some require 16 bits written backwards,
etc. Without a spare device to experiment with, you
are in a world of hurt if your initial guess of
the implementation details is wrong.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
