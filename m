Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVC3TmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVC3TmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVC3TmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:42:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:27050 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262392AbVC3Tl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:41:59 -0500
Date: Wed, 30 Mar 2005 21:44:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] Reduce stack usage in module.c
In-Reply-To: <424AE960.8020906@osdl.org>
Message-ID: <Pine.LNX.4.62.0503302139100.2463@dragon.hyggekrogen.localhost>
References: <df35dfeb05032823137a208b46@mail.gmail.com>  <424993B0.9010306@osdl.org>
 <df35dfeb050329222132823897@mail.gmail.com> <424AE960.8020906@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Randy.Dunlap wrote:

> Yum Rayan wrote:
> > On Tue, 29 Mar 2005 09:43:12 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > 
> > > Yum Rayan wrote:
> > > 
> > > > - do not write past array index for the boundary case
> > > 
> > > I don't see a boundary case problem with the current code,
> > > hence I don't see why the kmalloc(len + 1, GFP_KERNEL) is
> > > needed...
> > 
> > 
> >    1399 static void who_is_doing_it(void)
> >    1400 {
> >    1401         /* Print out all the args. */
> >    1402         char args[512];
> >    1403         unsigned long i, len = current->mm->arg_end -
> > current->mm->arg_start;
> >    1404
> >    1405         if (len > 512)
> >    1406                 len = 512;
> >    1407
> >    1408         len -= copy_from_user(args, (void
> > *)current->mm->arg_start, len);
> >    1409
> >    1410         for (i = 0; i < len; i++) {
> >    1411                 if (args[i] == '\0')
> >    1412                         args[i] = ' ';
> >    1413         }
> >    1414         args[i] = 0;
> >    1415         printk("ARGS: %s\n", args);
> >    1416 }
> > 
> > Let's consider the original code and len = 513
> > 
> > After lines 1410 thru 1413, "i" wil be 512. So line 1414 will be
> > "args[512] = 0". But args is 512 byte array with last legally
> > accessible element at 511?
> 
> Yes, it's so obvious (now).  :)
> 
Whoops, that boundary error is mine, sorry about that.

-- 
Jesper Juhl

