Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTIJM6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTIJM6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:58:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35978 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262888AbTIJM6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:58:11 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <014a01c3777a$8a2b12e0$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <1063142262.30981.17.camel@dhcp23.swansea.linux.org.uk>
	 <014201c3771d$4e95c160$36af7450@wssupremo>
	 <1063149117.31269.24.camel@dhcp23.swansea.linux.org.uk>
	 <014a01c3777a$8a2b12e0$5aaf7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063198618.32730.43.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 13:56:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 10:04, Luca Veraldi wrote:
> Surely, transferring bytes from a cache line to another is at zero cost
> (that is, a single clock cycle of the cache unit).

More complicated - when you move stuff you end up evicting another chunk
from the cache, you can't armwave that out of existance because you
yourself have created new eviction overhead for someone further down the
line.

> But here, how can you matematically grant that,
> using traditional IPC mechanism,
> you'll find the info you want directly in cache?

Because programs normally pass data they've touched to other apps.
Your A/B example touches the data before sending even, but your
example on receive does not which is very atypical.

> > Ok - from you rexample I couldnt tell if B then touches each byte of
> > data as well as having it appear in its address space.
> 
> It is irrilevant. The time reported in the work are the time needed
> to complete the IPC primitives.
> After a send or a receive over the channel,
> the two processes may do everything they want.
> It is not interesting for us.

Its vital to include it in the measurement of all three. Without it
your measurements are meaningless. Look at it as an engineer. IPC 
involves writing to memory, making the data appear in the other task and
then reading it. You also want to measure things like throughput of your
IPC tasks running parallel to other processes doing stuff like pure
memory bandwidth tests so you can measure the impact you have on the
system although in this case thats probably less relevant by far

