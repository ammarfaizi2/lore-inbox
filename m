Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWGYVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWGYVGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGYVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:06:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932318AbWGYVGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:06:30 -0400
Date: Tue, 25 Jul 2006 13:59:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <20060725204624.GF13829@redhat.com>
Message-ID: <Pine.LNX.4.64.0607251358170.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu>
 <20060725204624.GF13829@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jul 2006, Dave Jones wrote:
> 
> Things used to be fairly simple until hotplug cpu came along :-/
> Each day, I'm getting more of the opinion that my patch just ripping
> out this garbage is the right solution.

I think your patch is fine, but the cpu_hotplug_lock() should probably be 
taken by the callers much higher up in the stack, and then we could just 
have the rule that by the time any real cpufreq code is actually entered, 
we should hold the lock already.

		Linus
