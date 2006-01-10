Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWAJNQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWAJNQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAJNQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:16:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19434 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932151AbWAJNQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:16:12 -0500
Date: Tue, 10 Jan 2006 14:16:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110131618.GA27123@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net> <20060110104759.GA30546@elte.hu> <43C3A85A.7000003@reub.net> <20060110044240.3d3aa456.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110044240.3d3aa456.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > Ok here's the latest one, this time with KALLSYMS_ALL, CONFIG_FRAME_POINTER, 
> >  CONFIG_DETECT_SOFTLOCKUP and the DEBUG_WARN_ON(current->state != TASK_RUNNING); 
> >  patch from Ingo.
> 
> This is quite ugly.  I'd be suspecting a block layer problem: RAID or 
> the underlying device driver (ahci) has lost an IO.

yeah, now it more looks like that to me too. What happens is a raid1 
resync happens in the background - which is one of the more complex 
raid1 workloads - and there've been a good number of md patches 
recently. Reuben, does -git5 show the same symptoms?

	Ingo
