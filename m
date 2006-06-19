Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWFSG6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFSG6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFSG6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:58:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbWFSG6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:58:09 -0400
Date: Sun, 18 Jun 2006 23:58:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
Message-Id: <20060618235805.f12d4606.akpm@osdl.org>
In-Reply-To: <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	<E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 14:29:20 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> +/*
> + * It would be nice to scramble the ID space, so that the value of the
> + * files_struct pointer is not exposed to userspace.  Symmetric crypto
> + * functions are overkill, since the inverse function doesn't need to
> + * be implemented (though it does have to exist).  Is there something
> + * simpler?
> + */
> +static inline u64 fuse_lock_owner_id(fl_owner_t id)
> +{
> +	return (unsigned long) id;
> +}

Add a constant, not-known-to-userspace offset to all ids?
