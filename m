Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWCQWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWCQWVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWCQWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:21:42 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:43344 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751570AbWCQWVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:21:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l6wsVdIkomJ+yRbMs0xc7/bNQhjNimy3co3iEgPpCI29F975hMSpTz7RYDpLw9gSFwnCcyV/nmlouA4NisjP0CIfTuwuv4jfCbNvu+19Kv5EsrYUDS9a+HVo8s2EXJ1LMaWjF7NjZLo0S7tfrOa7T/yFc9L2rny6syKDpd0QsP8=  ;
Message-ID: <441B3670.5010502@yahoo.com.au>
Date: Sat, 18 Mar 2006 09:21:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com> <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com> <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain> <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain> <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain> <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com> <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com> <4419062C.6000803@yahoo.com.au> <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com> <441A04D0.3060201@yahoo.com.au> <Pine.LNX.4.61.0603171440570.31402@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603171440570.31402@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not a driver or pci/dma person either, so I can't usefully answer
most of your questions, I'm afraid]

Hugh Dickins wrote:

> Is there any chance that your split_page() work in -mm, actually addresses
> precisely those places that were screwed up by universal compound pages?
> So that with your split_page(), we could go back to every >0-order page
> being PageCompound, without any need for __GFP_COMP.
> 

I think it should catch most of the places [I'm sure I've missed some :(]
that split up higher-order pages (which doesn't work on compound pages, I
guess this was the problem).

It makes like difficult for some future patch of mine if the refcounting
mechanism is changed while the page is allocated (eg. like PageReserved
used to do), however I think it wouldn't be too hard to instead invert the
meaning of the flag and just use it in those few places that care?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
