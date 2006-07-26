Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWGZPRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWGZPRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGZPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:17:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWGZPRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:17:10 -0400
To: Neil Horman <nhorman@tuxdriver.com>
Cc: a.zummo@towertech.it, jg@freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
From: Andi Kleen <ak@suse.de>
Date: 26 Jul 2006 17:16:53 +0200
In-Reply-To: <20060725174100.GA4608@hmsreliant.homelinux.net>
Message-ID: <p73bqrc5rbu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> writes:

> 	At OLS last week, During Dave Jones Userspace Sucks presentation, Jim
> Geddys and some of the Xorg guys noted that they would be able to stop using gettimeofday
> so frequently, if they had some other way to get a millisecond resolution timer
> in userspace,

No, no, it's wrong. They should use gettimeofday and the kernel's job
is to make it fast enough that they can. 

Or rather they likely shouldn't use gettimeofday, but clock_gettime()
with CLOCK_MONOTONIC instead to be independent of someone setting the
clock back.

Memory mapped counters are generally not flexible enough and there
are lots of reasons why the kernel might need to do special things
for time keeping. Don't expose them.

-Andi
