Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVKOJ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVKOJ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVKOJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:56:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751415AbVKOJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:56:15 -0500
Date: Tue, 15 Nov 2005 09:56:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
Message-ID: <20051115095610.GA23605@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@fys.uio.no>
References: <20051115125657.9403.patches@notabene> <1051115020002.9459@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051115020002.9459@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -int do_truncate(struct dentry *dentry, loff_t length, struct file *filp)
> +int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
> +	struct file *filp)
>  {
>  	int err;
>  	struct iattr newattrs;
> @@ -204,7 +205,7 @@ int do_truncate(struct dentry *dentry, l
>  		return -EINVAL;
>  
>  	newattrs.ia_size = length;
> -	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
> +	newattrs.ia_valid = ATTR_SIZE | time_attrs;

I'd rather make the argument and boolean update_times flag and this:


	newattrs.ia_valid = ATTR_SIZE;
	if (update_times)
		newattrs.ia_valid |= ATTR_CTIME|ATTR_MTIME;

but except for that little nitpick the patch looks good.  thanks.

