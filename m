Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVLJJZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVLJJZc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 04:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVLJJZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 04:25:32 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:27193 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965117AbVLJJZb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 04:25:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sMMyLzzCIUZyziXYcyxXD1MuNTXzFTEROieQaM1Ym/2leCukKk9vzPIHTuR1lJXSvl2dgyCrnXCAselG+acc+CeaczElOSN2V9V7FT9j4xU0cNOHqsAqRHW3G5P9upTjmmVo7LnBhgDtsL+yVDuXDfm47TxdHoUgkDjKDS9cTuY=
Message-ID: <a070070d0512100125m33b335f3j@mail.gmail.com>
Date: Sat, 10 Dec 2005 10:25:28 +0100
From: Cornelia Huck <cornelia.huck@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 14/17] s390: introduce struct channel_subsystem.
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, cohuck@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051209235225.3936c1a0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051209152846.GO6532@skybase.boeblingen.de.ibm.com>
	 <20051209235225.3936c1a0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/10, Andrew Morton <akpm@osdl.org>:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > +     /* Setup css structure. */
> >  +    for (i = 0; i <= __MAX_CSSID; i++) {
> >  +            css[i] = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
> >  +            if (!css[i]) {
> >  +                    ret = -ENOMEM;
> >  +                    goto out_bus;
> >  +            }
> >  +            setup_css(i);
> >  +            ret = device_register(&css[i]->device);
> >  +            if (ret)
> >  +                    goto out_free;
> >  +    }
> >       css_init_done = 1;
> >
> >       ctl_set_bit(6, 28);
> >
> >       for_each_subchannel(__init_channel_subsystem, NULL);
> >       return 0;
> >  +out_free:
> >  +    kfree(css[i]);
> >   out_bus:
> >  +    while (i > 0) {
> >  +            i--;
> >  +            device_unregister(&css[i]->device);
> >  +    }
>
> I spy a memory leak.

Ugh, yes. Where has that release function gone? I'll send an
updated patch.

Cornelia
