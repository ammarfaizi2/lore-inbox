Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVLJJaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVLJJaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 04:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVLJJaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 04:30:19 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:42347 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965120AbVLJJaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 04:30:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9B9dteX58PKC2/cMl2zoM6ba0BKeLneiomos9hGhc0mh76C+6274Laf2T4K1H6TfZ/8rb0rMfZ5Pc6H4F+NwwHAoncfcPdk2cvEyWHPh0DcJHXdMvNvvMn3YuEG9zPMdhTwCbx2HUPicqWxO83MGVUpGeAdOVhNMchWDsqYTww=
Message-ID: <a070070d0512100130u592b3517y@mail.gmail.com>
Date: Sat, 10 Dec 2005 10:30:18 +0100
From: Cornelia Huck <cornelia.huck@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 15/17] s390: convert /proc/cio_ignore.
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, cohuck@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051209235321.2281b7e6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051209152909.GP6532@skybase.boeblingen.de.ibm.com>
	 <20051209235321.2281b7e6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/10, Andrew Morton <akpm@osdl.org>:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > +static void *
> >  +cio_ignore_proc_seq_start(struct seq_file *s, loff_t *offset)
> >  +{
> >  +    struct ccwdev_iter *iter;
> >  +
> >  +    if (*offset > __MAX_SUBCHANNEL)
> >  +            return NULL;
> >  +    iter = kmalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
> >  +    if (!iter)
> >  +            return ERR_PTR(-ENOMEM);
> >  +    memset(iter, 0, sizeof(struct ccwdev_iter));
>
> kzalloc()

OK, will do.

>
> >  +    iter->devno = *offset;
> >  +    return iter;
> >  +}
> >  +
> >  +static void
> >  +cio_ignore_proc_seq_stop(struct seq_file *s, void *it)
> >  +{
> >  +    if (!IS_ERR(it))
> >  +            kfree(it);
> >  +}
> >  +
> >  +static void *
> >  +cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
> >  +{
> >  +    struct ccwdev_iter *iter;
> >  +
> >  +    if (*offset > __MAX_SUBCHANNEL)
> >  +            return NULL;
> >  +    iter = (struct ccwdev_iter *)it;
>
> Unneeded (and undesirable) cast of void*.

Some people seem to prefer explicit casts to make the
type more clear. Is there any concensus on this? (I don't care
either way ;))

Cornelia
