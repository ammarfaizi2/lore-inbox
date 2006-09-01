Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWIAGUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIAGUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWIAGUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:20:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964867AbWIAGUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:20:34 -0400
Date: Thu, 31 Aug 2006 23:20:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Olaf Kirch <okir@suse.de>
Subject: Re: [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
Message-Id: <20060831232029.b003e8a7.akpm@osdl.org>
In-Reply-To: <1060901043825.27464@suse.de>
References: <20060901141639.27206.patches@notabene>
	<1060901043825.27464@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 14:38:25 +1000
NeilBrown <neilb@suse.de> wrote:

> +nsm_release(struct nsm_handle *nsm)
> +{
> +	if (!nsm)
> +		return;
> +	if (atomic_read(&nsm->sm_count) == 1) {
> +		down(&nsm_sema);
> +		if (atomic_dec_and_test(&nsm->sm_count)) {
> +			list_del(&nsm->sm_link);
> +			kfree(nsm);
> +		}
> +		up(&nsm_sema);
> +	}
> +}

That's weird-looking.  Are you sure?  afaict, if ->sm_count ever gets a
value of 2 or more, it's unfreeable.  
