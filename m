Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVH3Iv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVH3Iv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVH3Iv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:51:57 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:28610 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751279AbVH3Iv4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:51:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IvPEu5JkQBs4QiLMO9AgoHh1qN/3ARd/3z0PZjYboA8qOrT3S9CxOkStdqHY7AJ4zdW7FmN7gID0VAMWzP9MzldAoSDYp1Kcfglnkk0k+BrPUuF7X1JC6pMgg3O2mqUfbIIMJIwKIBLvajbzAtsM2GUn6K8elJRzwYrKLvrhQTA=
Message-ID: <84144f020508300151721429bb@mail.gmail.com>
Date: Tue, 30 Aug 2005 11:51:53 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #2
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
In-Reply-To: <4313E578.8070100@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some coding style nitpicks.

On 8/30/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> +inline
> +static int hint_allocate(struct inode *dir)
> +{
> +       void *hints;
> +       int err = 0;
> +
> +       if (!MSDOS_I(dir)->scan_hints) {
> +               hints = kmalloc(FAT_SCAN_NWAY*sizeof(loff_t),GFP_KERNEL);
> +               if (hints)
> +                       memset(hints, 0, FAT_SCAN_NWAY*sizeof(loff_t));
> +               else
> +                       err = -ENOMEM;

Please consider using kcalloc().

> +
> +               down(&MSDOS_I(dir)->scan_lock);
> +               if (MSDOS_I(dir)->scan_hints) err = -EINVAL;

Please put the statement after if clause to a separate line. The above
makes code very hard to read.

> +               if (!err) MSDOS_I(dir)->scan_hints = hints;
> +               up(&MSDOS_I(dir)->scan_lock);
> +               if (err == -EINVAL) {
> +                       if (hints) kfree(hints);

kfree() can handle NULLs just fine so please drop the redundant check.

                               Pekka
