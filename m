Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCAMGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCAMGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVCAMGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:06:36 -0500
Received: from styx.suse.cz ([82.119.242.94]:65239 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261888AbVCAMGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:06:23 -0500
Date: Tue, 1 Mar 2005 13:08:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050301120839.GA5720@ucw.cz>
References: <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz> <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz> <1109664709.18617.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109664709.18617.10.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 09:11:49AM +0100, Kenan Esau wrote:
  
> > This looks like it either expects some other data (like a second
> > parameter to the command?) or just wants the 0x07 again (and not the
> > whole command) to make sure you really mean it.
> > 
> > Could you try sending 0xe8 0x07 0x07?
> 
> My old driver did that. But with the same result. It doesn't seem to
> matter what the first and the second bytes are -- the answers from the
> device are alway the same.

So even 0xe8 0x03 returns error?

Maybe we should send a command after this (any command), to make sure
the 

	psmouse->set_rate(psmouse, psmouse->rate);

call succeeds and is not confused by the 0xfc response.

> > > At the end of this mail you'll find some traces I did.
> > > 
> > > I also wonder if it is possible at all to probe this device. I think
> > > not. IMHO we should go for a module-parameter which enforces the
> > > lifebook-protokoll. Something like "force_lb=1". Any Ideas /
> > > suggestions? 
> > 
> > I'd suggest using psmouse.proto=lifebook
> 
> The current patch has implemented it that way. But the meaning is a
> little bit different. With proto=lifebook you ENFORCE the lifebook
> protocol. As far as I read the meaning of the other ones this does not
> really enforce these protocols.

That's OK. I'd like to keep the DMI probing as well, though, so it's not
absolutely necessary to provide the parameter.

> > > How does this work out with a second/external mouse?
> > 
> > The external mouse has to be in bare PS/2 mode anyway, so we don't need
> > to care.
> 
> Why that?

Can you send any commands to the external mouse? How the touchscreen
reacts when the mouse starts sending 4-byte responses? We process the
external mouse packets inside lifebook.c anyway and we don't have any
support for the enhanced protocols there.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
