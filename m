Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUENDTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUENDTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENDTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:19:11 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:62392 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264352AbUENDTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:19:03 -0400
Message-ID: <40A43152.4090400@yahoo.com.au>
Date: Fri, 14 May 2004 12:39:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hugh@veritas.com, viro@parcelfarce.linux.theplanet.co.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au> <20040513193328.11479d3e.akpm@osdl.org>
In-Reply-To: <20040513193328.11479d3e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>> OK, I made a debug patch to printk and schedule_timeout in this
>> race window so I can easily truncate the file. When this happens,
>> it turns out that the readpage thinks it is reading a hole and
>> fills the page with zeros -> invalid result?
> 
> 
> A zero-filled pagecache page outside i_size is OK.
> 

Yes. But in this case the zero filled page actually gets
read by read(2).

In any case, I think my patch won't close the race completely.
