Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVJLWNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVJLWNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVJLWNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:13:20 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:16453 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932479AbVJLWNT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:13:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGA8AbMT75zOHAyp4/jtMfmVCCcD3LBsF9xaqwbTEKXVlmWVVSPrGP9vUJ8UNltD16aFRz8dLLiB/FD01/c4FZPqcrikxm1PvTNm5+YBUxF3gbxgjnh0wOyjqNpPQ1mE9H3N1oAQ/zPJVFRYU60Pwu6SPul+jTgu37lL8dcOi7A=
Message-ID: <121a28810510121306j368acd9ei@mail.gmail.com>
Date: Wed, 12 Oct 2005 22:06:57 +0200
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: sys_sendfile oops in 2.6.13?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051012173830.GP7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810510110156q1369b9dg@mail.gmail.com>
	 <20051012173830.GP7991@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/10/12, Chris Wright <chrisw@osdl.org>:
> * Grzegorz Nosek (grzegorz.nosek@gmail.com) wrote:
> > --- linux-2.6/fs/read_write.c~  2005-10-06 21:35:03.000000000 +0200
> > +++ linux-2.6/fs/read_write.c   2005-10-05 19:14:04.000000000 +0200
> > @@ -719,7 +719,7 @@
> >        current->syscr++;
> >        current->syscw++;
> >
> > -       if (*ppos > max)
> > +       if (ppos && *ppos > max)
> >                retval = -EOVERFLOW;
>
> This doesn't make sense.  ppos must not be NULL.
>
> Code looks like this:
>
> if (!ppos)
>          ppos = &in_file->f_pos;
> ...
> pos = *ppos;
> ...
> if (*ppos > max)
>
> So it can't be NULL, and if somehow it were, the oops would've already
> happened.
>

Yeah, I know. It turned out to be a 3rd-party patch (vserver
probably). My read_write.c looks very different and somehow I
overlooked that while checking with vanilla 2.6.13.3. Sorry for the
confusion.

Regards,
 Greg
