Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVA1V7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVA1V7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVA1V7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:59:49 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:22288 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262790AbVA1V7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:59:43 -0500
Date: Fri, 28 Jan 2005 22:59:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050128215939.GF6010@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128111005.GA9232@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128111005.GA9232@ucw.cz>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: pastinakel.tue.nl 1189; Body=1 Fuz1=1 
	Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:10:05PM +0100, Vojtech Pavlik wrote:

> And, btw, raw mode in 2.6 is not badly broken. It works as it is
> intended to. If you want the 2.4 behavior on x86, you just need to
> specify "atkbd.softraw=0" on the kernel command line.

Thanks for pointing that out - I should have read patch-2.6.9 more
carefully. I'll add that to the setkeycodes.8 man page.

Nevertheless I disagree a bit. "raw mode" is by definition the mode
where scan codes are passed unmodified to user space.
So before 2.6.9 this was just broken, and since 2.6.9 it is broken
by default but there is a boot option to make it work.

What is the reason that you do not make this the default?
The current default is really messy and confusing, especially
when people have to map keys using setkeycodes.

Andries


BTW, now that I read the corresponding code:

        if (atkbd_softrepeat)
                atkbd_softraw = 1;

        if (!atkbd_softrepeat) {
                atkbd->dev.rep[REP_DELAY] = 250;
                atkbd->dev.rep[REP_PERIOD] = 33;
        } else atkbd_softraw = 1;

The "else" part is superfluous.
