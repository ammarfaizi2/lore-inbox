Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVALWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVALWcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVALWaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:30:21 -0500
Received: from quark.didntduck.org ([69.55.226.66]:38865 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261524AbVALWVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:21:25 -0500
Message-ID: <41E5A2F6.8070704@didntduck.org>
Date: Wed, 12 Jan 2005 17:21:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>
Subject: Re: inter_module_get and __symbol_get
References: <20050106213225.GJ6184@hygelac> <41DDB465.8000705@didntduck.org> <20050106225140.GO6184@hygelac> <9e4733910501072000491d6c04@mail.gmail.com> <20050112193727.GM1933@hygelac>
In-Reply-To: <20050112193727.GM1933@hygelac>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> it would seem like the old mechanism was preferable, but perhaps I'm
> missing something. in this particular case, there are times when a user
> wants to avoid using agp at all for testing purposes, but if I
> understand correctly, we'll be forced to load agpgart anyways due to
> unresolved symbols.

In 2.6, the "agpgart" module is just the core.  Without a gart driver 
loaded (via-agp for example), it does nothing.  If you really don't want 
to have the hard dependency on agpgart, make the code using it 
conditionally compile on CONFIG_AGP or something.

> but I think Keith Owens was correct in his larger picture view that
> this mechanism is useful for much more than just agp. I'm just
> confused why it was regressed from a non-gpl symbol to a gpl symbol
> (or more appropriately why the non-gpl symbol was regressed in favor
> of a gpl-only symbol).

symbol_get in it's current form is hard-coded to look for GPL symbols, 
hence it is exported GPL only.  I have a rough patch that will allow 
symbol_get to use the license status of its caller to determine which 
symbols it can find.  However this depends on whether or not 
symbol_get() is removed like some people want.

--
				Brian Gerst
