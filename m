Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWAKFvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWAKFvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWAKFvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:51:35 -0500
Received: from main.gmane.org ([80.91.229.2]:26536 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932553AbWAKFvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:51:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: SysReq & serial console
Date: Wed, 11 Jan 2006 14:51:12 +0900
Message-ID: <dq26cg$3el$1@sea.gmane.org>
References: <43B8696B.2070303@gmx.de> <dpakp2$tip$3@sea.gmane.org> <20060102091808.GA11673@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060110)
X-Accept-Language: en-us, en
In-Reply-To: <20060102091808.GA11673@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jan 02, 2006 at 04:29:38PM +0900, Kalin KOZHUHAROV wrote:
> 
>>Another wild guess: the syslog is still running and writes the output to
>>the log.
> 
> 
> I don't think syslog can influence whether you see sysrq output via the
> console.  Nevertheless, try sysrq-8 before other sysrq functions.
> 
While playing with a borked 2.6.15 box and syslog-ng, I ran across this again.

The issue is that syslog-ng can use /proc/kmesg as a source for logging and
if this is the case, then (intentionally or not), it sucks all the MSGs and
if not setup correctly MSGs from kernel will go to nowhere. The relevant
syslog-ng setup is:

source foo { pipe("/proc/kmsg"); };

This might be a problem/feature/bug with syslog-ng, but I still find it more
natural to see the output of SysRq and oopses on the console as well.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

