Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUHTJE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUHTJE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTJCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:02:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28394 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267900AbUHTJBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:01:47 -0400
Date: Fri, 20 Aug 2004 11:03:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820090323.GA11311@elte.hu>
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092964083.4946.7.camel@biclops.private.network> <20040819181603.700a9a0e.akpm@osdl.org> <1092987650.28849.349.camel@bach> <20040820081458.GA4949@elte.hu> <20040820082941.GA31649@in.ibm.com> <20040820085923.GA11255@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820085923.GA11255@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> see the patch i just sent - it disables hotplug in that critical
> self-reap section.
> 
> (another solution would be for the hotplug code to also look into the
> local runqueue for tasks to migrate, not only the tasklist.)

yet another solution would be to do proc_pid_flush() earlier in
release_task(). This opens up some races elsewhere which need to be
solved (iirc mostly in the /proc code, see ->proc_lock) but should solve
it a bit nicer i think. 

	Ingo
