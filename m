Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVIMGmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVIMGmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVIMGmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:42:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932386AbVIMGmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:42:37 -0400
Date: Mon, 12 Sep 2005 23:42:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, jirislaby@gmail.com,
       lion.vollnhals@web.de
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Message-Id: <20050912234200.10b2abe7.akpm@osdl.org>
In-Reply-To: <200509130033.11109.dtor_core@ameritech.net>
References: <200509130010.38483.lion.vollnhals@web.de>
	<43260817.7070907@gmail.com>
	<84144f0205091221431827b126@mail.gmail.com>
	<200509130033.11109.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Monday 12 September 2005 23:43, Pekka Enberg wrote:
> > On 9/13/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> > > >-      cls = kmalloc(sizeof(struct class), GFP_KERNEL);
> > > >+      cls = kzalloc(sizeof(struct class), GFP_KERNEL);
> > > >
> > > >
> > > maybe, the better way is to write `*cls' instead of `struct class',
> > > better for further changes
> > 
> > Please note that some maintainers don't like it. I at least could not
> > sneak in patches like these to drivers/usb/ because I had changed
> > sizeof.
> > 
> 
> And given the fact that Greg maintains driver core it probably won't be
> accepted here either :)
> 
> FWIW I also prefer spelling out the structure I am allocating.
> 

It hurts readability.  Quick question: is this code correct?

	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);

you don't know.  You have to go hunting down the declaration of `dev' to
find out.

