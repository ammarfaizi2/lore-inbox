Return-Path: <linux-kernel-owner+w=401wt.eu-S1752281AbWLQJMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbWLQJMQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 04:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbWLQJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 04:12:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45298 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbWLQJMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 04:12:13 -0500
Date: Sun, 17 Dec 2006 10:09:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061217090943.GA9246@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217085859.GB2938@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the other thing that is pretty ugly is the recursive_enter/clear/exit 
code. I'd suggest the lockdep model here: use a single flag in 
task_struct to detect recursion. Also, never use BUG() when hitting a 
bug in a debugging helper - that will crash the box. Use a flag to turn 
off the whole thing if you encounter an internal bug and print a 
warning. That way bugs can actually be reported, instead of users 
wondering why the box locked up under X.

	Ingo
