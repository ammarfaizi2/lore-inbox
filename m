Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVBBHXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVBBHXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBBHXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:23:51 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:59351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262127AbVBBHXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:23:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=P0pYXOEp0Xx3O/33bY8kw1AOXS3KMm6lhTkJzVOiUlFHlBVLtR/kHeMTkZj+9dKbxhc3r2Q30TIp6Lavub3hx3R1uORl/pd+ObPuG0R+SuFmoSICL8MFHd1UzgV3Em5uOP8iju7uSVz4C8yhrSBEqPofzHiYJgJKFNX6ZD9iXWQ=
Message-ID: <84144f02050201232324bebb3f@mail.gmail.com>
Date: Wed, 2 Feb 2005 09:23:48 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6] 1/7 create kstrdup library function
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-Reply-To: <41FFB5A1.20100@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1107228501.41fef755e66e8@webmail.grupopie.com>
	 <84144f0205020108441679cbef@mail.gmail.com>
	 <41FFB5A1.20100@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in time, I wrote:
> > kstrdup() is a special-case _memory allocator_ (not so much a string
> > operation) so I think it should go into mm/slab.c where we currently
> > have kcalloc().

On Tue, 01 Feb 2005 17:00:17 +0000, Paulo Marques <pmarques@grupopie.com> wrote:
> I was following Rusty Russell's approach. Also, I believe this is more
> intuitive because the standard libc strdup function is declared in string.h.
> 
> However, I really don't have strong feelings either way, so if the
> majority agrees that this should be in mm/slab, its fine by me.

Intuitive, perhaps, but I think it's wrong. I don't like it because it
makes string operations depend on slab. Furthermore, kstrdup() is not
a string operation. It is about memory allocation, really, just like
kcalloc().

One possible way to clean this up would be to extract the
standard-like allocators (kmalloc, kcalloc, and kstrdup) from
mm/slab.c and move them into a separate file.

                          Pekka
