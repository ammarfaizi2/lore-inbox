Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUKHBRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUKHBRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 20:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKHBRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 20:17:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:58767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261722AbUKHBQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 20:16:47 -0500
Date: Sun, 7 Nov 2004 17:16:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net, linux-sound@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <418EB3AA.8050203@g-house.de>
Message-ID: <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
 <418EB3AA.8050203@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Christian Kujau wrote:
> 
> what i did not expect is that this ChangeSet is now *not* the culprit,
> because there is no oops. am i right? [1]

Yes.

So now I'd like to know _where_ the culprit is, since it turned out to be 
not the ALSA code. 

> i did another thing: i enabled the (deprecated) OSS driver (es1371.ko)
> tried to load this thing:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-OSS.txt
> 
> it oopses.
>  - you said it's not a b0rken pci thingy
>  - i have to assume now that it's not an ALSA issue (since oss oopses too)
>  - it is OSS? the driver? i've CC'ed linux-sound...

Sounds like something else changed, and likely the ALSA _and_ the OSS 
driver both broke. Which is not all that unlikely, since I suspect they 
share a lot of history.

> yes, like Documentation/BUG-HUNTING says. but i seem to have difficulties
> in using my tools (bk). sorry for that.

Not your fault. Think of this as a learning experience ;)

Anyway, now that the _other_ driver also oopses, and with a very similar 
oops too, so it looks like they both depended on some undocumented (or 
changed) detail in the PCI layer. Next step would be to see if the thing 
that breaks is this merge:

	ChangeSet@1.2463, 2004-11-04 17:07:16-08:00, torvalds@ppc970.osdl.org
	  Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
	  into ppc970.osdl.org:/home/torvalds/v2.6/linux

which merges Greg's PCI/driver model changes.

It's all the same steps you took with the ALSA merge, you're a
professional by now ;)

Greg, have you followed this thread?

> (whose only wish these days is to get over this strange thing and not
> wasting peoples precious time with a "sound driver". hey, at least  the
> box is booting...)

Hey, sound is important. And especially if you somehow found something 
non-sound that just broke sound by mistake, all the more important to fix 
it.

		Linus
