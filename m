Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTEAUow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTEAUow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:44:52 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:14344 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262489AbTEAUot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:44:49 -0400
Date: Thu, 1 May 2003 21:57:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: "David S. Miller" <davem@redhat.com>,
       linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
Message-ID: <20030501215709.A28210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Whitehouse <Steve@ChyGwyn.com>,
	"David S. Miller" <davem@redhat.com>,
	linux-decnet-user@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030501.060909.26990580.davem@redhat.com> <200305012052.VAA19274@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305012052.VAA19274@gw.chygwyn.com>; from steve@gw.chygwyn.com on Thu, May 01, 2003 at 09:52:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 09:52:01PM +0100, Steven Whitehouse wrote:
> --- linux-2.5.68-bk10/fs/seq_file.c	Sun Apr 20 03:27:58 2003
> +++ linux/fs/seq_file.c	Mon Apr 21 14:40:35 2003
> @@ -338,3 +338,13 @@
>  	kfree(op);
>  	return res;
>  }
> +
> +int kfree_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *seq = file->private_data;
> +
> +	kfree(seq->private);
> +	seq->private = NULL;
> +	return seq_release(inode, file);
> +}

The name is a bit generic for an export function.  What about
seq_release_kfree?

