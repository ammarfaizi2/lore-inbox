Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWFVNjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWFVNjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWFVNjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:39:01 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:44779 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750947AbWFVNjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:39:01 -0400
Message-ID: <449A9ADC.9070800@draigBrady.com>
Date: Thu, 22 Jun 2006 14:27:56 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Dropping Packets in 2.6.17
References: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com>
In-Reply-To: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> I'm trying to make a case for using linux as a
> network appliance, but I can't find any
> combination of settings that will keep it from
> dropping packets at an unacceptably high rate.
> The test system is a 1.8Ghz Opteron with intel
> gigE cards running 2.6.17. I'm passing about 70K
> pps through the box, which is a light load, but
> userland activities (such as building a kernel)
> cause it to lose packets, even with backlog set
> to 20000. I had the same problem with 2.6.12 and
> abandoned the effort. Has anything been done
> since to give priority to networking? You can't
> have a network appliance drop packets when some
> application is gathering stats or a user is
> looking at a graph. What tunings are available?

For reference with 2.4.20 on a dual 3.4GHz xeon
and 2 x e1000 cards, I was able to capture, classify
and do sophisticated statistical calculations on
625Kpps per interface (1.3 million packets per second).
The bottleneck at this point was memory bandwidth.
Allowing some drops the average rate went up to the
PCI bottleneck of about 850kpps/port.
Classification and Computation was done in userspace.

Note there is a max interrupt rate of around 80K/s
on x86 at least (not sure about opteron), so make
sure you're using NAPI. /proc/interrupts will
show your interrupt rate.

If the packets go to userspace, make sure you're using
CONFIG_PACKET_MMAP

Pádraig.
