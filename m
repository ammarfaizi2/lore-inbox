Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269246AbRGaKzT>; Tue, 31 Jul 2001 06:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269247AbRGaKzK>; Tue, 31 Jul 2001 06:55:10 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:49677 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S269246AbRGaKzF>; Tue, 31 Jul 2001 06:55:05 -0400
Date: Tue, 31 Jul 2001 12:55:12 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
cc: <pworach@mysun.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)
Message-ID: <Pine.LNX.4.33.0107311246360.3857-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Martin Knoblauch wrote:

> > The eepro100 interface in my Fujitsy/Siemens Lifebook S-4546
> > won't come up after a suspend, if I unload the module and load it again
> > it works fine...
> > "ioctl SIOCSIFFLAGS: No such device" is the error message.
> 
>  same here with an eepro100 inside a IBM Thinkpad570. Happened with
> 2.4.6-ac2. Since then I apply the appended patch after installing "-ac"
> stuff. This completely disables power state handling for the device. Not
> very clean, but I do not care in this particular case. It probably shows
> a more principal issue with the eepro100. Kai - did you look deeper into
> the issue?

I didn't look to deep, since my eepro100 works fine here, so I can't 
reproduce your problem.

However, I'm wondering if the problems you guys are having are really the 
same. IIRC, Martin's eepro100 wouldn't ever come up from state D2 into 
working state again until the next reboot, right?

Whereas Pawel's eepro100 can be revived by reloading the module, so there 
seems to be a difference. For Pawel, can you supply lspci -vvxxx output 
before and after the suspend. That should give some hints.

Martin, if you want to spend some work on your problem, you could try to 
collect some more data an your problem, particularly what about using 
another state (D1/D3) when the interface is down. D3 will probably mean 
that you have to save/restore PCI config space, so it's a bit more 
tedious. Also, is there anything which makes your card work again after it 
was in state D2? Like suspend/resume, or putting it into D3 and back into 
D0? Does a warm reboot suffice, or do you need to power cycle.

As it stands, I don't see an alternative to Martin's problem apart from
the patch he's using - well, that could be done a bit more nicely, like
having a config option for the sleep D state, which would increase chances
Alan would take it as an -ac patch.

--Kai

