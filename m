Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262086AbSIYUvq>; Wed, 25 Sep 2002 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbSIYUvq>; Wed, 25 Sep 2002 16:51:46 -0400
Received: from ns.splentec.com ([209.47.35.194]:25614 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262086AbSIYUvq>;
	Wed, 25 Sep 2002 16:51:46 -0400
Message-ID: <3D922313.24B59088@splentec.com>
Date: Wed, 25 Sep 2002 16:56:51 -0400
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: struct page question
References: <3D90D4AB.B0BDF702@splentec.com> <20020925073430.GG15479@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> > Apparently I cannot just set b_data and b_size, b_page
> > also has to be set and it also seems that it will
> > not work if page_address(b_page) != b_data...
> 
> bh->b_page = virt_to_page(va);
> bh->b_data = va;

Thanks Jens again.

My doubts are that va might not point to page->virtual,
but may point ``in the middle'' of the page, in which case
md will cough up since it does the page_address(b_page) != b_data
then BUG()...

I.e. I cannot guarantee about where va points (just that it is NOT
highmem).

-- 
Luben
