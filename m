Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWIKTQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWIKTQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWIKTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:16:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:17149 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964969AbWIKTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:16:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Misha Tomushev" <misha@fabric7.com>
Subject: Re: [PATCH] VIOC: New Network Device Driver
Date: Mon, 11 Sep 2006 21:15:52 +0200
User-Agent: KMail/1.9.1
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <003c01c6d5cb$e00fd850$7501a8c0@ZINLAPTOP>
In-Reply-To: <003c01c6d5cb$e00fd850$7501a8c0@ZINLAPTOP>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112115.53520.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 19:58, Misha Tomushev wrote:
> The descriptor clean-up does not contribute anything to the performance
> of the driver, it just replenishes the memory pools. It almost does not
> need interrupts. Why would we want to add more cycles to the receive
> logic, when driver is doing useful work for something that can run
> almost at any time?

It can run at almost any time, just not in the interrupt context,
where it needs to schedule the tx softirq first.

Also, the number of tx interrupts you get is a tradeoff between
causing overhead of calling the interrupt handler and stalling
sockets that are waiting for space to become free after transmission.
By using ->poll for it, you can avoid tx interrupts completely
most of the time and free skbs immediately when data comes in.

	Arnd <><
