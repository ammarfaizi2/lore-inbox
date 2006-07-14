Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWGNSvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWGNSvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWGNSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:51:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:54666 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422705AbWGNSvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:51:00 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
Cc: Theodore Tso <tytso@mit.edu>, libc-alpha@sourceware.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <OF1343C031.500862D1-ON862571A9.00817A27-862571A9.00826BED@us.ibm.com>
References: <OF1343C031.500862D1-ON862571A9.00817A27-862571A9.00826BED@us.ibm.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 04:49:55 +1000
Message-Id: <1152902996.23037.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We will need an implementation that will fall back to sys_sysctl for older
> kernels. This is already common practice in glibc. I don't really
> understand the performance concern because it seems to me that
> _is_smp_system() is only called once per process.
> 
> But isn't this the kind of thing that the Aux Vector is for? I like vDSO
> too, but I think it is best deployed for information of a more dynamic
> nature and performance sensitive.

For a simple "is_smp" kind of flag, I would tend to agree with the
above... for more complex NUMA topology and/or cache characteristics,
which is quite a bigger amount of information, I'm not sure it's worth
copying all of that data on every process exec (and making the initial
AT_ parsing slower). Especially since very few processes actually care
about those.

Ben.


