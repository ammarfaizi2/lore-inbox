Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWFSPks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWFSPks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWFSPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:40:48 -0400
Received: from relay02.pair.com ([209.68.5.16]:59400 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S964772AbWFSPkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:40:47 -0400
X-pair-Authenticated: 71.197.50.189
Date: Mon, 19 Jun 2006 10:32:36 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Michael Opdenacker <michael-lists@free-electrons.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Option to clear allocated kernel memory before freeing it?
In-Reply-To: <4496B92A.3010907@free-electrons.com>
Message-ID: <Pine.LNX.4.64.0606191028430.31355@turbotaz.ourhouse>
References: <4496B92A.3010907@free-electrons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Michael Opdenacker wrote:

> Hello,
>
> Would it make sense to implement a kernel option that would clear kernel 
> memory before freeing it (by kfree or free_page(s))?
>
> Unless I'm missing something, uncleared memory previously used for kernel 
> allocations could later be recycled for user allocations, making it possible 
> for a user program to access sensitive driver data if it's lucky.

No sane operating system lets user-space have access to pages that haven't 
been cleared.

> Tough clearing memory should be efficient (thanks to the use of memset(), 
> optimized for each platform), there would of course be a significant 
> performance hit. However, this could be acceptable for systems with strong 
> security requirements...

A better way (and I believe the way Linux does it) is to map new pages to 
the zero page, read-only. If the process attempts to write to the zero 
page, we take a page fault and set up a new zeroed page, change the 
mapping, and return control back to that process.

> What do you think? If this idea makes sense, I'll be glad to help in 
> implementing it.
>
>   Thanks in advance,
>
>   Cheers,
>
>   Michael.
>

Thanks,
Chase
