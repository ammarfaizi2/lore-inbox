Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031208AbWI0XEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031208AbWI0XEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031212AbWI0XEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:04:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48304 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1031208AbWI0XEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:04:31 -0400
Date: Thu, 28 Sep 2006 01:04:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exponential update_wall_time
In-Reply-To: <1159385734.29040.9.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609280031550.6761@scrub.home>
References: <1159385734.29040.9.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Sep 2006, john stultz wrote:

> Accumulate time in update_wall_time exponentially. 
> This avoids long running loops seen with the dynticks patch
> as well as the problematic hang" seen on systems with broken 
> clocksources.

This is the wrong approach, second_overflow() should be called every HZ
increment steps and your patch breaks this.
There are other approaches oo accommodate dyntick. 
1. You could make HZ in ntp_update_frequency() dynamic and thus reduce the 
frequency with which update_wall_time() needs to be called (Note that 
other clock variables like cycle_interval have to be adjusted as well). 
2. If dynticks stops the timer interrupt for a long time, it could 
precalculate a few things, e.g. it could complete the second and then 
advance the time in full seconds.

bye, Roman
