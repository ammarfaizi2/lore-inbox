Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUBQUbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUBQUbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:31:39 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5033 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266520AbUBQUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:31:28 -0500
Message-ID: <20040217123054.mn6weqss8kokg4gw@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 17 Feb 2004 12:30:54 -0800
From: Carl Thompson <cet@carlthompson.net>
To: root@chaos.analogic.com
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
	<200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040216231401.3ig4kksk4k8g8440@carlthompson.net>
	<200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040217061400.z9r4gss0gsockws4@carlthompson.net>
	<Pine.LNX.4.53.0402170927330.912@chaos>
In-Reply-To: <Pine.LNX.4.53.0402170927330.912@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 205.158.175.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed.  The devices are on different interrupts, I've tried multiple drivers
for the network adapters and the sound card and there is no evidence at all
that this machine has trouble sharing interrupts.

So has anyone seen anything similar to this?

Thanks,
Carl Thompson

Quoting "Richard B. Johnson" :

  > Linux interrupt code does shared interrupts fine.
  > There may be a bad driver so you need to find which
  > one it is and contact its author. There are still
  > entirely too many drivers that loop in the ISR, ...
  > so-called "interrupt mitigation"... If you are
  > using one such creation, find the loop terminating
  > variable and squash it to where it will not loop.
  > Magically, everything will start to work and share
  > wonderfully.
  >
  > There is a big difference between maximizing the through-put
  > of a device and getting all devices to play nicely together.
  > Often device-driver writers think only of their hardware and
  > don't bother to think about the consequences of keeping
  > the CPU practically forever. For instance, a network card
  > will probably always have new packets available on an active
  > network. If you loop to get them all, you loop forever.
  >
  > On Tue, 17 Feb 2004, Carl Thompson wrote:
  >
  >> Quoting vda :
  >>
  >> > On Tuesday 17 February 2004 09:14, Carl Thompson wrote:
  >> >> Quoting vda :
  >> >> > ...
  >> >> >
  >> >> > Your box share IRQs in a big way :)
  >> >>
  >> >> Your point?
  >> >
  >> > While shared interrupts can in theory work right,
  >> > lots of hardware and/or drivers do not handle
  >> > that.
  >>
  >> First, the two devices in question are not on the same interrupt.

  >> Second, it
  >> is very difficult in this day in age to build a system without
interrupt
  >> sharing.  While I agree that it's better to have as few devices
sharing as
  >> possible, there are simply too many devices in modern systems and
too few
  >> interrupts.  Interrupt sharing needs to work on modern hardware
and needs to
  >> work in Linux.  This notebook is pretty typical in its interrupt
  >> distribution
  >> and I'm not certain that this is a problem.  In fact, while many
devices on
  >> this system use IRQ 11 the only one active at the time was the
audio
  >> controller.  And while IRQ 10 is shared between the CardBus
adapters and the
  >> video card the problems still occur if I don't run X and video
interrupts
  >> shouldn't be generated in console mode, right?
  >>
  >> > I think you should try to reconfigure your
  >> > system so that devices do not share same IRQ
  >> > and see whether that 'fix' the problem.
  >>
  >> There are no options in my notebook's BIOS to reconfigure
interrupts or
  >> disable
  >> devices.
  >>
  >> > BTW, can you show your /proc/interrupts ?
  >>
  >> Attached.
  >>
  >> > --
  >> > vda
  >>
  >> Carl Thompson
  >>
  >
  > Cheers,
  > Dick Johnson
  > Penguin : Linux version 2.4.24 on an i686 machine (797.90
BogoMips).
  >             Note 96.31% of all statistics are fiction.




