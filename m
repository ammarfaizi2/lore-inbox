Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUFNCIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUFNCIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUFNCIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 22:08:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16053 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261682AbUFNCIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 22:08:34 -0400
Date: Sun, 13 Jun 2004 19:08:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>, arjanv@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4]Diskdump Update
Message-ID: <3280000.1087178908@[10.10.2.4]>
In-Reply-To: <ACC451B04FA428indou.takao@soft.fujitsu.com>
References: <78040000.1086967058@[10.10.2.4]> <ACC451B04FA428indou.takao@soft.fujitsu.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ok, I fix it.
>>> 
>>> -		page = mem_map + nr;
>>> +		page = pfn_to_page(nr);
>> 
>> That's correct now ...
>> 
>>> I also need fix this.
>>> 
>>> -	for (nr = 0; nr < max_mapnr; nr++) {
>>> +	for (nr = 0; nr < max_pfn; nr++) {
>> 
>> ... but that's not (at least AFAICS from this snippet). You need to iterate 
>> over pgdats, and then over the lmem_map inside each pgdat.
> 
> How about this?
> 
> for_each_pgdat(pgdat) {
> 	for (i = 0; i < pgdat->node_spanned_pages; ++i) {
> 		page = pgdat->node_mem_map + i;
> 		...
>         }
> }

Yes, looks OK. I started writing out what it'd take to use the actual
pfn_to_page macros, but it just makes a mess ... what you have is fine.

M.

