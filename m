Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUBLJmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 04:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbUBLJmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 04:42:18 -0500
Received: from denise.shiny.it ([194.20.232.1]:10958 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S265729AbUBLJmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 04:42:17 -0500
Message-ID: <XFMail.20040212104215.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20040212022314.GS4478@dualathlon.random>
Date: Thu, 12 Feb 2004 10:42:15 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Feb-2004 Andrea Arcangeli wrote:

> the main difference is that 2.4 isn't in function of time, it's in
> function of requests, no matter how long it takes to write a request,
> so it's potentially optimizing slow devices when you don't care about
> latency (deadline can be tuned for each dev via
> /sys/block/*/queue/iosched/).

IMHO it's the opposite. Transfer speed * seek time of some
slow devices is lower than fast devices. For example:

Hard disk  raw speed= 40MB/s   seek time =  8ms
MO/ZIP     raw speed=  3MB/s   seek time = 25ms

One seek of HD costs about 320KB, while on a slow drive it's
only 75KB. 2.4 has a terrible latency on slow devices, and it
has very small advantage in terms of speed. On CDs and DVDs
the cost of a seek is much higher, but since the data is
usually accessed sequentially you have the high latency
penalty with no appreciable speed gain in this case too.


--
Giuliano.
