Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUFNBhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUFNBhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 21:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUFNBhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 21:37:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35748 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261563AbUFNBhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 21:37:21 -0400
Date: Mon, 14 Jun 2004 10:38:36 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 1/4]Diskdump Update
In-reply-to: <78040000.1086967058@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-id: <ACC451B04FA428indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <78040000.1086967058@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Jun 2004 08:17:40 -0700, "Martin J. Bligh" wrote:

>> Ok, I fix it.
>> 
>> -		page = mem_map + nr;
>> +		page = pfn_to_page(nr);
>
>That's correct now ...
>
>> I also need fix this.
>> 
>> -	for (nr = 0; nr < max_mapnr; nr++) {
>> +	for (nr = 0; nr < max_pfn; nr++) {
>
>... but that's not (at least AFAICS from this snippet). You need to iterate 
>over pgdats, and then over the lmem_map inside each pgdat.

How about this?

for_each_pgdat(pgdat) {
	for (i = 0; i < pgdat->node_spanned_pages; ++i) {
		page = pgdat->node_mem_map + i;
		...
        }
}

