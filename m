Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVALWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVALWlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVALWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:41:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:58249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261525AbVALWj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:39:28 -0500
Date: Wed, 12 Jan 2005 14:44:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/11] FUSE - device functions
Message-Id: <20050112144402.38a8a337.akpm@osdl.org>
In-Reply-To: <E1CoOq3-0003Jq-00@dorka.pomaz.szeredi.hu>
References: <E1CoOq3-0003Jq-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> +void fuse_send_init(struct fuse_conn *fc)
> +{
> +	/* This is called from fuse_read_super() so there's guaranteed
> +	   to be a request available */
> +	struct fuse_req *req = do_get_request(fc);
> +	struct fuse_init_in_out *arg = &req->misc.init_in_out;
> +	arg->major = FUSE_KERNEL_VERSION;
> +	arg->minor = FUSE_KERNEL_MINOR_VERSION;
> +	req->in.h.opcode = FUSE_INIT;
> +	req->in.numargs = 1;
> +	req->in.args[0].size = sizeof(*arg);
> +	req->in.args[0].value = arg;
> +	req->out.numargs = 1;
> +	req->out.args[0].size = sizeof(*arg);
> +	req->out.args[0].value = arg;

Does all this userspace communication code work OK if it is talking with a
32-bit application from a 64-bit kernel?

Standard question: was netlink considered?
