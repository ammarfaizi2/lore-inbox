Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWIVFkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWIVFkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWIVFkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:40:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:4670 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932285AbWIVFkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:40:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hCV6AWzwJ7sHdPyeTeNCWJFTeUC8cc0VZjH0EBfzPIcs+ASwVdcQSrfyiX3KbXdfsXeIEzJSxFlSiX5izovP63BTNq4nkMn7JdWtMLTaNwjrJIsY/VgOyeHkZm4fZto5lFzjefFpurPHvMGpUyTpBFuab3P7Yt3ARAIGM/cyyQQ=
Message-ID: <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
Date: Thu, 21 Sep 2006 22:40:10 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Nishanth Aravamudan" <nacc@us.ibm.com>
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <20060921072017.GA27798@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
	 <20060921072017.GA27798@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.
> >
> > Signed off by Om Narasimhan <om.turyx@gmail.com>
>
> This is not the canonical format, per SubmittingPatches. It should be:
>
> Signed-off-by: Random J Developer <random@developer.example.org>
OK. I would take care of it.
>
> >  drivers/block/cciss.c    |    4 +--
> >  drivers/block/cpqarray.c |   72 +++++++++++++++-------------------------------
> >  drivers/block/loop.c     |    4 +--
> >  3 files changed, 25 insertions(+), 55 deletions(-)
>
> Your diffstat should have indicated to you that this should be split up
> better. Please (re-)read SubmittingPatches. *One* logical change per
> patch, most importantly.
OK. I would resubmit.
> >
> > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> > index 2cd3391..a800a69 100644
> > --- a/drivers/block/cciss.c
> > +++ b/drivers/block/cciss.c
> > @@ -900,7 +900,7 @@ #if 0                             /* 'buf_size' member is 16-bits
> >                               return -EINVAL;
> >  #endif
> >                       if (iocommand.buf_size > 0) {
> > -                             buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
> > +                             buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
> >                               if (buff == NULL)
> >                                       return -EFAULT;
> >                       }
> > @@ -911,8 +911,6 @@ #endif
> >                                       kfree(buff);
> >                                       return -EFAULT;
> >                               }
> > -                     } else {
> > -                             memset(buff, 0, iocommand.buf_size);
> >                       }
> >                       if ((c = cmd_alloc(host, 0)) == NULL) {
> >                               kfree(buff);
>
> This changes performance potentially, no? The memset before was
> conditional upon (iocommand.Request.Type.Direction == XFER_WRITE) and
> now the memory will always be zero'd.
Yes, but not the functionality.
if (iocommand.buf_size > 0), code allocates using kmalloc. if
direction is XFER_WRITE, it does a copy_from_user(), and free()s the
allocated buffer, not really caring what data came in from userspace.
Else, it does memset(). So I could safely replace the kmalloc() with
kzalloc() without compromising functionality.

Thanks,
Om.
