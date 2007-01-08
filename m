Return-Path: <linux-kernel-owner+w=401wt.eu-S932124AbXAHIjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbXAHIjc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXAHIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:39:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:22151 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbXAHIjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EMngL9S+tB4TsQJfaNBqjO40e8cjGKOqeIQJPETkNgictL0912EYMtUg4dw6C4Daud74c91G9HrDkmG8ikfBH59YiqvLr/EPFFsSqMhN4Zf8J+jjqsmTJOANsIGWIJ3mBbgAYlorIQWZSajzBnBH965U5nF69bxI6jbrEUqIuSE=
Message-ID: <1458d9610701080039m50d63d82w59cd917691edcb03@mail.gmail.com>
Date: Mon, 8 Jan 2007 03:39:30 -0500
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, "Hua Zhong" <hzhong@gmail.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <810563.91187.qm@web55604.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com>
	 <810563.91187.qm@web55604.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asking for KFREE is as silly as asking for a macro to check if kmalloc
succeeded for a pointer, else return ENOMEM.

#define CKMALLOC(p,x) \
   do {   \
       p = kmalloc(x, GFP_KERNEL); \
       if(!p) return -ENOMEM; \
    } while(0)


On 1/8/07, Amit Choudhary <amit2030@yahoo.com> wrote:
>
> --- Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> > On 1/8/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > > And as I explained, it can result in longer code too. So, why
> > > > keep this value around. Why not re-initialize it to NULL.
> > >
> > > Because initialization increases code size.
> >
> > And it also effectively blocks the slab debugging code from doing its
> > job detecting double-frees.
> >
>
> Man, so you do want someone to set 'x' to NULL after freeing it, so that the slab debugging code
> can catch double frees. If you set it to NULL then double free is harmless. So, you want something
> harmful in the system and then debug it with the slab debugging code. Man, doesn't make sense to
> me.
>
> -Amit
>
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
