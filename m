Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVGCQHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVGCQHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGCQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:05:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261465AbVGCQFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 12:05:05 -0400
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
References: <200507012258_MC3-1-A340-3A81@compuserve.com.suse.lists.linux.kernel>
	<200507021456.40667.vda@ilport.com.ua.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Jul 2005 18:05:03 +0200
In-Reply-To: <200507021456.40667.vda@ilport.com.ua.suse.lists.linux.kernel>
Message-ID: <p738y0ng9jk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> writes:
> 
> 80/20 rule says that 80% of code runs 20% of time,
> thus we need only __fast. Everything else will be by default __slow.
> (IOW: normal .text section is __slow, no need to add another one).

__slow could include noinline.  With unit-at-a-time gcc tends 
otherwise to inline too aggressively. With __fast that would not be
possible.


-Andi

P.S.: gcc 4.x already supports .cold even on the basic block level.
However I believe it's only active with profile feedback, which is not
practical for kernel builds.
