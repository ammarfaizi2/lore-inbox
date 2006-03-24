Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWCXOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWCXOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCXOd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:33:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:15800 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751153AbWCXOd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:33:26 -0500
To: "Jan Beulich" <jbeulich@novell.com>
Cc: <mark.langsdorf@amd.com>, <davej@redhat.com>,
       "Pavel Machek" <pavel@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel crash in powernow-k8 after lost ticks detected
References: <441EB1990200007800013DB9@emea1-mh.id2.novell.com>
From: Andi Kleen <ak@suse.de>
Date: 24 Mar 2006 15:33:18 +0100
In-Reply-To: <441EB1990200007800013DB9@emea1-mh.id2.novell.com>
Message-ID: <p73fyl76hg1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> writes:

> Since powernowk8_cpu_init() gets called only for one of the two cores (the
> other one is in the same policy set and hence cpufreq_add_dev() prevents the
> call), calling other functions, namely powernowk8_get(), one CPUs that haven't
> been initialized will yield a NULL from the respective powernow_data[] slot. In
> the specific case, the problem occured after the system detected some lost
> ticks and called cpufreq_get() for all CPUs.
> While I can imagine more sophisticated fixes for this (it namely seems
> questionable whether calling the init routines not on all CPUs, or, if that's
> necessary, whether not properly setting up the data pointers for all affected
> CPUs in powernow-k8 is okay), below simple change seems to address the
> problem (the other hunk is to make a message more meaningful).

I already have a patch queued for this - also ran into it.
But I did it slightly differently by making sure powernow_data[] is valid
for all cores.

-Andi
