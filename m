Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVHJNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVHJNNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVHJNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:13:05 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:41144 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965084AbVHJNNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:13:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cLsVFjn1f6zT+L1Vmzbyw7Pqd5a9A69kJGBG5Ep06Qywixk1lv6+YZB1QMugvlqzndjEi8NvPa9OYcBJdz210lj1Um2MgfbdQns/sWPEhtw59hN5rEJonNEu/NXt0nwUrYoxTOWjDeIFYEdMDk26YFurO4aJJySBLk02TmcdhY8=
Message-ID: <58cb370e050810061342fcd09a@mail.gmail.com>
Date: Wed, 10 Aug 2005 15:13:03 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, kiran@scalex86.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508100459.j7A4xTn7016128@hera.kernel.org>
	 <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be>
	 <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NAK

hwif can't be NULL or something is *really* wrong

On 8/10/05, Christoph Lameter <clameter@engr.sgi.com> wrote:
> On Wed, 10 Aug 2005, Geert Uytterhoeven wrote:
> 
> > On Tue, 9 Aug 2005, Linux Kernel Mailing List wrote:
> > > tree 518f62158f0923573decb8f072ac7282fb7575cb
> > > parent aeb3f76350e78aba90653b563de6677b442d21d6
> > > author Christoph Lameter <christoph@lameter.com> Wed, 10 Aug 2005 09:59:21 -0700
> > > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 10 Aug 2005 10:21:31 -0700
> > >
> > > [PATCH] Fix ide-disk.c oops caused by hwif == NULL
> >
> > How can this patch fix that? It still dereferences hwif without checking for a
> > NULL pointer.
> 
> Correct. So we need to indeed go back to a version that does check for
> NULL that I initially proposed.
> 
> Index: linux-2.6/include/linux/ide.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ide.h  2005-08-09 19:47:14.000000000 -0700
> +++ linux-2.6/include/linux/ide.h       2005-08-10 06:05:44.000000000 -0700
> @@ -1503,7 +1503,7 @@
> 
>  static inline int hwif_to_node(ide_hwif_t *hwif)
>  {
> -       if (hwif->pci_dev)
> +       if (hwif && hwif->pci_dev)
>                 return pcibus_to_node(hwif->pci_dev->bus);
>         else
>                 /* Add ways to determine the node of other busses here */
