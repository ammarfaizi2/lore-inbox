Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUHZPwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUHZPwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUHZPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:51:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11404 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269066AbUHZPux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:50:53 -0400
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <412DD1AA.8080408@jp.fujitsu.com>
References: <412DD1AA.8080408@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093535402.2984.11.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 08:50:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 05:03, Hiroyuki KAMEZAWA wrote:
> -		MARK_USED(index + size, high, area);
> +		page[size].flags |= (1 << PG_private);
> +		page[size].private = high;
>   	}
>   	return page;
>   }
...
> +		/* Atomic operation is needless here */
> +		page->flags &= ~(1 << PG_private);

See linux/page_flags.h:

#define SetPagePrivate(page)    set_bit(PG_private, &(page)->flags)
#define ClearPagePrivate(page)  clear_bit(PG_private, &(page)->flags)
#define PagePrivate(page)       test_bit(PG_private, &(page)->flags)

-- Dave

