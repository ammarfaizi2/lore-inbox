Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVDYQA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVDYQA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVDYPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:51:24 -0400
Received: from mail.dif.dk ([193.138.115.101]:6530 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262660AbVDYPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:50:36 -0400
Date: Mon, 25 Apr 2005 17:53:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 4/7] dlm: configuration
In-Reply-To: <20050425151250.GE6826@redhat.com>
Message-ID: <Pine.LNX.4.62.0504251749090.2941@dragon.hyggekrogen.localhost>
References: <20050425151250.GE6826@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, David Teigland wrote:

> 
> Per-lockspace configuration happens through files under:
> /sys/kernel/dlm/<lockspace_name>/.  This includes telling each lockspace
> which nodes are using the lockspace and suspending locking in a lockspace.
> 
> Lockspace-independent configuration involves telling the dlm communication
> layer the IP address of each node ID that's being used.  These addresses
> are set using an ioctl on a misc device.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
[...]
> +static ssize_t dlm_finish_store(struct dlm_ls *ls, const char *buf, size_t len)
> +{
> +	dlm_ls_finish(ls, simple_strtol(buf, NULL, 0));
> +	return len;
> +}
[...]
> +static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
> +{
> +	ls->ls_global_id = simple_strtol(buf, NULL, 0);
> +	return len;
> +}
[...]

What's the point of `len' in these two functions? 
You pass in `len`, don't use it at all, then return the value. I fail to 
see the usefulness. Why not just have the function return void and omit 
the `len' parameter?


-- 
Jesper Juhl


