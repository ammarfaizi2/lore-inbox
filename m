Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131653AbQKRWbH>; Sat, 18 Nov 2000 17:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQKRWat>; Sat, 18 Nov 2000 17:30:49 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131356AbQKRWaQ>;
	Sat, 18 Nov 2000 17:30:16 -0500
Message-ID: <20001118211349.B382@bug.ucw.cz>
Date: Sat, 18 Nov 2000 21:13:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz> <8v1pfj$p5e$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <8v1pfj$p5e$1@cesium.transmeta.com>; from H. Peter Anvin on Thu, Nov 16, 2000 at 03:09:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Anyway, this should be solvable by checking for clock change in the
> > timer interrupt. This way we should be able to detect when the clock
> > went weird with a 10 ms accuracy. And compensate for that. It should be
> > possible to keep a 'reasonable' clock running even through the clock
> > changes, where reasonable means constantly growing and as close to real
> > time as 10 ms difference max.
> > 
> 
> Actually, on machines where RDTSC works correctly, you'd like to use
> that to detect a lost timer interrupt.
> 
> It's tough, it really is :(

Well, my patch did not do that but you probably want lost timer
interrupt detection so that you avoid false alarms.

But that means you can no longer detect speed change after 10msec:

going from 150MHz to 300MHz is very similar to one lost timer
interrupt.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
