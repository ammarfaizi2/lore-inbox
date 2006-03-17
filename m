Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWCQW23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWCQW23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWCQW23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:28:29 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:63914 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932272AbWCQW22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:28:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hV7SH2WSO/DWt0A6mh36FAczomxo5K8Y/ITdAEOdSkGQcxp26/KhZeIMUrv/uwcv8f0pY9hlPWDacwWeYSlI09OeRE48JK/VyeXpKev68SVC05zSURF8NkAMwGP575HFAiHoLsqNpPkm1xMNqV2BBwuPpXZoGLuZ3RZCfQvKY6E=  ;
Message-ID: <441B3807.8050307@yahoo.com.au>
Date: Sat, 18 Mar 2006 09:28:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>	 <ada4q27fban.fsf@cisco.com>	 <1141948516.10693.55.camel@serpentine.pathscale.com>	 <ada1wxbdv7a.fsf@cisco.com>	 <1141949262.10693.69.camel@serpentine.pathscale.com>	 <20060309163740.0b589ea4.akpm@osdl.org>	 <1142470579.6994.78.camel@localhost.localdomain>	 <ada3bhjuph2.fsf@cisco.com>	 <1142475069.6994.114.camel@localhost.localdomain>	 <adaslpjt8rg.fsf@cisco.com>	 <1142477579.6994.124.camel@localhost.localdomain>	 <20060315192813.71a5d31a.akpm@osdl.org>	 <1142485103.25297.13.camel@camp4.serpentine.com>	 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>	 <4419062C.6000803@yahoo.com.au>	 <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>	 <441A04D0.3060201@yahoo.com.au>	 <1142611861.28538.22.camel@serpentine.pathscale.com>	 <Pine.LNX.4.64.0603170825540.3618@g5.osdl.org> <1142613609.28538.47.camel@serpentine.pathscale.com>
In-Reply-To: <1142613609.28538.47.camel@serpentine.pathscale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> On Fri, 2006-03-17 at 08:28 -0800, Linus Torvalds wrote:
> 
> 
>>kmalloc may be backed by a "struct page", but the point is that it does 
>>not honor the page _count_, and as such it is totally unsuitable for any 
>>VM usage.
> 
> 
> That's fine.  We're not calling dma_free_coherent until after the page
> count goes back down to one (the driver is once again the only user).

And that's probably fine too (provided you can somehow be sure that
you're getting compound pages, which you currently can't) - you're
essentially doing your own refcounting then. However in that case you
do need to ensure get_user_pages can't operate on your mapping (use
VM_IO), because that can hijack the page lifetime (ie. hold a ref
even after all mappings have gone).

> But this doesn't seem germane to what Nick brought up, anyway.
> 

Well kmalloc is one of the possible problems I saw, but there may be
others too (eg. ioremap).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
