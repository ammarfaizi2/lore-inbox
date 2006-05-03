Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWECX3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWECX3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWECX3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:29:43 -0400
Received: from xenotime.net ([66.160.160.81]:20112 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751392AbWECX3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:29:42 -0400
Date: Wed, 3 May 2006 16:32:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, nils@kernelconcepts.de
Subject: Re: i8xx TCO timer: does not reset my machine
Message-Id: <20060503163207.aac77d39.rdunlap@xenotime.net>
In-Reply-To: <20060501225948.GM1487@cip.informatik.uni-erlangen.de>
References: <20060501225948.GM1487@cip.informatik.uni-erlangen.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 00:59:48 +0200 Thomas Glanzmann wrote:

> Hello everyone,
> I have an Intel board (D915GEV/D915GRF) with an onboard i8xx TCO timer
> watchdog on it. I compiled a kernel and tried to make it reset my
> machine, but it simply doesn't. I use Linus Linux tree (GIT HEAD), the
> following watchdog related configuration:
> 
>         CONFIG_WATCHDOG=y
>         CONFIG_WATCHDOG_NOWAYOUT=y
>         CONFIG_I6300ESB_WDT=y
>         CONFIG_I8XX_TCO=y
> 
> I tried to test the watchdog using the following:
> 
>         cat > /dev/watchdog

*** see below

> and wait a few minutes, but that doesn't reset my machine.  dmesg shows the
> following:
> 
>         (webfarm) [~] dmesg | grep TCO
>         i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
>         i8xx TCO timer: initialized (0x0460). heartbeat=30 sec (nowayout=1)
> 
> lspci is this:
> 
[snip]
> 
> Has somone any ideas, did I do something wrong? From looking at the
> source code it looks like the watchdog is enabled as soon as I open the
> device. And if I don't feed anything in, it shouldn't reload the timer.

TCO watchdog works on my old P-III machine.  After writing to
/dev/watchdog, about 50 (not 30) seconds later, it reboots.

Oh, I see.  Two choices:
use: echo -n 1 > /dev/watchdog
or when you use: cat > /dev/watchdog
and press CR, that doesn't close /dev/watchdog yet.
You need to kill cat (^C) and then /dev/watchdog is closed
and the watchdog timer starts counting.  You will (should) see
a message like so:
  i8xx TCO timer: Unexpected close, not stopping watchdog!
then wait awhile, then it reboots.


---
~Randy
