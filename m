Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbTGON2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbTGON2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:28:50 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:8404 "EHLO gaston")
	by vger.kernel.org with ESMTP id S267647AbTGON2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:28:49 -0400
Subject: Re: radeonfb patch for 2.4.22...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, ajoshi@kernel.crashing.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m2ptkcknfh.fsf@telia.com>
References: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
	 <Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
	 <1058255052.620.2.camel@gaston>  <m2ptkcknfh.fsf@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058276604.620.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 15:43:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I have a small problem with radeonfb in 2.4.22-pre5 (+manually created
> radeonfb.h file). During boot, when the console is switched over to
> the frame buffer device, the screen becomes corrupted. Mostly by white
> squares in a grid pattern and some squares with other colors. Between
> the squares, normal characters can be seen, but each character is
> duplicated. Here is a picture: (not very sharp unfortunately)
> 
>         http://w1.894.telia.com/~u89404340/radeonfb.jpg
> 
> Text added after the switch is not corrupted, so eventually the
> corruption is scrolled off the screen and after that the framebuffer
> appears to be working correctly.

It's a known artifact caused by my latest stuffs, mostly because
I setup the display earlier than expected by the fbcon core, at
which point the console buffer contains junk. I'm working on a fix
though I can't reproduce on pmac.

> 2.4.22-pre3 does not have this problem. I haven't found a patch for
> the vanilla 0.1.8 version, so I don't know if that version also has
> this problem. I think someone has reported a similar problem in 2.5.x,
> but I don't remember the details.
> 
> Here are some messages from the kernel log:
> 
> Jul 14 23:08:44 best kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
> Jul 14 23:08:44 best kernel: radeonfb: panel ID string: Samsung LTN150P1-L02    
> Jul 14 23:08:44 best kernel: radeonfb: detected LCD panel size from BIOS: 1400x1050
> Jul 14 23:08:44 best kernel: Console: switching to colour frame buffer device 175x65
> Jul 14 23:08:44 best kernel: radeonfb: ATI Radeon M7 LW DDR SGRAM 64 MB
> Jul 14 23:08:44 best kernel: radeonfb: DVI port LCD monitor connected
> Jul 14 23:08:44 best kernel: radeonfb: CRT port no monitor connected
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
