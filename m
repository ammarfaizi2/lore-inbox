Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWJALyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWJALyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWJALyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:54:18 -0400
Received: from khc.piap.pl ([195.187.100.11]:31634 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932086AbWJALyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:54:17 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>
	<m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 01 Oct 2006 13:54:15 +0200
In-Reply-To: <451EE973.10907@candelatech.com> (Ben Greear's message of "Sat, 30 Sep 2006 15:02:27 -0700")
Message-ID: <m3hcyo2qvs.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> I think if I could support these scenarios below, I would have
> everything I need:
>
> *  Configure T1 as unchannelized bitstream, bridge entire thing to
> second T1.

I think it should be easy with such card, though I think the drivers
can't currently do that.

> *  Configure channels 1-5 as a bitstream and bridge that to channels
> 1-5
> of a second T1.  (random proprietary bit-streaming protocol,

I think the hardware would permit that. Probably needs additional
driver support and I'm not sure about timeslot synchronization (for
HDLC, sync doesn't matter).

>                     would probably bridge HDLC just fine, but handling
> HDLC as frames would be more efficient I think.)

Not sure, maybe yes (less data to bridge due to bit stuffing, flags etc.),
maybe not (variable length of HDLC frame).

>    channels 6-10 configured as an HDLC interface, bridged as HDLC
> frames to channels 6-10 of a second T1. (PPP & other protocols over
> HDLC)
>    channels 10-24 each configured as a separate bit-stream, bridged to
> channels 10-24 on the second T1. (Voice)

I think the above could be a problem - I think common T1/E1 cards
can do only one stream at once.

I wonder if it can be done in software - the hardware framer would
have to pass all data transparently, and it would be demultiplexed,
processed and then multiplexed by the driver. Quite complicated,
but I think at 2 Mbps it wouldn't be a CPU performance problem.

> *  Configure entire T1 as HDLC transport, bridge HDLC frames from one
> T1 to the other.

Easy even with existing drivers I think (no bridge support but it's
trivial).
-- 
Krzysztof Halasa
