Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWC3S1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWC3S1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWC3S1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:27:46 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:45659 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751362AbWC3S1p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:27:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ku7S1JFhiQ4wpwk+R1+/8Z4yJkh8lTSuENDdeXN0rbpB8kpJI4kcb7Q/kK8Io825vfx//ExELbmj0Zii0vyh/Z+kNjvz6VU1SOFQuLnZR4kz/+22BcZ57ZRkFokOzwXOxooE4LxXzQygOM44a30h2fwdNIE8h9B4wXaleGKVki4=
Message-ID: <c0a09e5c0603301027j50f09acbq9ed2df95f80cfa8d@mail.gmail.com>
Date: Thu, 30 Mar 2006 10:27:44 -0800
From: "Andrew Grover" <andy.grover@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Cc: "Chris Leech" <christopher.leech@intel.com>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <F9901EAA-FA85-4C9C-94F5-BE6A9C62A4A4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060311022759.3950.58788.stgit@gitlost.site>
	 <20060311022919.3950.43835.stgit@gitlost.site>
	 <2FF801BB-F96C-4864-AC44-09B4B92531F7@kernel.crashing.org>
	 <c0a09e5c0603281044i57730c66ye08c45aadd352cf8@mail.gmail.com>
	 <D760971F-3C6A-400B-99EA-E95358B37F82@kernel.crashing.org>
	 <c0a09e5c0603281401uaeea6aci57054aef444a5e1@mail.gmail.com>
	 <3B202D51-1683-465D-AE3D-DE301017BD69@kernel.crashing.org>
	 <c0a09e5c0603291505h10f062d5qd6e1861ef052d07b@mail.gmail.com>
	 <F9901EAA-FA85-4C9C-94F5-BE6A9C62A4A4@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> I was under the impression that the DMA engine would provide a "sync"
> cpu based memcpy (PIO) if a real HW channel wasn't avail, if this is
> left to the client that's fine.  So how does the client know he
> should use normal memcpy()?

It has to keep track of what DMA channel to use, which it gets when
the channel ADDED callback happens. So it's basically

if (some_client_struct->dma_chan)
    dma_memcpy()
else
    memcpy()

The async memcpy has the added requirement that at some point the
client must verify the copies have been completed, so doing async
memcopies does require more work on the client's part.

> Sounds good for a start.  Have you given any thoughts on handling
> priorities between clients?
>
> I need to take a look at the latest patches. How would you guys like
> modifications?

Haven't given any thought to priorities yet -- we've been focusing on
getting the 1 client case to perform well. :)

Chris posted a link to this: git://198.78.49.142/~cleech/linux-2.6
branch ioat-2.6.17

So you can post patches against that, or the patches posted here apply
against davem's git tree.

Regards -- Andy
