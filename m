Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUCILsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUCILsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:48:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61380 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261884AbUCILsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:48:10 -0500
Date: Tue, 9 Mar 2004 12:49:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309114924.GA4581@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309030907.71a53a7c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > or run the attached test-mmap2.c code, which simulates a very small DB
> >  app using only 1800 vmas per process: it only maps 8 MB of shm and
> >  spawns 32 processes. This has an even more lethal effect than the
> >  previous code.
> 
> Do these tests actually make any forward progress at all, or is it some bug
> which has sent the kernel into a loop?

i think they make a forward progress so it's more of a DoS - but a very
effective one, especially considering that i didnt even try hard ...

what worries me is that there are apps that generate such vma patterns
(for various reasons).

I do believe that scanning ->i_mmap & ->i_mmap_shared is fundamentally
flawed.

	Ingo
