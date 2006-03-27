Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWC0Txw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWC0Txw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWC0Txw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:53:52 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48332 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750975AbWC0Txw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:53:52 -0500
Date: Mon, 27 Mar 2006 21:53:29 +0200
Message-Id: <200603271953.k2RJrTR28039@inv.it.uc3m.es>
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uptime increases during suspend
X-Newsgroups: gmane.linux.kernel
In-Reply-To: <1143484821.2168.16.camel@leatherman>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1143484821.2168.16.camel@leatherman> you wrote:
>> Would it be possible to get the old behaviour back?

> Why exactly do you want this behavior? Maybe a better explanation would
> help stir this discussion.

I don't know why he wants it (uptime does not increase during
hibernation) but I want it so that I can tell if I should time out or
not on an alarm for inactivity in userspace!  The alarm should fire if
there has been no activity for a while (30s) while activity is possible.
If the machine is suspended, no activity is possible, so the alarm
should not fire.

This is to counteract sysadamins playing with system time (e.g. syncing
with a net time server after bootup) which might cause artificial time
outs. Causing a timeout has nasty consequences when, for example, your
root fs is mounted over the net via daemons that do the network to-ing
and fro-ing from userspace. The only way they have of getting an
estimate of REAL time elapsed,  without admin playing about messing
with them, is by surreptitiously snooping uptime, which more or less
represents kernel jiffies.

If you change uptime to not represente kernel jiffies, goodbye the last
hope for counting CPU time passed from userspace. False timeouts WILL
ensue, and root mounts will fail.

Peter
