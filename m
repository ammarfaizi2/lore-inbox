Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbVGNUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVGNUU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVGNUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:18:34 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:53962 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263148AbVGNUQT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:16:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=njvaRu/cpkgn2BpfbhGbQhoaRXq5fACOcdlQr3DsfajsQvtyJXTjGxZ79spRA5JmC2nsRvvrvA/dMDvRZ/ZlUKht+T+nXzH9C5rDqBEP7Sg6dh0esdzfct/39ITYOgN//VKu3zeXyf7puLNMqfLGjGmq5Umd3YFmvQT1E5oqDn8=
Message-ID: <a4e6962a05071413152e27a857@mail.gmail.com>
Date: Thu, 14 Jul 2005 15:15:31 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2-mm2 2/7] v9fs: VFS file, dentry, and directory operations (2.0.2)
In-Reply-To: <20050714195458.GA22856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507141830.j6EIUiRZ023607@ms-smtp-03-eri0.texas.rr.com>
	 <20050714195458.GA22856@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh!  Good catch, I'll fix and resubmit - same goes for the formating issues.

On 7/14/05, Christoph Hellwig <hch@infradead.org> wrote:
> > @@ -383,9 +379,10 @@ v9fs_file_write(struct file *filp, const
> >               return -ENOMEM;
> >
> >       ret = copy_from_user(buffer, data, count);
> > -     if (ret)
> > +     if (ret) {
> >               dprintk(DEBUG_ERROR, "Problem copying from user\n");
> > -     else
> > +             return -EFAULT;
> > +     } else
> >               ret = v9fs_write(filp, buffer, count, offset);
> >
> >       kfree(buffer);
> 
> Aren't you leaking buffer in the error case?  Also we Linux people really
> hate an else clause when the if block contains a return statement ;-)
> 
>
