Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVFHLek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVFHLek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVFHLej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:34:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:45954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262176AbVFHLeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:34:18 -0400
Date: Wed, 8 Jun 2005 04:33:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] [2.6.12-rc6-mm1] Handle READA requests in dm-mpath.c
Message-Id: <20050608043347.5db85317.akpm@osdl.org>
In-Reply-To: <20050608110436.GQ27119@marowsky-bree.de>
References: <20050608110436.GQ27119@marowsky-bree.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> wrote:
>
> READA errors failing with EWOULDBLOCK/EAGAIN do not constitute a valid
> reason for failing the path; this lead to erratic errors on DM multipath
> devices. This error can be safely propagated upwards without failing the
> path.
> 

Why do you describe this as a -mm patch?  We want this in 2.6.12, no?

> --- linux-2.6.12-rc6-mm1.orig/drivers/md/dm-mpath.c	2005-06-08 12:51:02.741055000 +0200
> +++ linux-2.6.12-rc6-mm1/drivers/md/dm-mpath.c	2005-06-08 12:57:55.757828867 +0200
> @@ -985,6 +985,9 @@
>  	if (!error)
>  		return 0;	/* I/O complete */
>  
> +	if ((error == -EWOULDBLOCK) && bio_rw_ahead(bio))
> +		return error;
> +
>  	spin_lock(&m->lock);
>  	if (!m->nr_valid_paths) {
>  		if (!m->queue_if_no_path || m->suspended) {
> 
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"
