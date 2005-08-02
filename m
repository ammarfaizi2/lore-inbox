Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVHBJ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVHBJ0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVHBJ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:26:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14541 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261413AbVHBJ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:26:47 -0400
Date: Tue, 2 Aug 2005 11:27:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com
Subject: Re: [Patch] don't kick ALB in the presence of pinned task
Message-ID: <20050802092717.GB20978@elte.hu>
References: <20050801174221.B11610@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801174221.B11610@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> Jack Steiner brought this issue at my OLS talk.
> 
> Take a scenario where two tasks are pinned to two HT threads in a physical
> package. Idle packages in the system will keep kicking migration_thread
> on the busy package with out any success.
> 
> We will run into similar scenarios in the presence of CMP/NUMA.
> 
> Patch appended.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

nice catch!

fine for -mm, but i dont think we need this fix in 2.6.13, as the effect 
of the bug is an extra context-switch per 'CPU goes idle' event, in this 
very specific (and arguably broken) task binding scenario. In a 
worst-case scenario a CPU going idle can 'spam' that other CPU with 
migration requests, but it still seems like a pretty artificial workload 
scenario where the system has significant idle time left. I have tested 
your fix on a HT box and it solves the problem.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
