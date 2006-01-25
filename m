Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWAYKaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWAYKaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWAYKaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:30:06 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:45499 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbWAYKaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:30:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uimhAgsvb2TXcxafXzNj4GhTq/tQTDRMbvqjrASobP8WB+lRtULc+qv88eIS9WfLxokHNX7GGqiVJ+4xKHm7/u/jhYuw9MIxNBCnjtL4lL82wZtj19pE6mZusrRK+QPq0CLY1CCVMVNAMbW+hJpxR3YjEWAOvsm3lNnkwKPo/LU=
Message-ID: <84144f020601250230s2d5da5d9jf11f754f184d495b@mail.gmail.com>
Date: Wed, 25 Jan 2006 12:30:03 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] non-refcounted pages, application to slab?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <20060125093909.GE32653@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125093909.GE32653@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 1/25/06, Nick Piggin <npiggin@suse.de> wrote:
> This is probably not worthwhile for most cases, but slab did strike me
> as a potential candidate (however the complication here is that some
> code I think uses the refcount of underlying pages of slab allocations
> eg nommu code). So it is not a complete patch, but I wonder if anyone
> thinks the savings might be worth the complexity?
>
> Is there any particular code that is really heavy on slab allocations?
> That isn't mostly handled by the slab's internal freelists?

I certainly hope not. For heavy users, the slab allocator should grow
caches enough to satisfy most allocations from the them. Also, I think
we want to keep the reference counting for slab pages so that we can
use kmalloc'd memory in the block layer.

                                Pekka
