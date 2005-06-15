Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFOSaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFOSaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVFOSaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:30:35 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:39816 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261263AbVFOSaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:30:30 -0400
Message-ID: <42B073C1.3010908@yahoo.com.au>
Date: Thu, 16 Jun 2005 04:30:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
In-Reply-To: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> ------------------------------------------------------------------------
> 
> elm3b29 login: dd: page allocation failure. order:0, mode:0x20
> 
> Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
>        <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
>        <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}

They look like they're all in scsi_get_command.
I would consider masking off __GFP_HIGH in the gfp_mask of that
function, and setting __GFP_NOWARN. It looks like it has a mempoolish
thingy in there, so perhaps it shouldn't delve so far into reserves.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
