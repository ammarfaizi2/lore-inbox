Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVLRR1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVLRR1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVLRR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:27:40 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:57735 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965234AbVLRR1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:27:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pFPlZ8rIC6RA+Tt8PelfPl1p7eciK0ekQx5xujzwEOb3gB2NIjAPLG+otIsmwt79RTGNiEzLnMNizwj+blXOZHlZtjfiiZhzbhLKNxQeu8/hkEXE5UeMwVyoqui34bASQJCno5MWI0WAynUPzn+NLQzX1b13i1GZSFxy7TuB848=
Message-ID: <84144f020512180927lc6492abpb28c047f9e0c535c@mail.gmail.com>
Date: Sun, 18 Dec 2005 19:27:38 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] micro optimization of cache_estimate in slab.c
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1134894189.13138.208.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1134894189.13138.208.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 12/18/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> +       do {
> +               x = 1;
> +               while ((x+i)*size + ALIGN(base+(x+i)*extra, align) <= wastage)
> +                       x <<= 1;
> +               i += (x >> 1);
> +       } while (x > 1);

The above is pretty hard to read. Perhaps we could give x and i better
names? Also, couldn't we move left part of the expression into a
separate static inline function for readability?

                              Pekka
