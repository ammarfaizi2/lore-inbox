Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUIQMrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUIQMrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIQMrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:47:37 -0400
Received: from sd291.sivit.org ([194.146.225.122]:60128 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268397AbUIQMrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:47:35 -0400
Date: Fri, 17 Sep 2004 14:48:15 +0200
From: Stelian Pop <stelian@popies.net>
To: Duncan Sands <baldrick@free.fr>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917124815.GE3089@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Duncan Sands <baldrick@free.fr>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr> <200409171437.57766.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171437.57766.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 02:37:57PM +0200, Duncan Sands wrote:

> > + * Note that with only one concurrent reader and one concurrent 
> > + * writer, you don't need extra locking to use these functions.
>                                  ^^^^^ which functions? (ambiguous)

Well, the same comment is for two adjacent functions, so I don't
think it's so ambiguous. Or s/these/this/ if you prefer.

> And what does "extra locking" mean?

Some kind of locking, like the one the wrapper kfifo_get/kfifo_put
propose.

> > +	len = min(len, fifo->size - fifo->in + fifo->out);
> 
> After all, since you are reading both in and out here, some kind of
> locking is needed.

But the order in which in and out get modified guarantees that you
will still have a coherent content (provided the assignments are 
atomic, which they are).

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
