Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUIERaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUIERaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUIERaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 13:30:05 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:59804 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266805AbUIER3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 13:29:54 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Date: Sun, 5 Sep 2004 10:27:59 -0700
User-Agent: KMail/1.7
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
References: <20040904102914.B13149@infradead.org> <9e47339104090508052850b649@mail.gmail.com> <1094398257.1251.25.camel@localhost.localdomain>
In-Reply-To: <1094398257.1251.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409051027.59244.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 5, 2004 8:31 am, Alan Cox wrote:
> The only glue structure you need for most of this is
>
> struct fb_device
> {
>  struct fb_info *fb; /* NULL or frame buffer device */
>  struct dri_whatever *dri;  /* As yet not nicely extracted DRI
>      object */
>  atomic_t refcnt;
>  void *private
> };
>
> Right now the drvdata for most PCI/AGP frame buffers is set to the
> fb_info. If that is set to the shared object then you can attach DRI and
> or FB first and they can find and call each others methods.
>
> It might also need a single lock just to avoid DRI deciding to go away
> while fb is calling dri and the reverse although I think the refcnt is
> easier and cheaper.
>
> With that in place if X tells DRI "640x480 starting here" then DRI can
> tell fb "640x480 starting here". Similarly fb and dri can find each
> other for acceleration and the kernel can become a DRI client for
> console acceleration.
>
> Once you have this object you can start attaching memory managers and
> mode setup pointers to the shared structure so that they live
> independantly.

So then this structure would represent a merged driver?  That is, you'd have a 
driver that attaches to display devices and creates this structure to manage 
fb and dri?

Jesse
