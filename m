Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWCMXx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWCMXx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCMXx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:53:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750857AbWCMXx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:53:27 -0500
Date: Mon, 13 Mar 2006 15:50:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety
Message-Id: <20060313155058.1389ee9a.akpm@osdl.org>
In-Reply-To: <4415F87E.806@yahoo.com.au>
References: <20060313224344.9173.qmail@lwn.net>
	<4415F87E.806@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Jonathan Corbet wrote:
> 
> >I've been digging through the radix tree code, and I noticed that the
> >tag functions have an interesting limitation.  The tag is given as an
> >integer value, but, in reality, the only values that work are zero and
> >one.  Anything else will return random results or (when setting tags)
> >corrupt unrelated memory.

Various people at various times have added additional tags.  reiser4...

> >The number of radix tree users is small, so it's not hard to confirm
> >that all tag values currently in use are legal.  But the interface would
> >seem to invite mistakes.
> >
> >The following patch puts in checks for out-of-range tag values.  I've
> >elected to have the relevant call fail; one could argue that it should
> >BUG instead.  Either seems better than silently doing weird stuff.  Not
> >2.6.16 material, obviously, but maybe suitable thereafter.
> >
> >
> 
> I'd agree if you make them BUG_ON()s.
> 
> Andrew Morton's kind of the radix-tree tags guy though... Andrew?

I don't really see the need - if someone goes and overindexes the data
structure's capacity then they have a bug and hopefully that'll turn up in
testing and will get fixed.

Or am I missing something obvious which makes radix-trees particularly
dangerous or subtle??
