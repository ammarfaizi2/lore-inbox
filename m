Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWGaEFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWGaEFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWGaEFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:05:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751431AbWGaEFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:05:17 -0400
Date: Sun, 30 Jul 2006 21:05:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 007 of 11] knfsd: add svc_get
Message-Id: <20060730210507.12e33f56.akpm@osdl.org>
In-Reply-To: <1060731004219.29255@suse.de>
References: <20060731103458.29040.patches@notabene>
	<1060731004219.29255@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:42:19 +1000
NeilBrown <neilb@suse.de> wrote:

>  /*
> + * We use sv_nrthreads as a reference count.  svc_destroy() drops
> + * this refcount, so we need to bump it up around operations that
> + * change the number of threads.  Horrible, but there it is.
> + * Should be called with the BKL held.
> + */
> +static inline void svc_get(struct svc_serv *serv)
> +{
> +	serv->sv_nrthreads++;
> +}

It's a bit odd for a numa-scalability patch to be increasing our dependency
upon lock_kernel()...

