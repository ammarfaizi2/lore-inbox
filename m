Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWHGQ71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWHGQ71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHGQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:59:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35475 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932224AbWHGQ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:59:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0C86@USRV-EXCH4.na.uis.unisys.com>
	<200608071817.13318.ak@suse.de>
Date: Mon, 07 Aug 2006 10:58:06 -0600
In-Reply-To: <200608071817.13318.ak@suse.de> (Andi Kleen's message of "Mon, 7
	Aug 2006 18:17:13 +0200")
Message-ID: <m1ac6geb4x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> 4k being a humble maximum is definitely a relative term here, but on the
>> system with "only" 64 or 128 processors the cpu*224 would be much higher
>> :) However, maybe CONFIG_TINY that Andi suggested would leverage this
>> number also. What do you think, Eric?
>
> Best would be something dynamic - kernels should be self tuning, not 
> require that much CONFIG magic.

I agree.  That is the way thing should be :

> Just PCI hotplug gives me headaches with this.
>
> Maybe we just need growable per CPU data.

This would require a growable NR_IRQS to fix.  Something
that we don't have a good handle on at all.  But at least
much less code cares.

If we killed the counters for each pair of cpu and irq this would
not involve the per cpu area at all.  But we still have the one
static array of irqs.  That will be more fun to get rid of.

Eric
