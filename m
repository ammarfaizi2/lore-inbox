Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965734AbWKHN2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965734AbWKHN2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 08:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965737AbWKHN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 08:28:43 -0500
Received: from dpc691978010.direcpc.com ([69.19.78.10]:20191 "EHLO
	third-harmonic.com") by vger.kernel.org with ESMTP id S965734AbWKHN2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 08:28:43 -0500
Message-ID: <4551DBA0.6080305@third-harmonic.com>
Date: Wed, 08 Nov 2006 08:29:04 -0500
From: john cooper <john.cooper@third-harmonic.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: dwalker@mvista.com
CC: Kevin Hilman <khilman@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@third-harmonic.com>
Subject: Re: 2.6.18-rt7: rollover with 32-bit cycles_t
References: <4551348B.6070604@mvista.com> <1162956221.20694.13.camel@dwalker1.mvista.com>
In-Reply-To: <1162956221.20694.13.camel@dwalker1.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

> Seems like the check should really be using something like time_before()
> time_after() which takes the rollover into account .. What I don't
> understand is why we don't see those on x86 ..

Probably due to the fact it is a 64-bit counter.  Even with
a free running rate of 10Ghz it would take nearly 60 years
to wrap.

On PPC and ARM 32-bit counters seems to be common which limits
range unless a prescaler is available.  The better solution is
to detect wrap as a prescaled 32 bit measurement will eventually
run out of usable resolution as core frequency increases.  That is
assuming 64-bit counters don't eventually show up in these
architectures.

-john

-- 
john.cooper@third-harmonic.com
