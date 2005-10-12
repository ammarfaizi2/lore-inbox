Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJLRik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJLRik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJLRij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:38:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbVJLRij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:38:39 -0400
Date: Wed, 12 Oct 2005 10:38:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_sendfile oops in 2.6.13?
Message-ID: <20051012173830.GP7991@shell0.pdx.osdl.net>
References: <121a28810510110156q1369b9dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121a28810510110156q1369b9dg@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Nosek (grzegorz.nosek@gmail.com) wrote:
> --- linux-2.6/fs/read_write.c~  2005-10-06 21:35:03.000000000 +0200
> +++ linux-2.6/fs/read_write.c   2005-10-05 19:14:04.000000000 +0200
> @@ -719,7 +719,7 @@
>        current->syscr++;
>        current->syscw++;
> 
> -       if (*ppos > max)
> +       if (ppos && *ppos > max)
>                retval = -EOVERFLOW;

This doesn't make sense.  ppos must not be NULL.

Code looks like this:

if (!ppos)
	 ppos = &in_file->f_pos;
...
pos = *ppos;
...
if (*ppos > max)

So it can't be NULL, and if somehow it were, the oops would've already
happened.
