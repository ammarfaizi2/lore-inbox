Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUC2XJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUC2XJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:09:49 -0500
Received: from holomorphy.com ([207.189.100.168]:27806 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262215AbUC2XIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:08:10 -0500
Date: Mon, 29 Mar 2004 15:08:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       vrajesh@umich.edu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329230800.GT791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, vrajesh@umich.edu,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040329124027.36335d93.akpm@osdl.org> <Pine.LNX.4.44.0403292312170.19944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403292312170.19944-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Andrew Morton wrote:
>> hmm, yes, we have pages which satisfy PageSwapCache(), but which are not
>> actually in swapcache.
>> 
>> How about we use the normal pagecache APIs for this?
>> 
>> +	add_to_page_cache(page, &swapper_space, entry.val, GFP_NOIO);
>>...  
>> +	remove_from_page_cache(page);

On Mon, Mar 29, 2004 at 11:24:58PM +0100, Hugh Dickins wrote:
> Much nicer, and it'll probably appear to work: but (also untested)
> I bet you'll need an additional page_cache_release(page) - damn,
> looks like hugetlbfs has found a use for that tiresome asymmetry.
> Hugh

The good news is that the use isn't particularly essential.


-- wli
