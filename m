Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVCGHel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVCGHel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCGHbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:31:51 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:33237 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261673AbVCGH3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:29:06 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050301120839.GA5720@ucw.cz>
References: <1108578892.2994.2.camel@localhost>
	 <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost>
	 <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz>
	 <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz>
	 <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz>
	 <1109664709.18617.10.camel@localhost>  <20050301120839.GA5720@ucw.cz>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 08:27:16 +0100
Message-Id: <1110180436.3444.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response.

Am Dienstag, den 01.03.2005, 13:08 +0100 schrieb Vojtech Pavlik:
> On Tue, Mar 01, 2005 at 09:11:49AM +0100, Kenan Esau wrote:
>   
> > > This looks like it either expects some other data (like a second
> > > parameter to the command?) or just wants the 0x07 again (and not the
> > > whole command) to make sure you really mean it.
> > > 
> > > Could you try sending 0xe8 0x07 0x07?
> > 
> > My old driver did that. But with the same result. It doesn't seem to
> > matter what the first and the second bytes are -- the answers from the
> > device are alway the same.
> 
> So even 0xe8 0x03 returns error?

No -- I meant only 0xe8 0x07 and 0xe8 0x06 . For those it doesn't matter
if you repeat the parameter or send something else. The answers from the
device for those command/parameters are always the same.

> Maybe we should send a command after this (any command), to make sure
> the 
> 
> 	psmouse->set_rate(psmouse, psmouse->rate);
> 
> call succeeds and is not confused by the 0xfc response.

OK -- I will send the command after 0xe8 0x07 twice.

> > > > At the end of this mail you'll find some traces I did.
> > > > 
> > > > I also wonder if it is possible at all to probe this device. I think
> > > > not. IMHO we should go for a module-parameter which enforces the
> > > > lifebook-protokoll. Something like "force_lb=1". Any Ideas /
> > > > suggestions? 
> > > 
> > > I'd suggest using psmouse.proto=lifebook
> > 
> > The current patch has implemented it that way. But the meaning is a
> > little bit different. With proto=lifebook you ENFORCE the lifebook
> > protocol. As far as I read the meaning of the other ones this does not
> > really enforce these protocols.
> 
> That's OK. I'd like to keep the DMI probing as well, though, so it's not
> absolutely necessary to provide the parameter.

You mean if the device is in the appropriate DMI-database use the
lifebook protocol and if the parameter is provided use it also (although
it might not be in the DMI database)? 

> > > > How does this work out with a second/external mouse?
> > > 
> > > The external mouse has to be in bare PS/2 mode anyway, so we don't need
> > > to care.
> > 
> > Why that?
> 
> Can you send any commands to the external mouse? How the touchscreen
> reacts when the mouse starts sending 4-byte responses? 

No idea yet -- I will test this.

> We process the
> external mouse packets inside lifebook.c anyway and we don't have any
> support for the enhanced protocols there.

Ah OK. 

I personally never used an external mouse. But last weekend I played
around a little bit and recognized that there are some BIOS-settings
which control the behavior of the touchscreen, quickpoint-device and
external mouse. I have to play around with those a little bit more. But
as far as I can see you can never have all three at the same time.


