Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUFDPDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUFDPDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFDPDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:03:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:31189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265795AbUFDPDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:03:13 -0400
Date: Fri, 4 Jun 2004 08:03:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stock IA64 kernel on SGI Altix 350
In-Reply-To: <20040604120925.GE20632@lug-owl.de>
Message-ID: <Pine.LNX.4.58.0406040753300.7010@ppc970.osdl.org>
References: <20040603170147.GK10708@fi.muni.cz> <200406031030.36181.jbarnes@engr.sgi.com>
 <20040603200905.GA27701@fi.muni.cz> <20040604120925.GE20632@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jun 2004, Jan-Benedict Glaw wrote:

> On Thu, 2004-06-03 22:09:06 +0200, Jan Kasprzak <kas@informatics.muni.cz>
> wrote in message <20040603200905.GA27701@fi.muni.cz>:
> [ia64 booting]
> > CPU 1: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
> > Calibrating delay loop... 16.44 BogoMIPS
> 
> Hihi:) A ~ 55MHz VAX does nothing with about 15 BogoMIPS.

Yeah, the bogomips have become too bogus to even be useful these days.

Just as a clarification, "bogomips" is really "bogo-timing-events-per-
second-multiplied-by-two" (aka "bogotepsmbt").

The "timing event" used to be a "two-instruction loop", which is where the 
"multiplied-by-two" comes from: at that point the "bogotepsmbt" becomes 
the number of instructions per second, and that explains the "mips" part 
of the name.

But since it's really used for timing small delay loops, and since the
two-instruction loop wasn't very good at that (due to power-usage, SMT
issues, frequency changes, you name it), the implementations have sadly 
started to drift away from using instruction retire as the event they 
count, and start using a separate counter instead.

So 16.44 BogoMIPS these days really implies " ~8MHz timer frequency ".

The timer is a lot better from a technical standpoint, but it sure is a 
hell of a lot less entertaining than the original MIPS thing..

			Linus
