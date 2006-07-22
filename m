Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWGVATg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWGVATg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGVATg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:19:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWGVATf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:19:35 -0400
Date: Fri, 21 Jul 2006 17:19:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Message-Id: <20060721171922.602706f9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch implements the revoke(2) and frevoke(2) system calls for all
> types of files.
>
> ...
>
> -	file = fget_light(fd, &fput_needed);
> +	file = fget(fd);

This is sad.

> +static int revoke_files(struct task_struct *owner, struct inode *inode,
> +			struct file *exclude, struct list_head *to_close)
> +{
> ...
> +	spin_lock(&files->file_lock);
> ...
> +		revoked = kmalloc(sizeof(*revoked), GFP_KERNEL);

This is bad.
