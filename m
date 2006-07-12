Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWGLPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWGLPoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWGLPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:44:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63922 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751418AbWGLPoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:44:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
References: <20060629192121.GC19712@stusta.de>
	<1151628246.22380.58.camel@mindpipe>
	<20060629180706.64a58f95.akpm@osdl.org>
	<20060630014050.GI19712@stusta.de>
	<20060630045228.GA14677@opteron.random>
	<20060630094753.GA14603@elte.hu>
	<20060630145825.GA10667@opteron.random>
	<20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random>
	<1152628374.3128.66.camel@laptopd505.fenrus.org>
	<20060711153117.GJ7192@opteron.random>
	<1152635055.18028.32.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2006 17:43:42 +0200
In-Reply-To: <1152635055.18028.32.camel@localhost.localdomain>
Message-ID: <p73wtain80h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> I really don't care about cpushare and patents for some users of the
> code in question. On the other hand turning on performance harming code
> for a tiny number of users is dumb. If it were a loadable module it
> would be different.

Actually there are some promising applications of seccomp outside
cpushare.

e.g. Andrea at some point proposed to run codecs which often
have security issues in a simple cpusec jail.  That's ok for 
them because they normally don't need to do any system calls.

I liked the idea. While this can be done with LSM (e.g. apparmor) too 
seccomp is definitely much easier and simpler and more "obviously safe"
than anything LSM based.

If the TSC disabling code is taken out the runtime overhead
of seccomp is also very small because it's only tested in slow
paths.

-Andi
