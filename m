Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJMTub>; Sun, 13 Oct 2002 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSJMTua>; Sun, 13 Oct 2002 15:50:30 -0400
Received: from holomorphy.com ([66.224.33.161]:62858 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261678AbSJMTu3>;
	Sun, 13 Oct 2002 15:50:29 -0400
Date: Sun, 13 Oct 2002 12:52:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
Message-ID: <20021013195236.GC27878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3DA7C3A5.98FCC13E@digeo.com> <20021013101949.GB2032@holomorphy.com> <3DA9B1A7.A747ADD6@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA9B1A7.A747ADD6@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> @@ -1104,6 +1126,7 @@ static void __init free_area_init_core(s
>>                         pcp->low = 0;
>>                         pcp->high = 32;
>>                         pcp->batch = 16;
>> +                       pcp->reserved = 0;
>>                         INIT_LIST_HEAD(&pcp->list);
>>                 }
>>                 INIT_LIST_HEAD(&zone->active_list);

On Sun, Oct 13, 2002 at 10:47:19AM -0700, Andrew Morton wrote:
> OK.  But that's been there since 2.5.40-mm2.  Why did it suddenly
> bite?

I must have been way too tired or something:

(1) It's embedded in struct zone, hence bootmem allocated, hence
	already zeroed.

(2) The logs still show the show_free_areas() call immediately after
	free_all_bootmem_core() seeing the garbage ->reserved values.

Bill
