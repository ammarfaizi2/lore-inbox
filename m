Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131943AbRANUQA>; Sun, 14 Jan 2001 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135244AbRANUPv>; Sun, 14 Jan 2001 15:15:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9995 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131943AbRANUPk>; Sun, 14 Jan 2001 15:15:40 -0500
Date: Sun, 14 Jan 2001 12:15:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.30.0101141927200.18971-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101141209030.4086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, David Woodhouse wrote:
> 
> But in the case of the CFI probe code and also I believe DRM, we don't
> actually know precisely which feature we're going to require until we've
> done the hardware probe at runtime.

That's ok.

This is what "request_module()" and "kmod" is all about. Once we probe the
hardware, the drievr itself can ask for more drivers.

I completely fail to see the arguments that have been brought up for drm
doing ugly things. The code should simply do

	drm_agp_head_t * head = inter_module_get("drm_agp");

	if (!head) {
		request_module("drm-agp");
		head = inter_module_get("drm_agp");
		if (!head)
			return -ENOAGP;
	}

and be done with it. THE ABOVE MAKES SENSE. The code says _exactly_ what
the module wants to do: it wants to find the AGP support, and if it cannot
find the AGP support it wants to load them.

The arguments about how the user should load things in some specific order
or whatever are complete crap. All the support is there, and whining about
it is not going to change my opinion in the least.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
