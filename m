Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUIQNFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUIQNFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUIQNFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:05:39 -0400
Received: from sd291.sivit.org ([194.146.225.122]:63201 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268729AbUIQNFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:05:35 -0400
Date: Fri, 17 Sep 2004 15:05:32 +0200
From: Stelian Pop <stelian@popies.net>
To: Duncan Sands <baldrick@free.fr>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917130532.GA22386@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Duncan Sands <baldrick@free.fr>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <200409171437.57766.baldrick@free.fr> <20040917124815.GE3089@crusoe.alcove-fr> <200409171500.35499.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171500.35499.baldrick@free.fr>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:00:35PM +0200, Duncan Sands wrote:

> > But the order in which in and out get modified guarantees that you
> > will still have a coherent content (provided the assignments are 
> > atomic, which they are).
> 
> Hi Stelian, what is to stop the compiler putting, say, "in" in a register
> for the process calling __kfifo_get, so that it only sees a constant
> value.  Then after a while that process will think there is nothing
> to get even though another process is shoving stuff into the fifo and
> modifying "in".

This can happen all right, but the buffer (or the indices) will not
get corrupt (this is what I call coherent). Its just like the __kfifo_get()
was executed entirely before the __kfifo_put().

There is no problem here.

> 
> By the way, the comment for __kfifo_get has a typo:
> 
> + * kfifo_get - gets some data from the FIFO, no locking version
>     ^^^^^^^^^ should be __kfifo_get

Same for kfifo_len, too much cut & paste here. Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
