Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVDFFoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVDFFoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDFFoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:44:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21951 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262107AbVDFFoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:44:37 -0400
Date: Wed, 6 Apr 2005 07:44:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 1/5] sched: remove degenerate domains
Message-ID: <20050406054412.GA5853@elte.hu>
References: <425322E0.9070307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425322E0.9070307@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> This is Suresh's patch with some modifications.

> Remove degenerate scheduler domains during the sched-domain init.

actually, i'd suggest to not do this patch. The point of booting with a 
CONFIG_NUMA kernel on a non-NUMA box is mostly for testing, and the 
'degenerate' toplevel domain exposed conceptual bugs in the 
sched-domains code. In that sense removing such 'unnecessary' domains 
inhibits debuggability to a certain degree. If we had this patch earlier 
we'd not have experienced the wrong decisions taken by the scheduler, 
only on the much rarer 'really NUMA' boxes.

is there any case where we'd want to simplify the domain tree? One more 
domain level is just one (and very minor) aspect of CONFIG_NUMA - i'd 
not want to run a CONFIG_NUMA kernel on a non-NUMA box, even if the 
domain tree got optimized. Hm?

	Ingo
