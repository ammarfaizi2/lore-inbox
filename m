Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUHALSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUHALSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUHALSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:18:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265805AbUHALRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:17:15 -0400
Date: Sun, 1 Aug 2004 07:16:24 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm1
In-Reply-To: <20040731132153.0763ce8f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408010715480.23711@devserv.devel.redhat.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
 <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
 <20040731114714.37359c2d.akpm@osdl.org> <Pine.LNX.4.58.0407311519490.4095@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407311609090.4095@montezuma.fsmlabs.com>
 <20040731132153.0763ce8f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Jul 2004, Andrew Morton wrote:

> Sorry.  Try this one instead.
> 
> --- 25/fs/jbd/checkpoint.c~journal_clean_checkpoint_list-latency-fix-fix	2004-07-31 11:43:39.320530424 -0700
> +++ 25-akpm/fs/jbd/checkpoint.c	2004-07-31 13:20:22.562303576 -0700
> @@ -497,8 +497,8 @@ int __journal_clean_checkpoint_list(jour
>  		 * We don't test cond_resched() here because another CPU could
>  		 * be waiting on j_list_lock() while holding a different lock.
>  		 */
> -		if ((ret & 127) == 127) {
> -			spin_unlock(&journal->j_list_lock);
> +		transaction = journal->j_checkpoint_transactions
> +		if (transaction && (ret & 127) == 127) {

this should cause a crash later on - 'transaction' is also the loop
variable here.

	Ingo
