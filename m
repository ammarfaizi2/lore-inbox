Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUF3Inj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUF3Inj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266593AbUF3Inj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:43:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:58497 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266591AbUF3Ing (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:43:36 -0400
Date: Wed, 30 Jun 2004 10:45:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>, laflipas@telefonica.net,
       linux-kernel@vger.kernel.org, t.hirsch@web.de
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Message-ID: <20040630084509.GA12112@ucw.cz>
References: <20040629143232.52963.qmail@web81303.mail.yahoo.com> <200406291808.08186.Marc.Waeckerlin@siemens.com> <200406291253.10542.dtor_core@ameritech.net> <200406300102.16083.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406300102.16083.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 01:02:16AM -0500, Dmitry Torokhov wrote:

> Vojtech, what is your opinion?
> 
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191319]
> > Jun 28 16:01:29 qingwa kernel: i8042.c: MUX reports error condition b3 (35)
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: b3 <- i8042 (interrupt, aux0, 12) [191325]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 52 <- i8042 (interrupt, aux1, 12) [191327]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, aux1, 12) [191328]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, aux1, 12) [191330]
> > Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, aux1, 12) [191331]
> > Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191333]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: b3 <- i8042 (interrupt, aux1, 12) [191335]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, aux1, 12) [191336]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, aux1, 12) [191338]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 29 <- i8042 (interrupt, aux1, 12) [191339]
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, aux1, 12) [191342]
> > Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
> > Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191343]
> 
> Again MUX got confused momentarily, the patch should fix that.
> 
> > Jun 28 16:01:31 qingwa kernel: drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, kbd, 1) [193334]
> > Jun 28 16:01:31 qingwa kernel: drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, kbd, 1) [193359]
> > Jun 28 16:01:33 qingwa kernel: i8042.c: MUX reports error condition fd (f5)
> > Jun 28 16:01:33 qingwa kernel: drivers/input/serio/i8042.c: fd <- i8042 (interrupt, aux3, 12, timeout) [195950]
> > Jun 28 16:01:33 qingwa kernel: psmouse.c: bad data from KBC - timeout
> > Jun 28 16:01:36 qingwa kernel: drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, kbd, 1) [198170]
> > Jun 28 16:01:36 qingwa kernel: drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, kbd, 1) [198243]
> 
> This one seems to be legit and handled OK although I am not sure what caused
> AUX3 to report timeout - it wasn't transmitting for quite some time.
> 
> > Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [206317]
> > Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [206320]
> > Jun 28 16:01:44 qingwa kernel: i8042.c: MUX reports error condition 00 (35)
> > Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux0, 12) [206326]
> > Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [206327]
> 
> Confused again...
> 
> Anyway, please try the patch and the change to the timeout in
> psmouse_interrupt. I am anxiously awaiting result of your testing.
 
We may also want to disable the timer polling the chip - that might be
confusing it as well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
