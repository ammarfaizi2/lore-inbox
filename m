Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUIEGUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUIEGUh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUIEGUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:20:37 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:63162 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266249AbUIEGUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:20:35 -0400
Message-ID: <413AB023.1010404@yahoo.com.au>
Date: Sun, 05 Sep 2004 16:20:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] teach kswapd about watermarks
References: <413AA7B2.4000907@yahoo.com.au>	<413AA7F8.3050706@yahoo.com.au>	<413AA841.1040003@yahoo.com.au>	<413AA879.9020105@yahoo.com.au> <20040904230436.1604215a.davem@davemloft.net>
In-Reply-To: <20040904230436.1604215a.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> If you're only doing atomic_set() and atomic_read() on kswapd_max_order,
> you're not doing anything atomic on the datum so no need to make it
> an atomic_t.
> 

OK, sure. And yes, anything other than loads and stores on that
value would never be correct.

There is still the small race of two threads updating the value,
but that doesn't matter (and the atomics don't help there anyway
of course).

