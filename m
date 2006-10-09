Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWJIUoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWJIUoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWJIUoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:44:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:44505 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964838AbWJIUoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:44:25 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Net] Kernel renams eth0 -> eth7
Date: Mon, 9 Oct 2006 13:43:45 -0700
Organization: OSDL
Message-ID: <20061009134345.0b3fc420@freekitty>
References: <20061009201806.GA5723@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1160426626 22575 10.8.0.54 (9 Oct 2006 20:43:46 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 9 Oct 2006 20:43:46 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 22:18:06 +0200
Nico Schottelius <nico-kernel20061009@schottelius.org> wrote:

> Hello!
> 
> I am runnig 2.6.17.13 on a Geode, with 3 natsemi ports onboard
> and 4 ports in a pci card (soekris net4801).
> 
> The strange thing is, that it currently renames eth0 to eth7
> and eth1 to eth8 (or somehow different).
> 
> Have a look at [0] for dmesg output. You'll see this:
> 
> --------------------------------------------------------------------------------
> [   64.643627] natsemi eth0: NatSemi DP8381[56] at 0xa0000000
> (0000:00:06.0), 00:00:24:c5:69:5c, IRQ 10, port TP.
> [   64.676833] natsemi eth1: NatSemi DP8381[56] at 0xa0001000
> (0000:00:07.0), 00:00:24:c5:69:5d, IRQ 10, port TP.
> [   64.710006] natsemi eth2: NatSemi DP8381[56] at 0xa0002000
> (0000:00:08.0), 00:00:24:c5:69:5e, IRQ 10, port TP.
> [   64.743402] natsemi eth3: NatSemi DP8381[56] at 0xa4000000
> (0000:01:00.0), 00:00:24:c4:fd:14, IRQ 5, port TP.
> [   64.776463] natsemi eth4: NatSemi DP8381[56] at 0xa4001000
> (0000:01:01.0), 00:00:24:c4:fd:15, IRQ 11, port TP.
> [   64.809891] natsemi eth5: NatSemi DP8381[56] at 0xa4002000
> (0000:01:02.0), 00:00:24:c4:fd:16, IRQ 5, port TP.
> [   64.842982] natsemi eth6: NatSemi DP8381[56] at 0xa4003000
> (0000:01:03.0), 00:00:24:c4:fd:17, IRQ 11, port TP.
> --------------------------------------------------------------------------------
> 
> which is correct. Later you see this:
> --------------------------------------------------------------------------------
> [  122.142761] eth8: DSPCFG accepted after 0 usec.
> [  122.156411] eth8: link up.
> [  122.164584] eth8: Setting full-duplex based on negotiated link
> capability.
> [  122.719529] eth8: remaining active for wake-on-lan
> [  122.927613] eth8: DSPCFG accepted after 0 usec.
> [  122.941269] eth8: link up.
> --------------------------------------------------------------------------------
> which feels really strange, because eth0 and eth1 simply
> 'disappeared'.
> 
> More information about the device can be found at [1]
> 
> My questions are:
> 
>    - why is it getting renamed and why did it not happen some boots
>      (before I moved) before (like in [2])?
>    
>    - how can I tell the kernel NOT to rename it anymore / what
>      must I fix?
> 
> Any hints appreciated.

Look at the hotplug scripts, that is probably what is doing it
in user space.  Or you could add a hook to dump the caller to
dev_change_name() in net/core/dev.c. 

-- 
Stephen Hemminger <shemminger@osdl.org>
