Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWGMHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWGMHGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWGMHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:06:23 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:38016
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750830AbWGMHGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:06:23 -0400
Date: Thu, 13 Jul 2006 09:07:18 +0200
From: andrea@cpushare.com
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, ak@suse.de, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, akpm@osdl.org,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713070718.GC28310@opteron.random>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 13, 2006 at 01:43:42AM -0400, Albert Cahalan wrote:
> SECCOMP is a good idea, but currently a tad too limiting.
> There are a few dozen system calls that would be safe and useful,
> particularly those related to signals, memory, and synchronization.

malloc/free can be emulated in userland so that's not a big
problem. All the rest is a problem instead, unmodified software just
won't run.

seccomp mode 1 is the absolute minimum you need to compute ;). Every
single syscall we add it gets less secure. Several exploits happened
in mremap for example, even if at first glance it may sound a safe
syscall. It's safe now, but it may get buggy again later as new
features are being added.

I'd be skeptical adding seccomp mode 2 with more syscalls, otherwise
it's better to make it more flexible and to specify the syscalls to
allow from userland (which I'm not against if you've usages for it).

>From my part to go beyond seccomp, as jail for the interpreters I'll
probably use virtualization like ourgrid and tycoon (seccomp is the
safest and simplest mode but there's simply no way to run an
interpreter under it ;).
