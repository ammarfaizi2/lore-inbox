Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbUKPMT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUKPMT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUKPMTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:19:48 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:3231 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261955AbUKPMTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=od8iLXWiGOVq2AR6ycklLkranlNWiAIQDi7q0mXz2KAC8swpEBFbWtqX38s42tVki7oFd4tE7Fo4mE38lS24/sVe7JCdN9pHnSw0ZdSrXWe0DqBo2tfSECTgiI/qf3Z9tOO4DhXX8uAiSZ1cSJj6sMrYHn9druhs1MrXUre0xCE=
Message-ID: <84144f020411160419dc705fc@mail.gmail.com>
Date: Tue, 16 Nov 2004 14:19:34 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CU0nM-0000iT-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <84144f0204111602136a9bbded@mail.gmail.com>
	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	 <84144f020411160235616c529b@mail.gmail.com>
	 <E1CU0nM-0000iT-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklov,

I have a couple of more comments.

> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/fs/fuse/dev.c	2004-11-15 20:20:16 +01:00
> @@ -0,0 +1,606 @@
> +static int get_unique(struct fuse_conn *fc)
> +{
> +	do fc->reqctr++;
> +	while (!fc->reqctr);
> +	return fc->reqctr;
> +}
> +

What are you doing here? Why do you need to avoid zero? Anyway, if you
really need to do that, this would be more readable IMHO:

static int get_unique(struct fuse_conn *fc)
{
       	if (++fc->reqctr == 0)
       	fc->reqctr = 1;
        return fc->reqctr;
}

An added bonus of producing better code for architectures that support
conditional move...

> +static struct proc_dir_entry *proc_fs_fuse;
> +struct proc_dir_entry *proc_fuse_dev;
> 
> +int fuse_dev_init(void)
> +{
> +	proc_fs_fuse = NULL;
> +	proc_fuse_dev = NULL;

Pointers with static storage class are initialized to NULL by default
so these are redundant.

> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/fs/fuse/inode.c	2004-11-15 20:20:16 +01:00
> @@ -0,0 +1,523 @@

[snip]

> +enum { opt_fd,
> +       opt_rootmode,
> +       opt_uid,
> +       opt_default_permissions, 
> +       opt_allow_other,
> +       opt_allow_root,
> +       opt_kernel_cache,
> +       opt_large_read,
> +       opt_direct_io,
> +       opt_max_read,
> +       opt_err };
> +

Enums in upper case, please.

		Pekka
