Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbTILMK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTILMK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:10:59 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:18445 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261383AbTILMK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:10:57 -0400
Date: Fri, 12 Sep 2003 09:12:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Pascal Schmidt <der.eremit@email.de>, Andrew Morton <akpm@osdl.org>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, <riel@redhat.com>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
In-Reply-To: <1062105549.17230.421.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.44.0309120911050.26669-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Aug 2003, Stephen C. Tweedie wrote:

> Hi,
> 
> On Thu, 2003-08-28 at 14:57, Pascal Schmidt wrote:
> 
> > > Many thanks --- I was able to reproduce this very easily, and I know of
> > > one or two very unusual things that fsx does which might well be the
> > > trigger here.  I'll let you know how things go.
> > 
> > Good, at least it's not a bug that only happens here and is hard to
> > reproduce elsewhere.
> > 
> > I hope this does not happen under normal fs usage. ;)
> 
> It's all down to ext3_writepage() using data-journaling rather than
> metadata journaling.  
> 
> The obvious fix is just to make the journal_dirty_async_data() code
> commit its writes as metadata if the inode is marked for
> data-journaling, and to set the transaction handle to be synchronous in
> that case.  Sounds like a recipe for deadlock if done incorrectly,
> though, so I'll give it a more careful look tomorrow.

Hello Stephen, 

Whats the status of this? 

You told me the other day you knew how to fix but needed some more 
thoughs...

Thanks 


