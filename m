Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVBMMAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVBMMAj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 07:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVBMMAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 07:00:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15517 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261263AbVBMMA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 07:00:26 -0500
Date: Sun, 13 Feb 2005 13:01:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050213120100.GB1978@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108227679.12327.24.camel@localhost> <20050212183440.GC8170@ucw.cz> <1108289100.5978.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108289100.5978.18.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 11:05:00AM +0100, Kenan Esau wrote:
 
> > > This
> > > sequence does not always work and there is not something like a "magic
> > > knock sequence".
> > 
> > You mean that the only needed bit is setting the resolution to '7'?
> 
> The lifebook touchscreen has some extensions to the standard protocol:
> 
> 0xe8 0x06: Stop absolute coordinate output 
> 0xe8 0x07: Start absolute coordinate outpout (3-byte packets)
> 0xe8 0x08: Start absolute coord. output with 6-byte packets

Are the 6-byte packets carrying any more information than the 3-byte
packets do, for example pressure? Would it be useful to go for the
6-byte mode instead in the driver?

Have you tried whether the controller responds to the GETID (f2),
GETINFO (e9) and POLL (eb) commands? Maybe we could detect it that way.

Did you try to test all possible commands (from 0xe0 to 0xff) to check
what commands the lifebook hw accepts?

> > > The lifebook-touchscreen hardware is a little bit slow
> > > and it happens quite often that it does not understand a command that
> > > you send.
> > 
> > I don't believe this - the PS/2 protocol has handshakes for both sides,
> > so each side can slow down as much as it wants. PLUS, the clock is
> > driven by the device.
> 
> I dont't know the PS2-specs. But I know the lifebook hardware quite
> well. While implementing my driver (for xfree 4.0 at that time) I
> noticed that it happens often that the device came back with an error or
> resend. I fixed this by just waiting a short time and then retry.

serio with libps2 now is a very solid foundation that makes sure the
commands are issued and waited for correctly. It is however possible
that the lifebook hardware will still need some workarounds.

> If you agree I will take your patch as the basis and make it work. Now I
> know how you want it to look like.

That would be very much appreciated.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
