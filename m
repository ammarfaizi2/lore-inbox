Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTGHQFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTGHQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:05:45 -0400
Received: from [128.2.206.88] ([128.2.206.88]:13483 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264376AbTGHQFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:05:43 -0400
Date: Tue, 8 Jul 2003 12:20:08 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] path_lookup for 2.4.20-pre4 (ChangeSet@1.587.10.71)
Message-ID: <20030708162008.GA18924@delft.aura.cs.cmu.edu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <16138.53118.777914.828030@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16138.53118.777914.828030@charged.uio.no>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing you might want to add to avoid revalidating all pathnames that
happen to start with a dot, like '.bashrc'.

Jan

On Tue, Jul 08, 2003 at 04:04:46PM +0200, Trond Myklebust wrote:
> diff -u --recursive --new-file linux-2.4.22-odirect/fs/namei.c linux-2.4.22-fix_cto/fs/namei.c
> --- linux-2.4.22-odirect/fs/namei.c	2003-06-27 13:34:41.000000000 +0200
> +++ linux-2.4.22-fix_cto/fs/namei.c	2003-07-08 15:51:08.000000000 +0200
> @@ -732,6 +732,24 @@
>  			nd->last_type = LAST_DOT;
>  		else if (this.len == 2 && this.name[1] == '.')
>  			nd->last_type = LAST_DOTDOT;
  +		else
  +			goto return_base;
> +return_reval:
> +		/*
> +		 * We bypassed the ordinary revalidation routines.
> +		 * We may need to check the cached dentry for staleness.
> +		 */

