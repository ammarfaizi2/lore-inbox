Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTFLXEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFLXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:04:25 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:13990 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265059AbTFLXEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:04:01 -0400
Date: Fri, 13 Jun 2003 01:17:43 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030613005709.A27763@ucw.cz>
Message-ID: <Pine.LNX.4.40.0306130101060.10788-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jun 2003, Vojtech Pavlik wrote:

> > A guestdevice behind the touchpad also needs demultiplexing even with
> > activ multiplexing. This could be done in the synaptics driver but as the
> > guestdevice can be any device, the synaptics driver needs to know every
> > mouse protocol there is to demultiplex it. The synaptics driver sent does
> > not demultiplex a guestdevice.
>
> The synaptics driver, if it wished to demultiplex a true mouse protocol
> behind the pad without an active multiplexing controller, could easily
> create a new serio port, to which the psmouse driver would attach,
> detect, and drive the mouse. It's a bit crazy, but it should work.

hmm, that is clever. But I am afraid it will not work: the master (the
touchpad) must be told how many bytes the guest protocol uses. So it can
not just sent the bytes back and forth. If set wrong the guest is ignored.
(This was probably what was happening a while back when many reported that
the stick did not work: probing for imps2, exps2 etc. is forwarded to the
guest and if the guest knew fx. imps2 it switch protocol, but the master
was not told and ignored the guest)

Peter


