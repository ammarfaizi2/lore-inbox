Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWIKF0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWIKF0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWIKF0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:26:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37001 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964865AbWIKF0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:26:04 -0400
Date: Mon, 11 Sep 2006 07:18:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060911051823.GA11269@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <4504F257.7020306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4504F257.7020306@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., i dont think it's the early-bootup behavior of lockdep that causes 
your oops. I think %gs somehow ended up being invalid upon pagefault 
entry, well after bootup. Not sure why. Andi's patch just papers over 
this i believe.

ah ... found it meanwhile: in the syscall exit path the PDA patches 
restore the userspace %gs too early, trace_hardirqs_on() is called 
_after_ the restoring of %gs. Will send a patch in a few minutes.

	Ingo
