Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTHONLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTHONLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:11:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:43148 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263752AbTHONLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:11:36 -0400
Date: Fri, 15 Aug 2003 15:10:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815131040.GA15706@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815130450.GF15911@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815130450.GF15911@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:04:50PM +0100, Jamie Lokier wrote:
> Andries Brouwer wrote:
> > Yes, it would still be considered down. But that does not imply
> > that pressing it doesnt do anything. It is up to the driver
> > to discard key presses, and I think it shouldnt.
> > (Unless of course the user asks for that behaviour - it may be required
> > on some broken laptops.)
> 
> It should discard multiple presses of the same key in very rapid
> succession, when that is immediately after the first press of that
> key.  (After a time has passed, rapid successive presses are due to
> auto-repeat, which is ok).
> 
> Several laptops seem to send a key down event 3, 5 or very many times
> in response to a single press.

One way this could be handled fairly nicely (although the method is
maybe too clever to be good) would be to leave the autorepeat up to the
sw, ignore any successive presses without a release and watch whether
the keyboard will start autorepeating the key after 250 msec. If it does
not, then force the key to be released even if we got no release
scancode.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
