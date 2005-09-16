Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbVIPKaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbVIPKaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVIPKaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:30:07 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:29761 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161156AbVIPKaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:30:05 -0400
Date: Fri, 16 Sep 2005 12:30:02 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
Message-ID: <20050916103002.GA19839@bitwizard.nl>
References: <200509152342.24922.jesper.juhl@gmail.com> <Pine.LNX.4.58.0509151458330.1800@shark.he.net> <9a87484905091515072c7dd4a8@mail.gmail.com> <Pine.LNX.4.58.0509151537140.29737@shark.he.net> <9a87484905091515495f435db7@mail.gmail.com> <Pine.LNX.4.58.0509151554450.29737@shark.he.net> <9a874849050915160027db1fe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050915160027db1fe9@mail.gmail.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 01:00:45AM +0200, Jesper Juhl wrote:
> 
> I'll just dig into it myself for now, but thank you, if I get really
> stuck I may ask him.

The explanation: "jiffies starts at rollover minus a bit" seems to be
spot-on: If jiffies are 32bit, and counting at 1000 per second, the
2^32 / 1000 works out. 

I expect the kernel to run without turning on (timer) interrupts for a
while during boot: It is still initializing things like memory and the
processor. Without those, interrupts won't work. This means that the
timer interrupt will not count in real-time.

A "jump" of 27 seconds seems unlikely, except if somehow the
interrupts are somehow accounted. It could very well be that the
kernel nowadays has a mechanism of measuring the fact that it missed a
timer interrupt and corrects for that. This would mean that around the
"jump", the kernel suddenly realized it missed around 27000 interrupts
and added 27000 to "jiffies"....

I'd say: Would be nice to get the timings right, but not worth the
trouble: There are good technical reasons for the observed facts.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
