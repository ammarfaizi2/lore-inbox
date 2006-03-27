Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWC0WbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWC0WbC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWC0WbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:31:02 -0500
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:52626 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S1751144AbWC0WbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:31:00 -0500
Message-ID: <44286783.9000709@tremplin-utc.net>
Date: Tue, 28 Mar 2006 00:30:27 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
CC: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: uptime increases during suspend
References: <200603271953.k2RJrTR28039@inv.it.uc3m.es>
In-Reply-To: <200603271953.k2RJrTR28039@inv.it.uc3m.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv5.univ-lille1.fr [193.49.225.19]); Tue, 28 Mar 2006 00:30:37 +0200 (CEST)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

27.03.2006 21:53, Peter T. Breuer wrote/a écrit:
> In article <1143484821.2168.16.camel@leatherman> you wrote:
>>> Would it be possible to get the old behaviour back?
> 
>> Why exactly do you want this behavior? Maybe a better explanation would
>> help stir this discussion.
> 
> I don't know why he wants it (uptime does not increase during
> hibernation) but I want it so that I can tell if I should time out or
> not on an alarm for inactivity in userspace!  The alarm should fire if
> there has been no activity for a while (30s) while activity is possible.
> If the machine is suspended, no activity is possible, so the alarm
> should not fire.
> 
> This is to counteract sysadamins playing with system time (e.g. syncing
> with a net time server after bootup) which might cause artificial time
> outs. Causing a timeout has nasty consequences when, for example, your
> root fs is mounted over the net via daemons that do the network to-ing
> and fro-ing from userspace. The only way they have of getting an
> estimate of REAL time elapsed,  without admin playing about messing
> with them, is by surreptitiously snooping uptime, which more or less
> represents kernel jiffies.
It seems that what you are really looking for in your application is a 
monotonic clock. Linux has such thing since few releases. Using 
CLOCK_MONOTONIC (cf "man 3 clock_gettime") may look much less hacky than 
using the uptime ;-)

Now... concerning the suspend effect on this clock, I don't know. It's 
probably the same problem as uptime: no official semantic has ever been 
stated yet... Does anyone know?

Eric
