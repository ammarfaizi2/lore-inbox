Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbVBFI3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbVBFI3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbVBFI3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:29:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:39654 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S268480AbVBFI3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:29:01 -0500
Date: Sun, 6 Feb 2005 09:29:21 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Message-ID: <20050206082921.GB8642@ucw.cz>
References: <200502051448.57492.dtor_core@ameritech.net> <20050205211136.GB8451@ucw.cz> <200502060029.21068.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502060029.21068.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 12:29:20AM -0500, Dmitry Torokhov wrote:
> On Saturday 05 February 2005 16:11, Vojtech Pavlik wrote:
> > On Sat, Feb 05, 2005 at 02:48:56PM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > The patch below attempts to better handle situation when psmouse interrupt
> > > is delayed for more than 0.5 sec by requesting a resend. This will allow
> > > properly synchronize with the beginning of the packet as mouse is supposed
> > > to resend entire package.
> > 
> > Have you actually tested the mouse is really sending the whole packet?
> > I'd suspect it could just resend the last byte. :I Maybe using the
> 
> Well, I did test and my touchpad behaved properly. But then I tried 2 external
> mice and they are both sending ACK (and they should not) and then the last byte
> only. So I guess we'll have to scrap using 0xfe idea...
> 
> > GET_PACKET command would be more useful in this case.
> >
> 
> Are you talking about 0xeb?

Yes, sorry for the wrong name, it should've been "CMD_POLL".

> We could also try sending "set stream" mode as a sync marker...

That's an interesting idea, too. But I suspect we'll also have to turn
the stream mode off first (CMD_DISABLE).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
