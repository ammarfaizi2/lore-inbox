Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933479AbWKNWfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479AbWKNWfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933488AbWKNWfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:35:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933479AbWKNWfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:35:38 -0500
Date: Tue, 14 Nov 2006 14:35:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: eli@dev.mellanox.co.il
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: UDP packets loss
Message-ID: <20061114143531.2ee7eae0@freekitty>
In-Reply-To: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 00:15:47 +0200 (IST)
eli@dev.mellanox.co.il wrote:

> Hi,
> I am running a client/server test app over IPOIB in which the client sends
> a certain amount of data to the server. When the transmittion ends, the
> server prints the bandwidth and how much data it received. I can see that
> the server reports it received about 60% that the client sent. However,
> when I look at the server's interface counters before and after the
> transmittion, I see that it actually received all the data that the client
> sent. This leads me to suspect that the networking layer somehow dropped
> some of the data. One thing to not - the CPU is 100% busy at the receiver.
> Could this be the reason (the machine I am using is 2 dual cores - 4
> CPUs).

If receiver application can't keep up UDP drops packets. The counter
receive buffer errors (UDP_MIB_RCVBUFERRORS) is incremented.

Don't expect flow control or reliable delivery; it's a datagram service!

> The secod question is how do I make the interrupts be srviced by all CPUs?
> I tried through the procfs as described by IRQ-affinity.txt but I can set
> the mask to 0F bu then I read back and see it is indeed 0f but after a few
> seconds I see it back to 02 (which means only CPU1).

Most likely, the user level irq balance daemon (irqbalanced) is adjusting it?

> 
> One more thing - the device I am using is capable of generating MSIX
> interrupts.
> 

Look at device capabilities with:

	lspci -vv


-- 
Stephen Hemminger <shemminger@osdl.org>
