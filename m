Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVBXJCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVBXJCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVBXJCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:02:08 -0500
Received: from styx.suse.cz ([82.119.242.94]:4251 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262097AbVBXJCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:02:00 -0500
Date: Thu, 24 Feb 2005 10:03:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050224090338.GA3699@ucw.cz>
References: <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz> <1108973216.5774.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108973216.5774.72.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 09:06:55AM +0100, Kenan Esau wrote:

> > > I also checked my original standalone-driver: Because of this behaviour
> > > I always retried the last command 3 times if the responce from the
> > > device was 0xfe or 0xfc.
> > 
> > And did it actually help? Did the touchscreen ever respond with a 0xfa
> > "ACK, OK" response to these commands?
> 
> I played around a little bit last weekend. And obviously the touchscreen
> always responds 0xfe to the 0xe8 0x07 command. Also repeating the
> command does not really help. After the firxt 0x07 you get back the 0xfe
> and the next byte you send to the device is ALWAYS answered by a
> 0xfc!?!?

This looks like it either expects some other data (like a second
parameter to the command?) or just wants the 0x07 again (and not the
whole command) to make sure you really mean it.

Could you try sending 0xe8 0x07 0x07?

> At the end of this mail you'll find some traces I did.
> 
> I also wonder if it is possible at all to probe this device. I think
> not. IMHO we should go for a module-parameter which enforces the
> lifebook-protokoll. Something like "force_lb=1". Any Ideas /
> suggestions? 

I'd suggest using psmouse.proto=lifebook

> How does this work out with a second/external mouse?

The external mouse has to be in bare PS/2 mode anyway, so we don't need
to care.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
