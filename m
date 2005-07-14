Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVGNUQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVGNUQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbVGNUPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:15:54 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:50073 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263137AbVGNUON convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:14:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tN6tyzqXrzajLAPD6i0Uk1cuUaObXR3hHKZMA9ysrNlPIoYweiTpOFnZ2vaChPhZv7ZfdfhS9cXrBHId8E38GWL5tdED/Y1FlVOdoAMBPQzMxCKlaH6ZqlFl9IqhNzqXL4Q+DFuOQixowuq+lKh/uTbNb5JEsSsrjKjoixoMg28=
Message-ID: <a4e6962a0507141313142ac201@mail.gmail.com>
Date: Thu, 14 Jul 2005 15:13:22 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2-mm2 5/7] v9fs: 9P protocol implementation (2.0.2)
In-Reply-To: <20050714195034.GA22576@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507141830.j6EIUpRZ023698@ms-smtp-03-eri0.texas.rr.com>
	 <20050714195034.GA22576@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Christoph Hellwig <hch@infradead.org> wrote:
> > +static inline void buf_check_size(struct cbuf *buf, int len)
> > +{
> > +     if (buf->p+len > buf->ep) {
> > +             if (buf->p < buf->ep) {
> > +                     eprintk(KERN_ERR, "buffer overflow\n");
> > +                     buf->p = buf->ep + 1;
> > +             }
> > +     }
> > +}
> 
> "handling" a buffer overflow with a printk doesn't seem appopinquate.
> In what cases can this happen and what problems may it cause?
> 

I believe all of these cases represent what we would consider to be
protocol errors.  I suppose it is possible that our truncation
approach could be used as an exploit in some weird case -- I'll take a
look at fixing things so that any such overflow case is treated as a
fatal protocol error and reported as such (via the protocol as
appropriate).

      -eric
