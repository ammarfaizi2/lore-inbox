Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTIBIbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTIBIbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:31:18 -0400
Received: from ee.oulu.fi ([130.231.61.23]:20433 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263688AbTIBIbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:31:14 -0400
Date: Tue, 2 Sep 2003 11:31:07 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4, b44 transmit timeout
Message-ID: <20030902083107.GA4065@ee.oulu.fi>
References: <20030901193235.GA8280@gamma.logic.tuwien.ac.at> <20030901200022.GA3070@ee.oulu.fi> <20030902073353.GA935@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030902073353.GA935@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:33:53AM +0200, Norbert Preining wrote:
> * pinging the gateway (.1.1), working
> Sep  2 09:20:22 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5d82 entry: 0 skb: d935b480
> Sep  2 09:20:22 gandalf vmunix: b44_tx cons: 0 cur: 1 skb: d935b480
> Sep  2 09:20:22 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 1 skb: d935b680
> Sep  2 09:20:22 gandalf vmunix: b44_tx cons: 1 cur: 2 skb: d935b680
> Sep  2 09:20:23 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 2 skb: d935b480
> Sep  2 09:20:23 gandalf vmunix: b44_tx cons: 2 cur: 3 skb: d935b480
> Sep  2 09:20:24 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 3 skb: d935b480
> Sep  2 09:20:24 gandalf vmunix: b44_tx cons: 3 cur: 4 skb: d935b480
> Sep  2 09:20:25 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 4 skb: d935b480
> Sep  2 09:20:25 gandalf vmunix: b44_tx cons: 4 cur: 5 skb: d935b480
> Sep  2 09:20:26 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 5 skb: d935b480
> Sep  2 09:20:26 gandalf vmunix: b44_tx cons: 5 cur: 6 skb: d935b480
> Sep  2 09:20:27 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5082 entry: 6 skb: d935ba80
> Sep  2 09:20:27 gandalf vmunix: b44_tx cons: 6 cur: 7 skb: d935ba80
> Sep  2 09:20:27 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 7 skb: d935ba80
> Sep  2 09:20:27 gandalf kernel: b44_tx cons: 7 cur: 8 skb: d935ba80
> Sep  2 09:20:28 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 8 skb: d935b480
> Sep  2 09:20:28 gandalf kernel: b44_tx cons: 8 cur: 9 skb: d935b480
> Sep  2 09:20:29 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 9 skb: d935b480
> Sep  2 09:20:29 gandalf kernel: b44_tx cons: 9 cur: 10 skb: d935b480
> * stopping ping, ifconfig eth0 down, starting pump for getting dhcp
> * address, no success!
> Sep  2 09:20:41 gandalf pumpd[7584]: starting at (uptime 0 days, 2:04:19) Tue Sep  2 09:20:41 2003  
> Sep  2 09:20:41 gandalf pumpd[7584]: PUMP: sending discover 
> Sep  2 09:20:44 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
> Sep  2 09:20:44 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.
A-ha! Thanks, I think this should be enough to figure out what the problem
is... Looks like the driver doesn't even get the packets pump tries to send,
pump is a bit special in the way it bounces the interface up and down when
doing its work, that probably triggers a race in b44..

