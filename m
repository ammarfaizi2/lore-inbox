Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbTFLXOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbTFLXOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:14:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:43714 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265056AbTFLXOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:14:03 -0400
Date: Fri, 13 Jun 2003 01:27:46 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030613012746.A28341@ucw.cz>
References: <20030613005709.A27763@ucw.cz> <Pine.LNX.4.40.0306130101060.10788-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0306130101060.10788-100000@shannon.math.ku.dk>; from pebl@math.ku.dk on Fri, Jun 13, 2003 at 01:17:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 01:17:43AM +0200, Peter Berg Larsen wrote:
> 
> On Fri, 13 Jun 2003, Vojtech Pavlik wrote:
> 
> > > A guestdevice behind the touchpad also needs demultiplexing even with
> > > activ multiplexing. This could be done in the synaptics driver but as the
> > > guestdevice can be any device, the synaptics driver needs to know every
> > > mouse protocol there is to demultiplex it. The synaptics driver sent does
> > > not demultiplex a guestdevice.
> >
> > The synaptics driver, if it wished to demultiplex a true mouse protocol
> > behind the pad without an active multiplexing controller, could easily
> > create a new serio port, to which the psmouse driver would attach,
> > detect, and drive the mouse. It's a bit crazy, but it should work.
> 
> hmm, that is clever. But I am afraid it will not work: the master (the
> touchpad) must be told how many bytes the guest protocol uses. So it can
> not just sent the bytes back and forth. If set wrong the guest is ignored.
> (This was probably what was happening a while back when many reported that
> the stick did not work: probing for imps2, exps2 etc. is forwarded to the
> guest and if the guest knew fx. imps2 it switch protocol, but the master
> was not told and ignored the guest)

That's sad. Anyway, we'll have to find a solution for this. Either the
synaptics driver parsing the communication on the new serio port (which
isn't as complex as it looks) and detecting the packet length from that,
or some way the psmouse driver can tell it what packet size it uses.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
