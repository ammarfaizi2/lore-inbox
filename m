Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVCNTGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVCNTGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVCNTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:06:51 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24398 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261708AbVCNTGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:06:41 -0500
Message-ID: <4235E0BD.5090200@tls.msk.ru>
Date: Mon, 14 Mar 2005 22:06:37 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru> <20050314162537.GA2716@ucw.cz> <4235BDFD.1070505@tls.msk.ru> <20050314164342.GA1735@ucw.cz>
In-Reply-To: <20050314164342.GA1735@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
[]
>>In 2.6.9 (it works just fine too, problem happens with 2.6.10 and up
>>only), there's no such parameter in drivers/pci/quirks.c.  Hmm.
> 
> Any chance the order of module loading changed between the two versions?
> I see you have 'psmouse' as a module. If i8042 (and psmouse) are loaded
> after uhci-hcd (or ohci-hcd), the problem will disappear, too.

Yes, the prob disappears if usb controller driver is loaded before the
mouse driver.  Obviously I didn't know USB is "involved" here so I never
looked at the problem from this point of view before.  Now when I looked
at it, I see I have uhci-hcd driver being loaded in my 2.6.9 initrd,
before mouse (I removed it after as it wasn't needed).  I also tried
loading 2.6.9 without uhci-hcd but with USB keyboard/mouse enabled in
BIOS - the mouse is flaky too, similar to 2.6.10 behaviour.

Interesting.  I was looking at the difference in input subsystem
between 2.6.9 and 2.6.10 -- obviously there's nothing relevant here! ;)

>>So is this a bios/mobo problem,
> 
> Yes.

Never had any single problem with this hardware so far.  But.. uh-oh.
Well.. it's only 2.6 kernel that encounters problem with it for now,
so it must be the kernel... ;)

>>or can it be solved in kernel somehow?
> 
> We could have usb-handoff by default.

What's the consequences of this?
If it does not hurt (does it?), why not to enable it?
And if it does not hurt, I can enable it in our default netboot
image as well.. if not to see whenever all our machines will work
ok with this parameter.

Thank you very much - this mysterious problem.. I was trying to
find the solution for quite some time before posting to LKML,
without any success, and the solution was already here! ;)

/mjt
