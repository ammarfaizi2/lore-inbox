Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKFGkT>; Mon, 6 Nov 2000 01:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129717AbQKFGj7>; Mon, 6 Nov 2000 01:39:59 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:25094 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129036AbQKFGjv>; Mon, 6 Nov 2000 01:39:51 -0500
Date: Mon, 6 Nov 2000 06:39:34 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <2508.973474129@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0011060633320.14068-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Keith Owens wrote:

> On Mon, 6 Nov 2000 00:54:51 +0000 (GMT), 
> David Woodhouse <dwmw2@infradead.org> wrote:
> >On Mon, 6 Nov 2000, Keith Owens wrote:
> >
> >> I'm not sure why you think this can be used for module persistent
> >> storage.  If a module calls inter_module_register() on load, it should
> >> call inter_module_unregister() on unload.  All the registered data
> >> points into the loaded module, remove the module and the storage
> >> disappears as well.
> >
> >You can kmalloc() both the im_name and userdata arguments to
> >inter_module_register and you ought to be able to pass NULL as the owner.
> 
> Ughh!  That is definitely abusing the inter_module functions.  If we
> need persistent module storage then we should add a clean interface to
> do it instead of using kmalloc and overloading inter_module_xxx.

Why? It's got to get kmalloc'd anyway, and code reuse is
_good_. Experiment with different names for inter_module_xxx until you
feel happier :)

> What do people think, do we need module persistent storage? 

The primary reason that I've often lamented its removal is for
auto-loaded sound drivers to store their mixer level on unload, in order
to reset to the same values upon being reloaded.

> This will probably be a 2.5 change but I want to get an idea of the
> requirements before coding anything.

Strictly speaking, all the inter_module_xxx stuff should probably wait for
2.5.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
