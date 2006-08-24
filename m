Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWHXPIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWHXPIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHXPIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:08:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3052 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964946AbWHXPIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:08:38 -0400
Date: Thu, 24 Aug 2006 17:00:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>, ego@in.ibm.com,
       rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060824150026.GA14853@elte.hu>
References: <20060824103417.GE2395@in.ibm.com> <1156417200.3014.54.camel@laptopd505.fenrus.org> <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org> <44EDBDDE.7070203@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EDBDDE.7070203@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> It really is just like a reentrant rw semaphore... I don't see the 
> point of the name change, but I guess we don't like reentrant locks so 
> calling it something else might go down better with Linus ;)

what would fit best is a per-cpu scalable (on the read-side) 
self-reentrant rw mutex. We are doing cpu hotplug locking in things like 
fork or the slab code, while most boxes will do a CPU hotplug event only 
once in the kernel's lifetime (during bootup), so a classic global 
read-write lock is unjustified.

	Ingo
