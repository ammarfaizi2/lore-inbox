Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIUQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIUQZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUIUQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:25:04 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:26825 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S267810AbUIUQY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:24:56 -0400
Date: Tue, 21 Sep 2004 18:16:50 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Add on-demand cpu-freq governor as default option
Message-ID: <20040921161650.GA8119@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <cone.1095649950.909900.10443.502@pc.kolivas.org> <20040920170216.GA7952@dominikbrodowski.de> <cone.1095720189.669330.22937.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1095720189.669330.22937.502@pc.kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 21, 2004 at 08:43:09AM +1000, Con Kolivas wrote:
> 1. Would it be inappropriate to make it drop back to a different governor 
> so that it can be selected?

This would involve major changes to the cpufreq core, and it wouldn't make
it easier. I'll add it to my TODO list and think about it again once more
important issues are adressed. Agreed?

> 2. Can cpu throttling be incorporated into this governor as well as a 
> secondary mechanism for the lowest cpu frequency and as a primary 
> mechanism for those cpus that don't support cpufreq?

a) it hasn't to do anything with the _governor_. The governor works with
whatever method is offered to him, may it be frequency scaling or
throttling. Actually, some CPUfreq drivers actually only do throttling, and
you can use ondemand for them [if their latency values are set correctly,
that is].

b) on-demand throttling is useless. Throttling sets the CPU to the same
internal power state as the ACPI idle state C2 does [and C2 has quite the
same energy consumption as C1, actually...], so lowering the time spent
idling and increasing throttling doesn't save energy, while lowering idling
and increasing frequency scaling does save much energy. 

c) As throttling does make sense for thermal management and certain energy
consumption requirements [e.g. the battery isn't strong enough for the CPU
running at 100%], adapting the CPUfreq core to support loading one frequency
scaling and one frequency throttling driver at the same time is something I
have in my TODO list as well. Nonetheless, it will not be made available for
"on-demand" throttling, unless I'm convinced otherwise.

Thanks,
	Dominik
