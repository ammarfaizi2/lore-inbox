Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVBUIIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVBUIIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVBUIIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:08:36 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:993 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261915AbVBUIH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:07:57 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050219131639.GA4922@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz>
	 <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz>
	 <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz>
	 <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost>
	 <20050219131639.GA4922@ucw.cz>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 09:06:55 +0100
Message-Id: <1108973216.5774.72.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 19.02.2005, 14:16 +0100 schrieb Vojtech Pavlik:

[...]

> 
> > I also checked my original standalone-driver: Because of this behaviour
> > I always retried the last command 3 times if the responce from the
> > device was 0xfe or 0xfc.
> 
> And did it actually help? Did the touchscreen ever respond with a 0xfa
> "ACK, OK" response to these commands?

I played around a little bit last weekend. And obviously the touchscreen
always responds 0xfe to the 0xe8 0x07 command. Also repeating the
command does not really help. After the firxt 0x07 you get back the 0xfe
and the next byte you send to the device is ALWAYS answered by a
0xfc!?!?

At the end of this mail you'll find some traces I did.

I also wonder if it is possible at all to probe this device. I think
not. IMHO we should go for a module-parameter which enforces the
lifebook-protokoll. Something like "force_lb=1". Any Ideas /
suggestions? How does this work out with a second/external mouse?

##################################################

Without e8 07
input: LBPS/2 Fujitsu Lifebook TouchScreen on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082637]
drivers/input/serio/i8042.c: f5 -> i8042 (parameter) [195082637]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082645]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082804]
drivers/input/serio/i8042.c: ff -> i8042 (parameter) [195082804]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082807]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12)[195082869]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12)[195082871]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082871]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [195082871]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082874]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082874]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [195082874]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082878]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082879]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [195082879]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082884]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082884]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [195082884]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082888]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082889]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [195082889]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082894]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195082894]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [195082894]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195082899]

Repeating: e8 07 e8 07
input: LBPS/2 Fujitsu Lifebook TouchScreen on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781502]
drivers/input/serio/i8042.c: f5 -> i8042 (parameter) [195781502]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781506]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781506]
drivers/input/serio/i8042.c: ff -> i8042 (parameter) [195781506]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781511]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [195781569]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12)[195781575]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12)[195781577]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781595]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [195781595]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781601]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781602]
drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [195781602]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12)[195781606]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781607]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [195781607]
drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12)[195781611]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781809]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [195781809]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781813]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781813]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [195781813]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781817]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781818]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [195781818]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781822]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781823]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [195781823]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781827]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781828]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [195781828]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[195781832]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [195781833]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [195781833]

Repeating: e8 07 e8 07 e8 07
input: LBPS/2 Fujitsu Lifebook TouchScreen on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875239]
drivers/input/serio/i8042.c: f5 -> i8042 (parameter) [196875239]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875241]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875242]
drivers/input/serio/i8042.c: ff -> i8042 (parameter) [196875242]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875246]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12)[196875311]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12)[196875312]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875319]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [196875319]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875327]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875327]
drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [196875327]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12)[196875332]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875332]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [196875332]
drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12)[196875336]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875534]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [196875534]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875538]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875538]
drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [196875538]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12)[196875543]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875543]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [196875543]
drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12)[196875547]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875746]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [196875746]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875754]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875755]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [196875755]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875759]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875759]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [196875759]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875764]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [196875765]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [196875765]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12)[196875770]


