Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbTHGTew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGTew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:34:52 -0400
Received: from host81-136-142-241.in-addr.btopenworld.com ([81.136.142.241]:9451
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S270373AbTHGTev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:34:51 -0400
Date: Thu, 7 Aug 2003 20:34:40 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <Pine.LNX.4.53.0308072029020.25538@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, Marcelo is right. I meant to imply that the new DRM module
from X cvs or http://dri.sourceforge.net/downloads.phtml needs
a recompile for the new vmap changes and that was the one that
i use and was working fine - i.e i couldn't reproduce the problem
reported. I didn't mean (or want to imply) that the vmap changes
could/should break the old kernel module. Irrespective i did think
the kernel drm tree needed updating.

Mitch

-------- Original Message --------
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Date: Thu, 7 Aug 2003 16:26:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,   Erik Andersen <andersen@codepoet.org>,   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk>
<Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>

> I dont understand how the vmap change can break DRM.
>
> The vmap patch only changes internal mm/vmalloc.c code (vmalloc() call
> acts exactly the same way as before AFAICS).
>
> Anyway, Mitch (or Erik who's seeing the problem), can please revert the
> vmap() change to check if its causing the mentioned problem?

vmap() doesn't break DRM.  The external drm code just detects that
vmap is present and then uses the new interface, but this new code
also expects a new exported symbol.

The DRM code in your tree is completly unaffected.

