Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUBLVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUBLVgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:36:16 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:16768 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266334AbUBLVgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:36:15 -0500
Date: Thu, 12 Feb 2004 22:36:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: Strange atkbd messages with missing keyboard
Message-ID: <20040212213613.GA417@ucw.cz>
References: <Pine.GSO.4.44.0402121600030.22808-100000@math.ut.ee> <20040212154656.A2460@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212154656.A2460@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 03:46:56PM +0100, Andries Brouwer wrote:
> On Thu, Feb 12, 2004 at 04:18:43PM +0200, Meelis Roos wrote:
> > I get strange messages on bootup when there is no keyboard attached
> > (Intel 430TX chipset on a Tyan S1573 mainboard) - it tells about unknown
> > keys pressed.
> > 
> > When no keyboard and no mouse is plugged in:
> > 
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
> > atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > atkbd.c: Unknown key released (translated set 0, code 0x7e on isa0060/serio0).
> > atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
> 
> Yes - most people see such messages involving 7a, where the
> actual code is 0xfa = ACK.
> You see 7e, the actual code is 0xfe = NACK, the error report
> from the keyboard interface.
> 
> It is a kernel flaw that these ACK and NACK are not recognized
> for what they are.

Well, yes, I suppose we could make those into "Unexpected ACK" and
"Unexpected NAK" messages. Still it's rather weird they're appearing on
the 430TX machine, since I've never seen them before on any of my test
machines (some of which operate with USB keyboard/mouse only).

Meelis, can you please enable DEBUG in i8042.c, so that I can check
where these unexpected NAKs come from?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
