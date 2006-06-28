Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWF1Wzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWF1Wzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWF1Wzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:55:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:2075 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751654AbWF1Wzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:55:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Oqcl0AiznWaIymcY7k7xjYSnbiXPvvJbl0jYTOqI0SP1QzAjmrv0aL51YddumdY7rg9RzcP5mBYu9ZX0aMdQQeeHbixkSX5iJe82VO491nB1teZiHZFl4T9EKCvRg1n6HChbabl3xVPhzLTcIJ86yGedYn/p5c+g3le1TlI5EPY=
Message-ID: <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
Date: Wed, 28 Jun 2006 15:55:49 -0700
From: "Russ Cox" <rsc@swtch.com>
To: "Eric Sesterhenn" <snakebyte@gmx.de>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
In-Reply-To: <1151535167.28311.1.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151535167.28311.1.camel@alice>
X-Google-Sender-Auth: 8897f57b315b6c86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> coverity (id #971) found some dead code. In all error
> cases ret is NULL, so we can remove the if statement.
>
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>
> --- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig   2006-06-29 00:50:53.000000000 +0200
> +++ linux-2.6.17-git11/fs/9p/vfs_inode.c        2006-06-29 00:51:11.000000000 +0200
> @@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
>
>  error:
>         kfree(fcall);
> -       if (ret)
> -               iput(ret);
> -
>         return ERR_PTR(err);
>  }

What about when someone changes the code and does have ret != NULL here?
This seems like reasonable defensive programming to me.

Is the official LK policy that we can't have code that trips coverity
checks like this?

Russ
