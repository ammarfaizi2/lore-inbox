Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265852AbUFDQJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUFDQJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUFDQJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:09:09 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:640 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S265857AbUFDQGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:06:14 -0400
Date: Fri, 4 Jun 2004 18:06:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040604160616.GA1084@ucw.cz>
References: <Pine.GSO.4.58.0405281654370.3992@stekt37> <20040529131406.GB6185@ucw.cz> <Pine.GSO.4.58.0406041732200.9609@stekt37>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406041732200.9609@stekt37>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:54:10PM +0300, Tuukka Toivonen wrote:

> >> Giuseppe Bilotta wrote:
> >> >The new system has some ups and downs. The biggest "down",
> >> >which is that of RAW mode not being available anymore (it's
> >> >emulated!) could be circumvented by having both the RAW and
> >> >translated codes move between layers.
> >> Ouch! If the user asks for raw mode, he doesn't get it, but some emulated
> >> mode? To me this sounds like a big incompatibility.
> >
> >Q1: What would you do if the user has an USB keyboard?
> 
> If an application wants to access directly the keyboard, and the keyboard
> happens to be USB, it should use other means to access it. I believe usbfs
> provides some kind of interface for driving directly USB devices.

Yes, sure, if an application wants to access the USB keyboard directly,
it can use usbfs. But if it asks for rawmode on the console, it needs to
be given PS/2 rawmode. And that inevitably means emulation in this case.

> >Q2: What application should be looking at the raw data outside the
> >    kernel and why?
> 
> If there are no such programs, why the raw mode emulation is there then?

Backward compatibility, namely with X. But even X doesn't have a good
reason using PS/2 protocol to talk to the kernel.

> And if there are such programs, you should ask from those who have made
> the programs. But I'll give here couple of possible reasons.
> 
> One reason is that someone wants to use the kernel in a
> microkernel-like fashion, implementing keyboard driver in userspace.
> Keyboards sound like a good candidate for userspace because they are
> low-speed. Yeah, I agree there are also reasons why they should not be driven in
> userspace, but don't want to argue now which is better.

For this purpose is console rawmode (the thing this thread was about) is
completely useless, because you cannot feed the data to the console
again.

For that, you need the exported serio interface. [Which means it wasn't
possible on 2.4] I agree exporting serio's as char devices is useful.

> Another reason is that previously Linux didn't offer event-based
> interface to keyboards without raw mode. So, if some program needed to know
> all keypress and release events, the only choice might have been the raw
> mode.

The "medium raw" mode exists since ages, provides keycodes (as opposed
to scancodes), and is used even for X on many non-386 architectures.
This IMO was the right choice. 

> For these programs emulation makes perfect sense for backwards
> compatibility.

Indeed. That's why it's there.

> I was thinking the first reason when I said the above, but the second
> is likely more important in practice.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
