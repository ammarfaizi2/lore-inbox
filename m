Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUIQNAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUIQNAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268728AbUIQNAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:00:44 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:20699 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268726AbUIQNAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:00:38 -0400
From: Duncan Sands <baldrick@free.fr>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 15:00:35 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <200409171437.57766.baldrick@free.fr> <20040917124815.GE3089@crusoe.alcove-fr>
In-Reply-To: <20040917124815.GE3089@crusoe.alcove-fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409171500.35499.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 14:48, Stelian Pop wrote:
> On Fri, Sep 17, 2004 at 02:37:57PM +0200, Duncan Sands wrote:
> 
> > > + * Note that with only one concurrent reader and one concurrent 
> > > + * writer, you don't need extra locking to use these functions.
> >                                  ^^^^^ which functions? (ambiguous)
> 
> Well, the same comment is for two adjacent functions, so I don't
> think it's so ambiguous. Or s/these/this/ if you prefer.
> 
> > And what does "extra locking" mean?
> 
> Some kind of locking, like the one the wrapper kfifo_get/kfifo_put
> propose.
> 
> > > +	len = min(len, fifo->size - fifo->in + fifo->out);
> > 
> > After all, since you are reading both in and out here, some kind of
> > locking is needed.
> 
> But the order in which in and out get modified guarantees that you
> will still have a coherent content (provided the assignments are 
> atomic, which they are).

Hi Stelian, what is to stop the compiler putting, say, "in" in a register
for the process calling __kfifo_get, so that it only sees a constant
value.  Then after a while that process will think there is nothing
to get even though another process is shoving stuff into the fifo and
modifying "in".

By the way, the comment for __kfifo_get has a typo:

+ * kfifo_get - gets some data from the FIFO, no locking version
    ^^^^^^^^^ should be __kfifo_get

Ciao,

Duncan.
