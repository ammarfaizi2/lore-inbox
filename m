Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVFWVxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVFWVxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWVtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:49:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17075 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262722AbVFWVpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:45:38 -0400
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka Enberg <penberg@gmail.com>
Cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f02050622130424379bf3@mail.gmail.com>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
	 <84144f02050622130424379bf3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119546538.17063.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Jun 2005 22:42:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +       if (check_region(TLCLK_BASE, 8)) {
> > +               printk(KERN_ERR
> > +                      "telclock: I/O region already used by another
> > driver!\n");
> > +               return -EBUSY;
> > +       } else {
> > +               request_region(TLCLK_BASE, 8, "telclock");
> 
> request_region can fail too so you'd better handle that.

check_region() is essentially historical. It used to be that
check_region could fail and request_region did not. Once modules arrived
it becomes possible for drivers to race each other for resources so
request_region now atomically (with respect to itself) checks and if
available allocates a region.

check_region() shouldn't be used except for special cases where you
really want to see a space is free without requesting it. Even then if
you need to do any operation on the space while it is free you need to
request/act/release the region nto check_region for it.

Alan

