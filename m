Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVBVHxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVBVHxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 02:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVBVHxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 02:53:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:9680 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262242AbVBVHxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 02:53:19 -0500
Date: Tue, 22 Feb 2005 08:53:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, mort@wildopensource.com, pj@sgi.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050222075304.GA778@elte.hu>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com> <20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org> <421A607B.4050606@sgi.com> <20050221144108.40eba4d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050221144108.40eba4d9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > However, the first step is to do this manually from user space.
> 
> Yup.  The thing is, lots of people want this feature for various
> reasons.  Not just numerical-computing-users-on-NUMA.  We should get
> it right for them too.
> 
> Especially kernel developers, who have various nasty userspace tools
> which will manually reclaim pagecache.  But non-kernel-developers will
> use it too, when they think the VM is screwing them over ;)

app designers very frequently think that the VM gets its act wrong (most
of the time for the wrong reasons), and the last thing we want to enable
them is to hack real problems around. How are we supposed to debug VM
problems where one player periodically flushes the whole pagecache? If
that flushing, when disabled, 'results in the app being broken' (_if_
the app gives any option to disable the flushing). Providing APIs to
flush system caches, sysctl or syscall, is the road to VM madness.

If the goal is to override the pagecache (and other kernel caches) on a
given node then for God's sake, think a bit harder. E.g. enable users to
specify an 'allocation priority' of some sort, which kicks out the
pagecache on the local node - or something like that. Giving a
half-assed tool to clean out one aspect of the system caches will only
muddy the waters, with no real road back to sanity.

	Ingo
