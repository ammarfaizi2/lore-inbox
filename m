Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBWQ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUBWQ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:57:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261957AbUBWQ5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:57:13 -0500
Date: Mon, 23 Feb 2004 11:57:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Jinu M." <jinum@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Device Driver for SMP
In-Reply-To: <1118873EE1755348B4812EA29C55A97212812C@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0402231144210.602@chaos>
References: <1118873EE1755348B4812EA29C55A97212812C@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Jinu M. wrote:

> Hi All,
>
> We have developed a PCI device driver which works well on both MAC
> (yellow dog) and x86 (RedHat) architectures.
> Now we need to provide the support for SMP machine. What generic
> changes will have to be made to the driver to get it working
> on a SMP machine.
>
> My first doubt is who takes care of the SMP support? Is it the kernel's
> job or the driver's job?
> As you can see I am not a guru at Linux device drivers, so I would
> be happy if you could provide me pointers or some good explanation
> on it.
>
> Thanks a lot!
> -Jinu
>

If the driver was properly written, there is nothing you need
to do to "convert" it to SMP. However, if the driver was written
using 'cli/sti' pairs to protect critical sections, you need
to rewrite those sections to use spin-locks.

OTOH, if the driver was written like a lot of so-called "perfectly
working..." drivers I've seen, you may need to start from scratch!
It all depends upon the techniques the writer used.

When you have two or more CPUs, you absolutely-positively need
to identify and protect critical sections of code. These are
the sections that would corrupt data, muck up hardware, or
otherwise screw up if two or more CPUs were executing the
code or messing with variables at nearly the same time.

For instance, let's say it took two instructions to hardware
to turn on an external light-bulb and no intermediate hardware
instructions were allowed between these two instructions. You
definately need to keep another CPU from touching the hardware
until these two instructions have completed. With only one
CPU, you can often write sloppy code because you know that
nothing else is going to touch your hardware until you are
done. Not so, with SMP machines.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


