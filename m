Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSCDWmV>; Mon, 4 Mar 2002 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWmM>; Mon, 4 Mar 2002 17:42:12 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31426 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292688AbSCDWmC>;
	Mon, 4 Mar 2002 17:42:02 -0500
Date: Mon, 4 Mar 2002 14:42:00 -0800
To: paulus@samba.org, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PPP feature request (Tx queue len + close)
Message-ID: <20020304144200.A32397@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	While working with IrNET, I came across one problems that
would require some changes minor to the ppp_generic kernel code. I
will describe this feature and then we can start to flame each other
or discuss how to implement them.

	IrNET is PPP over an IrDA socket. A good analogy would be PPP
over TCP/IP. If you thing in those terms, you will get the proper
context. IrNET is a PPP driver hooking directly in ppp_generic.

Tx queue length
---------------
	Problem : IrDA does its buffering (IrTTP is a sliding window
protocol). PPP does its buffering (1 packet in ppp_generic +
dev->tx_queue_len = 3). End result : a large number of packets queued
for transmissions, which result in some network performance issues.

	Solution : could we allow the PPP channel to overwrite
dev->tx_queue_len ?
	This is similar to the channel beeing able to set the MTUs and
other parameters...

	Have fun...

	Jean
