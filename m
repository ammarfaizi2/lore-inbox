Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTLGRuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTLGRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:50:24 -0500
Received: from holomorphy.com ([199.26.172.102]:22745 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264468AbTLGRuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:50:19 -0500
Date: Sun, 7 Dec 2003 09:50:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: Re: aio on ramfs
Message-ID: <20031207175013.GF14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	linux-aio@kvack.org
References: <20031207083432.GP19856@holomorphy.com> <87ptf0h6h8.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ptf0h6h8.fsf@devron.myhome.or.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> +static int ramfs_writepage(struct page *page, struct writeback_control *wbc)
>> +{
>> +	return 0;
>> +}

On Mon, Dec 08, 2003 at 02:40:03AM +0900, OGAWA Hirofumi wrote:
> Doesn't this break the magic of shrink_list()? I think it need the
> "return WRITEPAGE_ACTIVATE;" at least.

In truth these things shouldn't be on the LRU at all, though they're
probably blindly plopped down there. My handwavy argument was that it
makes no sense to do anything with it on the LRU and that I'd nopped
out ->set_page_dirty() anyhow (i.e. PG_dirty should never get set). Does
that hold enough water or should I still hand back WRITEPAGE_ACTIVATE?


-- wli
