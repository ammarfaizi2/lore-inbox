Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVC2TPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVC2TPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVC2TPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:15:08 -0500
Received: from alog0591.analogic.com ([208.224.223.128]:61905 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261314AbVC2TO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:14:58 -0500
Date: Tue, 29 Mar 2005 14:14:48 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Mateusz Berezecki <mateuszb@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI bus mastering question
In-Reply-To: <aec8d6fc050329095549143eb6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503291356470.13750@chaos.analogic.com>
References: <aec8d6fc050329095549143eb6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005, Mateusz Berezecki wrote:

> Hello dear list readers,
>
>
> I've been googling on the topic for a couple of minutes and I got
> some question.
> If PCI bus mastering means the device gets the control over the
> bus and does all
> device voodoo is it possible to achieve the same effects without using
> mastering?
> To be more specific: if the device wrote some - let's say register for
> example - to a
> memory location, would the result be identical if a kernel read the
> same register from a device and stored it somewhere in memory? Or does
> mastering trigger some special stuff in a device so it acts different?
>
>
> kind regards
> /mb


Bus-mastering is a DMA operation. Devices that can perform
bus-mastering can read or write data to or from RAM while the
CPU is doing something else.

Actually, it isn't all that "free", though, because during
a bus-master operation, the CPU is locked off the bus. The
bus-mastering operation is usually broken up into bursts
so the CPU isn't locked off the bus for very long.

With many PCI devices, there isn't any to get data into or
out of the device without using bus-mastering so you would
need to properly program the device to perform the operation.

This comes about because the internal RAM, inside the device,
isn't accessible from the PCI/Bus. The only path is through
the bus-mastering controller on the board. Otherwise, there
isn't any difference between the CPU reading data from the
board and putting it into memory, or the bus-mastering controller
doing it for you --except, when the CPU does it, it's busy
100% of the time until done, it the case of bus-mastering
the CPU is busy only a small fraction of the total transfer
time.

Wonderful thing about bus-mastering controllers. When they
are programmed correctly, the work like a charm. If you
screw up the setup, though, they can overwrite the whole
kernel, with no way out but the power switch!

Fun! Do lots of back-ups, keep important stuff on external
USB or Firewire drives so a gigantic crash won't kill a
week's work. The world's "best" documentation might not
tell you that the scatter-list address needs to be
big-endian or something like that! It's easy to get things
wrong and you don't know until you throw it off the cliff
and see if it flies! If it works, it works. If it doesn't
it tries to get even by destroying your work!

Nevertheless, don't be frightened. Just be prepared.
The best performing software you will ever write involves
bus-mastering devices. It's well worth the effort.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
