Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVLNIC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVLNIC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLNIC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:02:29 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:51857 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751299AbVLNIC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:02:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6IjthgySASiBrz9TEKywSsjCgl0BXG+IE9ugRRIOj8Bm04662n2wXhB/UP5wqsqi7AaGaN27MDvGsGHAnw3e5pBRkW9AFAWN8PztnxdBPVQ60oBfjVl22TLkldfBhuWGorwfA3sx4SF7cpIVzztAAydgV3auZPotQorBIIbYgE=
Message-ID: <9a8748490512140002s8daf671h6db51bff1c06c834@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:02:27 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] fix warning and missing failure handling for scsi_add_host in aic7xxx driver
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "Daniel M. Eischen" <deischen@iworks.interworks.org>,
       Doug Ledford <dledford@redhat.com>
In-Reply-To: <1134534839.3133.2.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512140007.20046.jesper.juhl@gmail.com>
	 <1134534839.3133.2.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, James Bottomley <James.Bottomley@steeleye.com> wrote:
> On Wed, 2005-12-14 at 00:07 +0100, Jesper Juhl wrote:
> > +     if (retval) {
> > +             printk(KERN_ERR "aic7xxx: scsi_add_host failed\n");
> > +             goto free_and_out;
> > +     }
> > +
> >       scsi_scan_host(host);
> > -     return (0);
> > +
> > +out:
> > +     return retval;
> > +free_and_out:
> > +     scsi_remove_host(host);
> > +     goto out;
>
> I'm not incredibly keen on all this jumping around for no reason.  If
> there's a normal out and an error out, then fine, but in this case the
> if (retval) { } could contain the entirety of the error path with an
> else for the normal path.
>
Ok, I'll change that.

> scsi_remove_host() is the wrong API, it should be scsi_host_put() (for
> an allocated but un added host).
>
Ohh, I misunderstood things then, I'll correct that.

I'll send a new patch later today when I get home from work.

Thank you for taking a look at the patch and your feedback.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
