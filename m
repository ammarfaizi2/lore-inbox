Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWCPC2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCPC2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWCPC2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:28:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750976AbWCPC2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:28:54 -0500
Date: Wed, 15 Mar 2006 18:28:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142470579.6994.78.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603151824020.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2006, Bryan O'Sullivan wrote:
> 
> I don't know what to to protect chip memory that I'm mapping into
> userspace.
> 
> I think I shouldn't be calling SetPageReserved at all, but I don't know
> what I should be doing instead.  Naively using get_page instead just
> gets me a big crash.

You should just use "remap_pfn_range()", and new kernels will just 
automatically DTRT.

For true chip memory (ie no RAM), even old kernels don't want any 
SetPageReserved() games, since there are no actual real real RAM pages for 
them - in fact, you shouldn't have any "struct page" to mark reserved - 
but if you allocate regular RAM you might want to mark such pages 
reserved.

(The current VM no longer needs it or even cares, but that is needed for 
older kernels).

			Linus
