Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUCMInB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 03:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbUCMInB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 03:43:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:34521 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263064AbUCMIm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 03:42:59 -0500
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1079164176.3198.1.camel@localhost>
References: <1079097936.1837.102.camel@localhost>
	 <1079137438.1960.47.camel@gaston>  <1079164176.3198.1.camel@localhost>
Content-Type: text/plain
Message-Id: <1079167073.1966.90.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 19:37:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 18:49, Soeren Sonnenburg wrote:
> On Sat, 2004-03-13 at 01:23, Benjamin Herrenschmidt wrote:
> > On Sat, 2004-03-13 at 00:25, Soeren Sonnenburg wrote:
> > > Hi!
> > > 
> > > I got this oops when inserting mouse/keyboard (both usb).
> > > 
> > > usb 1-1: new low speed USB device using address 4
> > > input: USB HID v1.00 Mouse [Cypress Sem USB Mouse] on usb-0001:01:18.0-1
> > > Oops: kernel access of bad area, sig: 11 [#1]
> > > NIP: 5A5A5A58 LR: C026D8B0 SP: ED6B1E10 REGS: ed6b1d60 TRAP: 0401    Not
> > 
> > NIP is the program counter, something tried to jump into nowhereland,
> > find out who by looking at who "owns" C026D8B0 in System.map
> 
> this is the area around c026d8b0, so input_accept_process or noone ?!

Yup, input_accept_process called into oblivion, apparently a poisoned
region even (use after free ?)

Vojtech, any clue ?

Ben.


