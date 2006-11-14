Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966471AbWKNXX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966471AbWKNXX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966469AbWKNXX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:23:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966467AbWKNXX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:23:57 -0500
Date: Tue, 14 Nov 2006 15:23:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: eli@dev.mellanox.co.il
Cc: eli@dev.mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: UDP packets loss
Message-ID: <20061114152341.24861967@freekitty>
In-Reply-To: <38090.194.90.237.34.1163545721.squirrel@dev.mellanox.co.il>
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
	<20061114143531.2ee7eae0@freekitty>
	<38090.194.90.237.34.1163545721.squirrel@dev.mellanox.co.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 01:08:41 +0200 (IST)
eli@dev.mellanox.co.il wrote:

> Thanks for the commets.
> I actually use UDP because I am seeking for ways to improve the
> performance of IPOIB and I wanted to avoid TCP's flow control. I am really
> up to making anaysis. Can you tell me more about irqbalnced?

Look for info on irqbalance (depends which linux distribution you
are using). You might not be running it at all, and it is completely
optional. There is also a kernel level IRQ balancer that may or
may not be configured.

> Where can I
> find more info how to control it? 

man irqbalance

Note: irqbalance has heuristics about device names and driver names,
it might be worthwhile to either update the source and teach it about
infiniband, or work with existing heuristics (ie. call your interrupt "eth0", "eth1",...)


>I would like my interrupts serviced by
> all CPUs in a somehow equal manner. I mentioned MSIX - the driver already
> make use of MSIX and I thought this is relevant to interrupts affinity.

MSIX is not directly related to affinity. But with MSIX you can have multiple
CPU's all working at once. The device needs to return some info, and the driver
has to register multiple times.

Regular round-robin of network IRQ's is cache hostile, and that is why
irqbalance tries to keep them on the same processor.
