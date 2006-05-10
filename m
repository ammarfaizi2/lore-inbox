Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWEJV6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWEJV6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEJV6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:58:01 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:37965 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932305AbWEJV57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:57:59 -0400
X-IronPort-AV: i="4.05,111,1146466800"; 
   d="scan'208"; a="1803985337:sNHT30487936"
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 3/6] myri10ge - Driver header files
X-Message-Flag: Warning: May contain useful information
References: <446259A0.8050504@myri.com> <44625CD2.8040100@myri.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 14:57:57 -0700
In-Reply-To: <44625CD2.8040100@myri.com> (Brice Goglin's message of "Wed, 10 May 2006 23:36:18 +0200")
Message-ID: <adalkt97day.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 21:57:58.0462 (UTC) FILETIME=[CCA2B5E0:01C6747C]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few quick obvious comments:

 > +#ifdef MYRI10GE_MCP
 > +typedef signed char          int8_t;
 > +typedef signed short        int16_t;
 > +typedef signed int          int32_t;
 > +typedef signed long long    int64_t;
 > +typedef unsigned char       uint8_t;
 > +typedef unsigned short     uint16_t;
 > +typedef unsigned int       uint32_t;
 > +typedef unsigned long long uint64_t;
 > +#endif

What's this doing?  If you must use uintXX_t types the kernel already
has them.  Although it would be nicer to use u8, u16, etc.

 > +/* 8 Bytes */
 > +typedef struct
 > +{
 > +  uint32_t high;
 > +  uint32_t low;
 > +} mcp_dma_addr_t;

All of these typedefs are unnecessary.  In the kernel it's strongly
preferred to just do

struct mcp_dma_addr {
	u32 high;
        u32 low;
};

and then use "struct mcp_dma_addr" instead of "mcp_dma_addr_t".

Similarly for enums.  Just use "enum whatever" instead of "whatever_t".

BTW, indentation is busted in these headers too (two spaces instead of a tab).

 - R.
