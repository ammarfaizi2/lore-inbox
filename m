Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVAYUq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVAYUq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVAYUqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:46:55 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46568 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262124AbVAYUqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:46:08 -0500
Date: Wed, 26 Jan 2005 00:08:18 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050126000818.041ec09d@zanzibar.2ka.mipt.ru>
In-Reply-To: <41F66799.5050004@grupopie.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050125125323.GA19055@infradead.org>
	<1106662284.5257.53.camel@uganda>
	<20050125142356.GA20206@infradead.org>
	<1106666690.5257.97.camel@uganda>
	<41F66799.5050004@grupopie.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 15:36:57 +0000
Paulo Marques <pmarques@grupopie.com> wrote:

> Evgeniy Polyakov wrote:
> > [...]
> > No, it is not called lock order reversal.
> > 
> > There are no places like
> > lock a
> > lock b
> > unlock a
> > unlock b
> 
> This would be perfectly fine. The order of unlocking doesn't really 
> matter. It is the actual locking that must be carried out on the same 
> order everywhere to guarantee that there are no deadlocks.

It is bad style, and since unlocking changes the order someone
may pass wrong locking.

> > and if they are, then I'm completely wrong.
> > 
> > What you see is only following:
> > 
> > place 1:
> > lock a
> > lock b
> > unlock b
> > lock c
> > unlock c
> > unlock a
> > 
> > place 2:
> > lock b
> > lock a
> > unlock a
> > lock c
> > unlock c
> > unlock b
> 
> I haven't look at the code yet, but this is a deadlock waiting to 
> happen. "place 1" gets "lock a", then is interrupted and "place 2" gets 
> "lock b". "place 2" waits forever for "lock a" and "place 1" waits 
> forever for "lock b". Deadlock.

As I said, that pathes are mutually exclusive - common pathes are guarded
by one lock always.

> -- 
> Paulo Marques - www.grupopie.com
> 
> "A journey of a thousand miles begins with a single step."
> Lao-tzu, The Way of Lao-tzu


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
