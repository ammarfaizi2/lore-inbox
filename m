Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULHTvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULHTvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbULHTvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:51:33 -0500
Received: from mail.timesys.com ([65.117.135.102]:12952 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261333AbULHTvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:51:15 -0500
Message-ID: <41B75A94.90709@timesys.com>
Date: Wed, 08 Dec 2004 14:48:36 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <200412071340.42731.gene.heskett@verizon.net> <20041207214715.GB12879@elte.hu> <200412072005.37486.gene.heskett@verizon.net>
In-Reply-To: <200412072005.37486.gene.heskett@verizon.net>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2004 19:43:45.0171 (UTC) FILETIME=[3A858630:01C4DD5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

> ...I'd had that happen twice
> before and panic'd, even hitting the reset button once and doing a
> cold powerdown once, this before I noticed there was some disk
> activity going on, so I figured what the hell and walked away to go
> see what the missus was watching on the telly.  And when I came back
> half an hour later I was looking at a login prompt once I'd moved the 
> mouse.

Interesting to read the above.  I found similar
repeatable behavior when I launched a "make -j"
build on an arbitrary kernel tree when running
-V0.7.32-2.  I originally suspected the OOM
behavior to differ (somehow) with the 32-2 patch
compared to vanilla 2.6.10-rc2-mm3, but that was
a red herring.

I did notice the OOM killer nailing procs such as
sendmail, portmap, syslogd, lpd, etc..  fairly
early on in the build.  Eventually the login sh
got nailed and getty was respawned by init to play
again.  In oom_kill.c:badness(), 0 uid procs
should be given a limited stay, unless you run a
sprawling test load as root as I had.  This puts
everything into the same badness()-space and sys
daemons are equally likely to get wacked.

-john


-- 
john.cooper@timesys.com
