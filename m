Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVKIWsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVKIWsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKIWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:48:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161011AbVKIWsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:48:21 -0500
Date: Wed, 9 Nov 2005 22:48:08 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com
Subject: Re: [PATCH] dm: memory leak in failed table_load()
Message-ID: <20051109224808.GE26394@agk.surrey.redhat.com>
Mail-Followup-To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com
References: <20051109.170732.41627574.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109.170732.41627574.k-ueda@ct.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 05:07:32PM -0500, Kiyoshi Ueda wrote:
> @@ -974,6 +974,7 @@ static int table_load(struct dm_ioctl *p
>  	if (!hc) {
>  		DMWARN("device doesn't appear to be in the dev hash table.");
>  		up_write(&_hash_lock);
> +		dm_table_put(t);
>  		return -ENXIO;

Well spotted!

Added to dev patchset and will push alongside with some other stuff in a 
few days' time.
  http://www.kernel.org/pub/linux/kernel/people/agk/patches/2.6/editing/dm-ioctl-missing-put-in-table-load-error-case.patch

Alasdair
-- 
agk@redhat.com
